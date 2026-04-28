from __future__ import annotations

import gc
from pathlib import Path
from typing import cast

from PyQt6.QtCore import QItemSelection, QItemSelectionModel, Qt, QThread
from PyQt6.QtGui import QAction, QCloseEvent, QKeySequence
from PyQt6.QtWidgets import (
    QButtonGroup,
    QCheckBox,
    QComboBox,
    QDockWidget,
    QFileDialog,
    QFormLayout,
    QHBoxLayout,
    QLabel,
    QMainWindow,
    QMessageBox,
    QProgressBar,
    QPushButton,
    QSpinBox,
    QStackedWidget,
    QStatusBar,
    QTableView,
    QToolBar,
    QVBoxLayout,
    QWidget,
)

from woodeye_alignment.core.export import ExportConfig, ExportResult
from woodeye_alignment.core.feature_snap import FeaturePolarity, snap_to_feature_centroid
from woodeye_alignment.core.filename_parser import parse_face_and_beam_id
from woodeye_alignment.core.io import ImageArray, read_image
from woodeye_alignment.core.points_io import load_points, make_points_file, save_points
from woodeye_alignment.core.schemas import FaceName, SplitName, TransformType
from woodeye_alignment.core.transforms import FitResult, fit_transform, residual_status
from woodeye_alignment.core.warp import warp_to_reference
from woodeye_alignment.ui.batch_panel import BatchPanel
from woodeye_alignment.ui.beams_dock import BeamsDockWidget
from woodeye_alignment.ui.image_view import ImageView
from woodeye_alignment.ui.overlay_renderer import render_overlay
from woodeye_alignment.ui.points_table import PointsTableModel
from woodeye_alignment.ui.residuals_plot import ResidualsPlot
from woodeye_alignment.ui.workers import ExportJob, ExportWorker


