from __future__ import annotations

from dataclasses import dataclass

from PyQt6.QtGui import QColor


@dataclass(frozen=True)
class MarkerStyle:
    color: QColor
    selected_color: QColor
    size: float = 12.0


DEFAULT_MARKER_STYLE = MarkerStyle(
    color=QColor(0, 188, 212),
    selected_color=QColor(245, 124, 0),
)
