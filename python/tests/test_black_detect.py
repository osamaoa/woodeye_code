from __future__ import annotations

import numpy as np

from woodeye_alignment.core.black_detect import is_mostly_black


def test_mostly_black_detects_black_tile() -> None:
    assert is_mostly_black(np.zeros((64, 64, 3), dtype=np.uint8))


def test_mostly_black_rejects_bright_tile() -> None:
    assert not is_mostly_black(np.full((64, 64, 3), 255, dtype=np.uint8))


def test_mostly_black_boundary() -> None:
    tile = np.zeros((10, 10), dtype=np.uint8)
    tile[:6] = 255
    assert not is_mostly_black(tile, black_fraction=0.95)
