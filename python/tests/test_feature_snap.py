from __future__ import annotations

import numpy as np
import numpy.typing as npt
import pytest

from woodeye_alignment.core.feature_snap import snap_to_feature_centroid


def gaussian_blob(
    center_x: float,
    center_y: float,
    *,
    size: tuple[int, int] = (80, 80),
    sigma: float = 2.5,
    amplitude: float = 200.0,
) -> npt.NDArray[np.float64]:
    rows, cols = np.indices(size)
    distance_sq = (cols - center_x) ** 2 + (rows - center_y) ** 2
    blob: npt.NDArray[np.float64] = amplitude * np.exp(-distance_sq / (2.0 * sigma**2))
    return blob


def test_snap_to_bright_feature_centroid() -> None:
    image = gaussian_blob(35.0, 42.0)
    result = snap_to_feature_centroid(image, 30.0, 38.0, radius=15, polarity="bright")
    assert result.did_snap
    assert result.polarity == "bright"
    assert result.snapped[0] == pytest.approx(35.0, abs=1.0)
    assert result.snapped[1] == pytest.approx(42.0, abs=1.0)


def test_auto_snap_can_choose_dark_feature() -> None:
    image = 200.0 - gaussian_blob(48.0, 22.0)
    result = snap_to_feature_centroid(image, 44.0, 25.0, radius=15, polarity="auto")
    assert result.did_snap
    assert result.polarity == "dark"
    assert result.snapped[0] == pytest.approx(48.0, abs=1.0)
    assert result.snapped[1] == pytest.approx(22.0, abs=1.0)


def test_flat_patch_does_not_snap() -> None:
    image = np.full((40, 40), 100.0, dtype=np.float64)
    result = snap_to_feature_centroid(image, 12.0, 13.0, radius=10)
    assert not result.did_snap
    assert result.snapped == (12.0, 13.0)
