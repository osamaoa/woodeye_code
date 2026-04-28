from __future__ import annotations

import sys

from PyQt6.QtWidgets import QApplication

from woodeye_alignment.main_window import MainWindow


def run_app() -> int:
    app = QApplication(sys.argv)
    app.setApplicationName("WoodEye Alignment")
    app.setOrganizationName("WoodEye")
    window = MainWindow()
    window.resize(1500, 950)
    window.show()
    return int(app.exec())
