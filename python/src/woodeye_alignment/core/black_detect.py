from __future__ import annotations

import numpy as np
import numpy.typing as npt


def black_pixel_mask(
    tile: npt.NDArray[np.generic],
    threshold: float = 10.0,
) -> npt.NDArray[np.bool_]:
    values = np.asarray(tile, dtype=np.float64)
    if values.ndim == 2:
        mask_2d: npt.NDArray[np.bool_] = values <= threshold
        return mask_2d
    if values.ndim == 3:
        channels = values[:, :, :3]
        mask_3d = np.asarray(np.all(channels <= threshold, axis=2), dtype=np.bool_)
        return mask_3d
    msg = f"Unsupported tile shape: {tile.shape}"
    raise ValueError(msg)


def is_mostly_black(
    tile: npt.NDArray[np.generic], threshold: float = 10.0, black_fraction: float = 0.95
) -> bool:
    if tile.size == 0:
        return True
    mask = black_pixel_mask(tile, threshold)
    return bool(float(mask.mean()) > black_fraction)
