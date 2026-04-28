from __future__ import annotations

from typing import Any, cast

import numpy as np
import pytest

from woodeye_alignment.main_window import MainWindow


@pytest.mark.qt
def test_main_window_smoke(qtbot: Any) -> None:
    window = MainWindow()
    qtbot.addWidget(window)
    assert window.windowTitle() == "WoodEye Alignment"


@pytest.mark.qt
def test_clear_scans_releases_loaded_state(qtbot: Any) -> None:
    window = MainWindow()
    qtbot.addWidget(window)
    state = cast(Any, window)
    state.optical_image = np.ones((10, 10, 3), dtype=np.uint8)
    state.ct_image = np.ones((10, 10, 3), dtype=np.uint8)
    state.fixed_pts = [(1.0, 2.0)]
    state.moving_pts = [(3.0, 4.0)]
    state.residuals = [10.0]

    window.clear_scans()

    assert state.optical_image is None
    assert state.ct_image is None
    assert state.fixed_pts == []
    assert state.moving_pts == []
    assert window.table_model.rowCount() == 0
