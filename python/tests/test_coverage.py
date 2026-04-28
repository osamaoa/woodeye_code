from __future__ import annotations

import numpy as np
import numpy.typing as npt

from woodeye_alignment.core.coverage import coverage_map, tile_origins


def test_tile_origins_for_expected_patch_count() -> None:
    assert tile_origins(512, 1024, 512, 256) == [(0, 0), (0, 256), (0, 512)]


def test_coverage_nonzero_for_valid_tiles(rgb_image: npt.NDArray[np.uint8]) -> None:
    heat = coverage_map(rgb_image, rgb_image, patch=512, stride=256)
    assert heat.max() == 1.0
    assert np.count_nonzero(heat) > 0
