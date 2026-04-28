from __future__ import annotations

from dataclasses import dataclass

import numpy.typing as npt
from PyQt6.QtCore import QObject, pyqtSignal, pyqtSlot

from woodeye_alignment.core.export import ExportConfig, ExportResult, export_patches
from woodeye_alignment.core.io import ImageArray
from woodeye_alignment.core.schemas import Point2D, TransformType


@dataclass(frozen=True)
class ExportJob:
    optical: ImageArray
    ct: ImageArray
    matrix: npt.ArrayLike
    config: ExportConfig
    transform_type: TransformType
    optical_file: str
    ct_file: str
    fixed_pts: list[Point2D]
    moving_pts: list[Point2D]
    residuals: list[float]
    rms: float | None
    max_residual: float | None
    median_residual: float | None


class ExportWorker(QObject):
    progress = pyqtSignal(int, int)
    finished = pyqtSignal(object)
    failed = pyqtSignal(str)

    def __init__(self, job: ExportJob) -> None:
        super().__init__()
        self._job = job

    @pyqtSlot()
    def run(self) -> None:
        try:
            result: ExportResult = export_patches(
                self._job.optical,
                self._job.ct,
                self._job.matrix,
                self._job.config,
                transform_type=self._job.transform_type,
                optical_file=self._job.optical_file,
                ct_file=self._job.ct_file,
                fixed_pts=self._job.fixed_pts,
                moving_pts=self._job.moving_pts,
                residuals=self._job.residuals,
                rms=self._job.rms,
                max_residual=self._job.max_residual,
                median_residual=self._job.median_residual,
                progress=lambda done, total: self.progress.emit(done, total),
            )
            self.finished.emit(result)
        except Exception as exc:  # pragma: no cover - surfaced in UI
            self.failed.emit(str(exc))
