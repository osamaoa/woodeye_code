from __future__ import annotations

from typing import Any

import pytest

from woodeye_alignment.main_window import MainWindow


@pytest.mark.qt
def test_main_window_smoke(qtbot: Any) -> None:
    window = MainWindow()
    qtbot.addWidget(window)
    assert window.windowTitle() == "WoodEye Alignment"
