from __future__ import annotations

from typing import cast

import cv2
import numpy as np
import numpy.typing as npt

from woodeye_alignment.core.io import ensure_rgb_uint8


def to_gray_uint8(image: npt.NDArray[np.generic]) -> npt.NDArray[np.uint8]:
    rgb = ensure_rgb_uint8(image)
    return cast(npt.NDArray[np.uint8], cv2.cvtColor(rgb, cv2.COLOR_RGB2GRAY))


def render_overlay(
    optical: npt.NDArray[np.generic],
    warped_ct: npt.NDArray[np.generic],
    mode: str = "falsecolor",
    *,
    checker_size: int = 64,
    swipe_x: int | None = None,
) -> npt.NDArray[np.uint8]:
    optical_rgb = ensure_rgb_uint8(optical)
    ct_rgb = ensure_rgb_uint8(warped_ct)
    if mode == "blend":
        return cast(npt.NDArray[np.uint8], cv2.addWeighted(optical_rgb, 0.5, ct_rgb, 0.5, 0.0))
    if mode == "diff":
        diff = cv2.absdiff(optical_rgb, ct_rgb)
        gray = cv2.cvtColor(diff, cv2.COLOR_RGB2GRAY)
        colored = cv2.applyColorMap(gray, cv2.COLORMAP_VIRIDIS)[:, :, ::-1]
        return cast(npt.NDArray[np.uint8], colored)
    if mode == "checkerboard":
        height, width = optical_rgb.shape[:2]
        yy, xx = np.indices((height, width))
        mask = ((yy // checker_size + xx // checker_size) % 2).astype(bool)
        output = optical_rgb.copy()
        output[mask] = ct_rgb[mask]
        return output
    if mode == "swipe":
        x_pos = optical_rgb.shape[1] // 2 if swipe_x is None else swipe_x
        output = optical_rgb.copy()
        output[:, x_pos:] = ct_rgb[:, x_pos:]
        return output

    opt_gray = to_gray_uint8(optical_rgb)
    ct_gray = to_gray_uint8(ct_rgb)
    output = np.zeros((*opt_gray.shape, 3), dtype=np.uint8)
    output[:, :, 1] = opt_gray
    output[:, :, 0] = ct_gray
    output[:, :, 2] = ct_gray
    return output
