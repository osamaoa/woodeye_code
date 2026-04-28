from __future__ import annotations

from PyQt6.QtWidgets import QListWidget, QVBoxLayout, QWidget


class BeamsDockWidget(QWidget):
    def __init__(self, parent: QWidget | None = None) -> None:
        super().__init__(parent)
        self.list_widget = QListWidget()
        layout = QVBoxLayout(self)
        layout.addWidget(self.list_widget)

    def set_beams(self, labels: list[str]) -> None:
        self.list_widget.clear()
        self.list_widget.addItems(labels)
