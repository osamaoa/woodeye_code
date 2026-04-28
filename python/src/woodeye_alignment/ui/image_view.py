from __future__ import annotations

import numpy as np
import numpy.typing as npt
import pyqtgraph as pg
from PyQt6.QtCore import QEvent, QObject, QPointF, Qt, pyqtSignal
from PyQt6.QtGui import QBrush, QPen
from PyQt6.QtWidgets import QVBoxLayout, QWidget

from woodeye_alignment.ui.point_marker import DEFAULT_MARKER_STYLE


class ImageView(QWidget):
    clicked = pyqtSignal(float, float)
    region_drawn = pyqtSignal(object)

    def __init__(self, title: str, parent: QWidget | None = None) -> None:
        super().__init__(parent)
        self._image_shape: tuple[int, int] | None = None
        self._plot = pg.GraphicsLayoutWidget()
        self._view = self._plot.addViewBox(lockAspect=True)
        self._view.invertY(True)
        self._image_item = pg.ImageItem(axisOrder="row-major")
        self._image_item.setZValue(-10)
        self._view.addItem(self._image_item)
        self._scatter = pg.ScatterPlotItem()
        self._scatter.setZValue(10)
        self._view.addItem(self._scatter)
        self._region_curve = pg.PlotDataItem(pen=pg.mkPen((245, 124, 0), width=2))
        self._region_curve.setZValue(20)
        self._view.addItem(self._region_curve)
        self._region_drawing_enabled = False
        self._is_drawing_region = False
        self._region_points: list[tuple[float, float]] = []
        self._labels: list[pg.TextItem] = []
        layout = QVBoxLayout(self)
        layout.setContentsMargins(0, 0, 0, 0)
        layout.addWidget(self._plot)
        self._plot.setBackground("k")
        self._plot.scene().installEventFilter(self)
        self._plot.scene().sigMouseClicked.connect(self._on_scene_clicked)
        self._plot.setToolTip(title)

    def set_image(self, image: npt.NDArray[np.generic]) -> None:
        self._image_shape = (int(image.shape[0]), int(image.shape[1]))
        self._image_item.setImage(image, autoLevels=True)
        height, width = image.shape[:2]
        self._image_item.setRect(0, 0, width, height)
        self._view.setRange(xRange=(0, width), yRange=(0, height), padding=0.02)

    def clear(self) -> None:
        self._image_shape = None
        self.set_points([])
        self._view.removeItem(self._image_item)
        self._image_item = pg.ImageItem(axisOrder="row-major")
        self._image_item.setZValue(-10)
        self._view.addItem(self._image_item)
        self.clear_region_preview()

    def set_region_drawing_enabled(self, enabled: bool) -> None:
        self._region_drawing_enabled = enabled
        if not enabled:
            self._is_drawing_region = False
            self.clear_region_preview()

    def clear_region_preview(self) -> None:
        self._region_points = []
        self._region_curve.setData([], [])

    def set_points(self, points: list[tuple[float, float]], selected: int | None = None) -> None:
        for label in self._labels:
            self._view.removeItem(label)
        self._labels = []
        spots = []
        for index, (x_pos, y_pos) in enumerate(points, start=1):
            color = (
                DEFAULT_MARKER_STYLE.selected_color
                if selected is not None and selected == index - 1
                else DEFAULT_MARKER_STYLE.color
            )
            spots.append(
                {
                    "pos": (x_pos, y_pos),
                    "size": DEFAULT_MARKER_STYLE.size,
                    "pen": QPen(color, 2),
                    "brush": QBrush(Qt.BrushStyle.NoBrush),
                }
            )
            label = pg.TextItem(str(index), color=color)
            label.setPos(x_pos + 6, y_pos + 6)
            self._view.addItem(label)
            self._labels.append(label)
        self._scatter.setData(spots)

    def center_on(self, point: tuple[float, float]) -> None:
        x_pos, y_pos = point
        view_range = self._view.viewRange()
        width = view_range[0][1] - view_range[0][0]
        height = view_range[1][1] - view_range[1][0]
        self._view.setRange(
            xRange=(x_pos - width / 2.0, x_pos + width / 2.0),
            yRange=(y_pos - height / 2.0, y_pos + height / 2.0),
            padding=0.0,
        )

    def _on_scene_clicked(self, event: object) -> None:
        if self._region_drawing_enabled:
            return
        mouse_event = event
        if hasattr(mouse_event, "button") and mouse_event.button() != Qt.MouseButton.LeftButton:
            return
        scene_pos = getattr(mouse_event, "scenePos", lambda: QPointF())()
        if not self._view.sceneBoundingRect().contains(scene_pos):
            return
        mapped = self._view.mapSceneToView(scene_pos)
        x_pos = float(mapped.x())
        y_pos = float(mapped.y())
        if self._image_shape is not None:
            height, width = self._image_shape
            if not (0.0 <= x_pos < width and 0.0 <= y_pos < height):
                return
        self.clicked.emit(x_pos, y_pos)

    def eventFilter(self, watched: QObject | None, event: QEvent | None) -> bool:  # noqa: N802
        if watched is not self._plot.scene() or event is None or not self._region_drawing_enabled:
            return super().eventFilter(watched, event)
        event_type = event.type()
        if event_type == QEvent.Type.GraphicsSceneMousePress and self._event_is_left_button(event):
            point = self._event_to_image_point(event)
            if point is None:
                return True
            self._is_drawing_region = True
            self._region_points = [point]
            self._update_region_preview()
            return True
        if event_type == QEvent.Type.GraphicsSceneMouseMove and self._is_drawing_region:
            point = self._event_to_image_point(event)
            if point is None:
                return True
            if not self._region_points or self._distance(self._region_points[-1], point) >= 1.0:
                self._region_points.append(point)
                self._update_region_preview()
            return True
        if event_type == QEvent.Type.GraphicsSceneMouseRelease and self._is_drawing_region:
            self._is_drawing_region = False
            point = self._event_to_image_point(event)
            if point is not None:
                self._region_points.append(point)
            if len(self._region_points) >= 3:
                self.region_drawn.emit(self._region_points.copy())
            self.clear_region_preview()
            return True
        return super().eventFilter(watched, event)

    def _event_is_left_button(self, event: QEvent) -> bool:
        button = getattr(event, "button", None)
        return callable(button) and button() == Qt.MouseButton.LeftButton

    def _event_to_image_point(self, event: QEvent) -> tuple[float, float] | None:
        scene_pos = getattr(event, "scenePos", lambda: QPointF())()
        if not self._view.sceneBoundingRect().contains(scene_pos):
            return None
        mapped = self._view.mapSceneToView(scene_pos)
        x_pos = float(mapped.x())
        y_pos = float(mapped.y())
        if self._image_shape is None:
            return x_pos, y_pos
        height, width = self._image_shape
        if not (0.0 <= x_pos < width and 0.0 <= y_pos < height):
            return None
        return x_pos, y_pos

    def _update_region_preview(self) -> None:
        if not self._region_points:
            self._region_curve.setData([], [])
            return
        x_values = [point[0] for point in self._region_points]
        y_values = [point[1] for point in self._region_points]
        self._region_curve.setData(x_values, y_values)

    def _distance(self, first: tuple[float, float], second: tuple[float, float]) -> float:
        return float(np.hypot(first[0] - second[0], first[1] - second[1]))
