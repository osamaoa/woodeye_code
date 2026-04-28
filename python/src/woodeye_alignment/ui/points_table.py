from __future__ import annotations

from typing import ClassVar

import numpy as np
from PyQt6.QtCore import QAbstractTableModel, QModelIndex, Qt
from PyQt6.QtGui import QColor

INVALID_INDEX = QModelIndex()


class PointsTableModel(QAbstractTableModel):
    HEADERS: ClassVar[list[str]] = [
        "idx",
        "x_opt",
        "y_opt",
        "x_ct",
        "y_ct",
        "residual_px",
        "status",
    ]

    def __init__(self) -> None:
        super().__init__()
        self.fixed_pts: list[tuple[float, float]] = []
        self.moving_pts: list[tuple[float, float]] = []
        self.residuals: list[float] = []
        self.statuses: list[str] = []

    def set_points(
        self,
        fixed_pts: list[tuple[float, float]],
        moving_pts: list[tuple[float, float]],
        residuals: list[float] | None = None,
        statuses: list[str] | None = None,
    ) -> None:
        self.beginResetModel()
        self.fixed_pts = fixed_pts.copy()
        self.moving_pts = moving_pts.copy()
        self.residuals = [] if residuals is None else residuals.copy()
        self.statuses = [] if statuses is None else statuses.copy()
        self.endResetModel()

    def rowCount(self, parent: QModelIndex = INVALID_INDEX) -> int:  # noqa: N802
        return 0 if parent.isValid() else len(self.fixed_pts)

    def columnCount(self, parent: QModelIndex = INVALID_INDEX) -> int:  # noqa: N802
        return 0 if parent.isValid() else len(self.HEADERS)

    def headerData(  # noqa: N802
        self,
        section: int,
        orientation: Qt.Orientation,
        role: int = int(Qt.ItemDataRole.DisplayRole),
    ) -> object:
        if orientation == Qt.Orientation.Horizontal and role == int(Qt.ItemDataRole.DisplayRole):
            return self.HEADERS[section]
        return None

    def data(self, index: QModelIndex, role: int = int(Qt.ItemDataRole.DisplayRole)) -> object:
        if not index.isValid():
            return None
        row = index.row()
        col = index.column()
        if role == int(Qt.ItemDataRole.DisplayRole):
            return self._display(row, col)
        if (
            role == int(Qt.ItemDataRole.BackgroundRole)
            and col in (5, 6)
            and row < len(self.residuals)
        ):
            value = self.residuals[row]
            if value < 2.0:
                return QColor(199, 233, 192)
            if value < 5.0:
                return QColor(255, 237, 160)
            return QColor(252, 187, 161)
        return None

    def _display(self, row: int, col: int) -> str:
        fixed = self.fixed_pts[row]
        moving = self.moving_pts[row]
        residual = self.residuals[row] if row < len(self.residuals) else np.nan
        status = self.statuses[row] if row < len(self.statuses) else ""
        values = [
            row + 1,
            fixed[0],
            fixed[1],
            moving[0],
            moving[1],
            residual,
            status,
        ]
        value = values[col]
        if isinstance(value, float):
            if np.isnan(value):
                return ""
            return f"{value:.2f}"
        return str(value)
