from __future__ import annotations

from typing import cast

import numpy as np
import numpy.typing as npt

from woodeye_alignment.core.black_detect import is_mostly_black


def tile_origins(height: int, width: int, patch: int, stride: int) -> list[tuple[int, int]]:
    if patch <= 0 or stride <= 0:
        msg = "patch and stride must be positive"
        raise ValueError(msg)
    if height < patch or width < patch:
        return []
    rows = range(0, height - patch + 1, stride)
    cols = range(0, width - patch + 1, stride)
    return [(row, col) for row in rows for col in cols]


def coverage_map(
    optical: npt.NDArray[np.generic],
    warped_ct: npt.NDArray[np.generic],
    footprint: npt.NDArray[np.bool_] | None = None,
    *,
    patch: int = 512,
    stride: int = 256,
    black_thresh: float = 10.0,
    black_frac: float = 0.95,
) -> npt.NDArray[np.float32]:
    height, width = optical.shape[:2]
    if warped_ct.shape[:2] != (height, width):
        msg = "warped_ct must have the same height and width as optical"
        raise ValueError(msg)

    if footprint is None:
        if warped_ct.ndim == 3:
            footprint = cast(
                npt.NDArray[np.bool_],
                np.any(np.asarray(warped_ct[:, :, :3], dtype=np.float64) > 0, axis=2),
            )
        else:
            footprint = np.asarray(warped_ct, dtype=np.float64) > 0

    heat = np.zeros((height, width), dtype=np.float32)
    footprint_mask = footprint
    for row, col in tile_origins(height, width, patch, stride):
        window = np.s_[row : row + patch, col : col + patch]
        if not bool(np.all(footprint_mask[window])):
            continue
        opt_tile = optical[window]
        ct_tile = warped_ct[window]
        if is_mostly_black(opt_tile, black_thresh, black_frac):
            continue
        if is_mostly_black(ct_tile, black_thresh, black_frac):
            continue
        heat[window] += 1.0

    max_value = float(heat.max())
    if max_value > 0.0:
        heat /= max_value
    return heat