class MainWindow(QMainWindow):
    def __init__(self) -> None:
        super().__init__()
        self.setWindowTitle("WoodEye Alignment")
        self.optical_image: ImageArray | None = None
        self.ct_image: ImageArray | None = None
        self.optical_path: Path | None = None
        self.ct_path: Path | None = None
        self.output_root: Path | None = None
        self.beam_id = "beam"
        self.fixed_pts: list[tuple[float, float]] = []
        self.moving_pts: list[tuple[float, float]] = []
        self.residuals: list[float] = []
        self.fit: FitResult | None = None
        self.placement_state: str | None = None
        self.pending_fixed: tuple[float, float] | None = None
        self._export_thread: QThread | None = None
        self._export_worker: ExportWorker | None = None

        self._build_actions()
        self._build_ui()
        self._wire_signals()
        self._update_status("Ready")

    def _build_actions(self) -> None:
        self.load_optical_action = QAction("Load optical...", self)
        self.load_ct_action = QAction("Load CT...", self)
        self.clear_scans_action = QAction("Clear scans", self)
        self.add_pair_action = QAction("Add pair", self)
        self.add_pair_action.setShortcut(QKeySequence("A"))
        self.delete_action = QAction("Delete selected", self)
        self.delete_action.setShortcut(QKeySequence.StandardKey.Delete)
        self.clear_action = QAction("Clear all", self)
        self.compute_action = QAction("Compute", self)
        self.compute_action.setShortcut(QKeySequence("C"))
        self.save_points_action = QAction("Save points...", self)
        self.save_points_action.setShortcut(QKeySequence("S"))
        self.load_points_action = QAction("Load points...", self)
        self.pick_output_action = QAction("Pick output...", self)
        self.generate_action = QAction("Generate", self)
        self.generate_action.setShortcut(QKeySequence("G"))

    def _build_ui(self) -> None:
        toolbar = QToolBar("Main")
        self.addToolBar(toolbar)
        for action in [
            self.load_optical_action,
            self.load_ct_action,
            self.clear_scans_action,
            self.add_pair_action,
            self.delete_action,
            self.clear_action,
            self.compute_action,
            self.save_points_action,
            self.load_points_action,
            self.pick_output_action,
            self.generate_action,
        ]:
            toolbar.addAction(action)

        self.optical_label = QLabel("Optical: -")
        self.ct_label = QLabel("CT: -")
        self.optical_view = ImageView("Optical")
        self.ct_view = ImageView("CT")
        views_layout = QHBoxLayout()
        views_layout.addWidget(self.optical_view, 1)
        views_layout.addWidget(self.ct_view, 1)
        mark_widget = QWidget()
        mark_widget.setLayout(views_layout)

        self.verify_view = ImageView("Verify")
        self.stack = QStackedWidget()
        self.stack.addWidget(mark_widget)
        self.stack.addWidget(self.verify_view)

        self.mark_button = QPushButton("Mark")
        self.verify_button = QPushButton("Verify")
        self.mark_button.setCheckable(True)
        self.verify_button.setCheckable(True)
        self.mark_button.setChecked(True)
        self.mode_group = QButtonGroup(self)
        self.mode_group.addButton(self.mark_button, 0)
        self.mode_group.addButton(self.verify_button, 1)

        self.table_model = PointsTableModel()
        self.points_table = QTableView()
        self.points_table.setModel(self.table_model)
        self.points_table.setSelectionBehavior(QTableView.SelectionBehavior.SelectRows)
        self.points_table.setSelectionMode(QTableView.SelectionMode.SingleSelection)
        self.points_table.setSortingEnabled(False)

        central_layout = QVBoxLayout()
        top_line = QHBoxLayout()
        top_line.addWidget(self.optical_label)
        top_line.addWidget(self.ct_label)
        top_line.addStretch(1)
        top_line.addWidget(self.mark_button)
        top_line.addWidget(self.verify_button)
        central_layout.addLayout(top_line)
        central_layout.addWidget(self.stack, 5)
        central_layout.addWidget(self.points_table, 2)
        central = QWidget()
        central.setLayout(central_layout)
        self.setCentralWidget(central)

        settings = QWidget()
        settings_layout = QFormLayout(settings)
        self.transform_combo = QComboBox()
        self.transform_combo.addItems(["euclidean", "similarity", "affine", "projective"])
        self.transform_combo.setCurrentText("similarity")
        self.stride_spin = QSpinBox()
        self.stride_spin.setRange(32, 1024)
        self.stride_spin.setValue(256)
        self.patch_spin = QSpinBox()
        self.patch_spin.setRange(64, 4096)
        self.patch_spin.setValue(512)
        self.face_combo = QComboBox()
        self.face_combo.addItems(["Top", "Bottom", "Left", "Right"])
        self.split_combo = QComboBox()
        self.split_combo.addItems(["train", "val", "test"])
        self.snap_check = QCheckBox("Snap placed clicks")
        self.snap_radius_spin = QSpinBox()
        self.snap_radius_spin.setRange(3, 100)
        self.snap_radius_spin.setValue(25)
        self.snap_polarity_combo = QComboBox()
        self.snap_polarity_combo.addItems(["auto", "bright", "dark"])
        self.residuals_plot = ResidualsPlot()
        settings_layout.addRow("Transform", self.transform_combo)
        settings_layout.addRow("Stride", self.stride_spin)
        settings_layout.addRow("Patch", self.patch_spin)
        settings_layout.addRow("Face", self.face_combo)
        settings_layout.addRow("Split", self.split_combo)
        settings_layout.addRow("Snap", self.snap_check)
        settings_layout.addRow("Snap radius", self.snap_radius_spin)
        settings_layout.addRow("Snap polarity", self.snap_polarity_combo)
        settings_layout.addRow("Residuals", self.residuals_plot)
        settings_dock = QDockWidget("Settings", self)
        settings_dock.setWidget(settings)
        self.addDockWidget(Qt.DockWidgetArea.RightDockWidgetArea, settings_dock)

        beams_dock = QDockWidget("Beams", self)
        self.beams_widget = BeamsDockWidget()
        beams_dock.setWidget(self.beams_widget)
        self.addDockWidget(Qt.DockWidgetArea.LeftDockWidgetArea, beams_dock)

        batch_dock = QDockWidget("Batch", self)
        batch_dock.setWidget(BatchPanel())
        self.addDockWidget(Qt.DockWidgetArea.RightDockWidgetArea, batch_dock)

        self.progress = QProgressBar()
        self.progress.setVisible(False)
        status = QStatusBar()
        status.addPermanentWidget(self.progress)
        self.setStatusBar(status)

    def _wire_signals(self) -> None:
        self.load_optical_action.triggered.connect(self.load_optical)
        self.load_ct_action.triggered.connect(self.load_ct)
        self.clear_scans_action.triggered.connect(self.clear_scans)
        self.add_pair_action.triggered.connect(self.add_pair)
        self.delete_action.triggered.connect(self.delete_selected)
        self.clear_action.triggered.connect(self.clear_points)
        self.compute_action.triggered.connect(self.compute_fit)
        self.save_points_action.triggered.connect(self.save_points_dialog)
        self.load_points_action.triggered.connect(self.load_points_dialog)
        self.pick_output_action.triggered.connect(self.pick_output)
        self.generate_action.triggered.connect(self.generate)
        self.optical_view.clicked.connect(self._optical_clicked)
        self.ct_view.clicked.connect(self._ct_clicked)
        self.mode_group.idClicked.connect(self._mode_clicked)
        selection_model = self.points_table.selectionModel()
        if selection_model is not None:
            selection_model.selectionChanged.connect(self._selection_changed)

    def load_optical(self) -> None:
        path = self._pick_image("Load optical image")
        if path is None:
            return
        try:
            self.optical_image = read_image(path)
        except OSError as exc:
            QMessageBox.critical(self, "Load failed", str(exc))
            return
        self.optical_path = path
        face, beam_id = parse_face_and_beam_id(path)
        self.beam_id = beam_id
        if face is not None:
            self.face_combo.setCurrentText(face)
        self.optical_label.setText(f"Optical: {path.name}")
        self.optical_view.set_image(self.optical_image)
        self._update_status("Loaded optical image")

    def load_ct(self) -> None:
        path = self._pick_image("Load CT image")
        if path is None:
            return
        try:
            self.ct_image = read_image(path)
        except OSError as exc:
            QMessageBox.critical(self, "Load failed", str(exc))
            return
        self.ct_path = path
        face, _beam_id = parse_face_and_beam_id(path)
        if face is not None:
            self.face_combo.setCurrentText(face)
        self.ct_label.setText(f"CT: {path.name}")
        self.ct_view.set_image(self.ct_image)
        self._update_status("Loaded CT image")

    def clear_scans(self) -> None:
        if self._export_thread is not None and self._export_thread.isRunning():
            QMessageBox.information(
                self,
                "Export running",
                "Wait for export to finish before clearing scans.",
            )
            return
        self.optical_image = None
        self.ct_image = None
        self.optical_path = None
        self.ct_path = None
        self.fixed_pts.clear()
        self.moving_pts.clear()
        self.placement_state = None
        self.pending_fixed = None
        self._invalidate_fit()
        self.optical_label.setText("Optical: -")
        self.ct_label.setText("CT: -")
        self.optical_view.clear()
        self.ct_view.clear()
        self.verify_view.clear()
        self.table_model.set_points([], [], [], [])
        self.residuals_plot.set_residuals([])
        self.stack.setCurrentIndex(0)
        self.mark_button.setChecked(True)
        self.progress.setVisible(False)
        gc.collect()
        self._update_status("Cleared loaded scans and released image memory")

    def add_pair(self) -> None:
        if self.optical_image is None or self.ct_image is None:
            QMessageBox.information(
                self,
                "Images required",
                "Load both optical and CT images first.",
            )
            return
        self.placement_state = "optical"
        self.pending_fixed = None
        self._update_status("Click the optical knot")

    def _optical_clicked(self, x_pos: float, y_pos: float) -> None:
        if self.placement_state != "optical":
            return
        self.pending_fixed = self._maybe_snap(self.optical_image, x_pos, y_pos, "optical")
        self.placement_state = "ct"
        self._update_status("Click the matching CT knot")

    def _ct_clicked(self, x_pos: float, y_pos: float) -> None:
        if self.placement_state != "ct" or self.pending_fixed is None:
            return
        snapped_ct = self._maybe_snap(self.ct_image, x_pos, y_pos, "CT")
        self.fixed_pts.append(self.pending_fixed)
        self.moving_pts.append(snapped_ct)
        self.placement_state = None
        self.pending_fixed = None
        self._invalidate_fit()
        self._refresh_points()
        self._update_status("Point pair added")

    def _maybe_snap(
        self,
        image: ImageArray | None,
        x_pos: float,
        y_pos: float,
        label: str,
    ) -> tuple[float, float]:
        if image is None or not self.snap_check.isChecked():
            return (x_pos, y_pos)
        result = snap_to_feature_centroid(
            image,
            x_pos,
            y_pos,
            radius=self.snap_radius_spin.value(),
            polarity=cast(FeaturePolarity, self.snap_polarity_combo.currentText()),
        )
        if result.did_snap:
            dx = result.snapped[0] - result.original[0]
            dy = result.snapped[1] - result.original[1]
            self._update_status(
                f"Snapped {label} point by dx={dx:.1f}, dy={dy:.1f} "
                f"({result.polarity}, score={result.score:.1f})"
            )
        return result.snapped

    def compute_fit(self) -> None:
        transform_type = cast(TransformType, self.transform_combo.currentText())
        fit = fit_transform(self.moving_pts, self.fixed_pts, transform_type)
        self.fit = fit
        if not fit.ok:
            QMessageBox.warning(self, "Fit failed", fit.message)
            self._update_status(fit.message)
            return
        self.residuals = [float(value) for value in fit.residuals]
        self._refresh_points()
        self.residuals_plot.set_residuals(self.residuals)
        self._update_status(fit.message)

    def delete_selected(self) -> None:
        row = self._selected_row()
        if row is None:
            return
        del self.fixed_pts[row]
        del self.moving_pts[row]
        self._invalidate_fit()
        self._refresh_points()
        self._update_status("Deleted selected point pair")

    def clear_points(self) -> None:
        if not self.fixed_pts:
            return
        response = QMessageBox.question(self, "Clear points", "Delete all point pairs?")
        if response != QMessageBox.StandardButton.Yes:
            return
        self.fixed_pts.clear()
        self.moving_pts.clear()
        self._invalidate_fit()
        self._refresh_points()
        self._update_status("Cleared point pairs")

    def save_points_dialog(self) -> None:
        path_text, _filter = QFileDialog.getSaveFileName(self, "Save points", "", "JSON (*.json)")
        if not path_text:
            return
        points = make_points_file(
            beam_id=self.beam_id,
            optical_file="" if self.optical_path is None else self.optical_path,
            ct_file="" if self.ct_path is None else self.ct_path,
            fixed_pts=self.fixed_pts,
            moving_pts=self.moving_pts,
            tform_type=cast(TransformType, self.transform_combo.currentText()),
            residuals=self.residuals,
            rms=None if self.fit is None or not self.fit.ok else self.fit.rms,
        )
        save_points(path_text, points)
        self._update_status(f"Saved points to {path_text}")

    def load_points_dialog(self) -> None:
        path_text, _filter = QFileDialog.getOpenFileName(self, "Load points", "", "JSON (*.json)")
        if not path_text:
            return
        try:
            points = load_points(path_text)
        except Exception as exc:
            QMessageBox.critical(self, "Load failed", str(exc))
            return
        self.beam_id = points.beam_id
        self.fixed_pts = list(points.fixed_pts)
        self.moving_pts = list(points.moving_pts)
        self.transform_combo.setCurrentText(points.tform_type)
        self.residuals = points.residuals.copy()
        self.fit = None
        self._refresh_points()
        self._update_status("Loaded points")

    def pick_output(self) -> None:
        path_text = QFileDialog.getExistingDirectory(self, "Pick output root")
        if path_text:
            self.output_root = Path(path_text)
            self._update_status(f"Output root: {self.output_root}")

    def generate(self) -> None:
        if self.optical_image is None or self.ct_image is None:
            QMessageBox.information(
                self,
                "Images required",
                "Load both optical and CT images first.",
            )
            return
        if self.fit is None or not self.fit.ok or self.fit.tform is None:
            QMessageBox.information(self, "Fit required", "Compute a valid transform first.")
            return
        quality_warning = self._training_quality_warning()
        if quality_warning is not None:
            response = QMessageBox.warning(
                self,
                "Alignment quality warning",
                quality_warning,
                QMessageBox.StandardButton.Yes | QMessageBox.StandardButton.Cancel,
                QMessageBox.StandardButton.Cancel,
            )
            if response != QMessageBox.StandardButton.Yes:
                self._update_status("Export cancelled because alignment quality is poor")
                return
        if self.output_root is None:
            self.pick_output()
            if self.output_root is None:
                return
        config = ExportConfig(
            out_root=self.output_root,
            beam_id=self.beam_id,
            face=cast(FaceName, self.face_combo.currentText()),
            split=cast(SplitName, self.split_combo.currentText()),
            patch_size=self.patch_spin.value(),
            stride=self.stride_spin.value(),
            force=False,
        )
        job = ExportJob(
            optical=self.optical_image,
            ct=self.ct_image,
            matrix=self.fit.tform.params,
            config=config,
            transform_type=cast(TransformType, self.transform_combo.currentText()),
            optical_file="" if self.optical_path is None else str(self.optical_path),
            ct_file="" if self.ct_path is None else str(self.ct_path),
            fixed_pts=self.fixed_pts,
            moving_pts=self.moving_pts,
            residuals=self.residuals,
            rms=self.fit.rms,
            max_residual=self.fit.max_resid,
            median_residual=self.fit.median_resid,
        )
        self.progress.setValue(0)
        self.progress.setVisible(True)
        self._export_thread = QThread(self)
        self._export_worker = ExportWorker(job)
        self._export_worker.moveToThread(self._export_thread)
        self._export_thread.started.connect(self._export_worker.run)
        self._export_worker.progress.connect(self._export_progress)
        self._export_worker.finished.connect(self._export_finished)
        self._export_worker.failed.connect(self._export_failed)
        self._export_worker.finished.connect(self._export_thread.quit)
        self._export_worker.failed.connect(self._export_thread.quit)
        self._export_thread.finished.connect(self._export_worker.deleteLater)
        self._export_thread.finished.connect(self._export_thread.deleteLater)
        self._export_thread.start()
        self._update_status("Export running")

    def _mode_clicked(self, mode_id: int) -> None:
        if mode_id == 0:
            self.stack.setCurrentIndex(0)
            return
        self._show_verify()

    def _show_verify(self) -> None:
        if self.optical_image is None or self.ct_image is None:
            self.stack.setCurrentIndex(0)
            self.mark_button.setChecked(True)
            return
        if self.fit is None or not self.fit.ok or self.fit.tform is None:
            self.stack.setCurrentIndex(0)
            self.mark_button.setChecked(True)
            self._update_status("Compute a transform before verify mode")
            return
        height, width = self.optical_image.shape[:2]
        warped = warp_to_reference(self.ct_image, self.fit.tform.params, (height, width))
        overlay = render_overlay(self.optical_image, warped, "falsecolor")
        self.verify_view.set_image(overlay)
        self.verify_view.set_points(self.fixed_pts, self._selected_row())
        self.stack.setCurrentIndex(1)

    def _refresh_points(self) -> None:
        statuses = residual_status(self.residuals) if self.residuals else []
        self.table_model.set_points(self.fixed_pts, self.moving_pts, self.residuals, statuses)
        selected = self._selected_row()
        self.optical_view.set_points(self.fixed_pts, selected)
        self.ct_view.set_points(self.moving_pts, selected)
        self.verify_view.set_points(self.fixed_pts, selected)

    def _selection_changed(self, selected: QItemSelection, _deselected: QItemSelection) -> None:
        indexes = selected.indexes()
        if not indexes:
            self._refresh_points()
            return
        row = indexes[0].row()
        self.optical_view.center_on(self.fixed_pts[row])
        self.ct_view.center_on(self.moving_pts[row])
        self.optical_view.set_points(self.fixed_pts, row)
        self.ct_view.set_points(self.moving_pts, row)
        self.verify_view.set_points(self.fixed_pts, row)

    def _selected_row(self) -> int | None:
        selection_model: QItemSelectionModel | None = self.points_table.selectionModel()
        if selection_model is None:
            return None
        indexes = selection_model.selectedRows()
        if not indexes:
            return None
        return int(indexes[0].row())

    def _invalidate_fit(self) -> None:
        self.fit = None
        self.residuals = []
        self.residuals_plot.set_residuals([])

    def _training_quality_warning(self) -> str | None:
        if self.fit is None or not self.fit.ok:
            return None
        issues: list[str] = []
        if self.fit.rms > 3.0:
            issues.append(f"RMS is {self.fit.rms:.2f} px; target for training is under 3 px.")
        if self.fit.max_resid > 5.0:
            issues.append(
                f"Max residual is {self.fit.max_resid:.2f} px; points above 5 px are outliers."
            )
        if not issues:
            return None
        issue_text = "\n".join(f"- {issue}" for issue in issues)
        return (
            "This alignment is likely too loose for paired training patches.\n\n"
            f"{issue_text}\n\n"
            "Add or fix control points and recompute before exporting. Continue anyway?"
        )

    def _pick_image(self, title: str) -> Path | None:
        path_text, _filter = QFileDialog.getOpenFileName(
            self,
            title,
            "",
            "Images (*.png *.jpg *.jpeg *.tif *.tiff *.bmp)",
        )
        return None if not path_text else Path(path_text)

    def _export_progress(self, done: int, total: int) -> None:
        self.progress.setMaximum(total)
        self.progress.setValue(done)

    def _export_finished(self, result_object: object) -> None:
        result = cast(ExportResult, result_object)
        self.progress.setVisible(False)
        self._update_status(
            f"Exported {result.written_count} patches; skipped {result.skipped_count}; "
            f"JSON: {result.alignment_json}"
        )

    def _export_failed(self, message: str) -> None:
        self.progress.setVisible(False)
        QMessageBox.critical(self, "Export failed", message)
        self._update_status("Export failed")

    def _update_status(self, message: str) -> None:
        rms = "-" if self.fit is None or not self.fit.ok else f"{self.fit.rms:.2f} px"
        status = self.statusBar()
        if status is not None:
            status.showMessage(
                f"{self.beam_id} | {len(self.fixed_pts)} pts | RMS {rms} | {message}"
            )

    def closeEvent(self, event: QCloseEvent | None) -> None:  # noqa: N802
        if event is None:
            return
        if self._export_thread is not None and self._export_thread.isRunning():
            QMessageBox.information(
                self,
                "Export running",
                "Wait for export to finish before closing.",
            )
            event.ignore()
            return
        super().closeEvent(event)
