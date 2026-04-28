from __future__ import annotations

from dataclasses import dataclass
from typing import Literal, cast

import numpy as np
import numpy.typing as npt

FeaturePolarity = Literal["auto", "bright", "dark"]


@dataclass(frozen=True)
class SnapResult:
    original: tuple[float, float]
    snapped: tuple[float, float]
    radius: int
    polarity: Literal["bright", "dark"]
    did_snap: bool
    score: float


def snap_to_feature_centroid(
    image: npt.NDArray[np.generic],
    x_pos: float,
    y_pos: float,
    *,
    radius: int = 25,
    polarity: FeaturePolarity = "auto",
    min_contrast: float = 1.0,
) -> SnapResult:
    """Snap a click to the local high-contrast intensity centroid.

    Coordinates use image convention: x is column, y is row.
    """
    if radius < 1:
        msg = "radius must be >= 1"
        raise ValueError(msg)
    gray = to_grayscale_float(image)
    height, width = gray.shape
    x_clamped = float(np.clip(x_pos, 0.0, max(width - 1, 0)))
    y_clamped = float(np.clip(y_pos, 0.0, max(height - 1, 0)))
    x_center = round(x_clamped)
    y_center = round(y_clamped)

    row0 = max(0, y_center - radius)
    row1 = min(height, y_center + radius + 1)
    col0 = max(0, x_center - radius)
    col1 = min(width, x_center + radius + 1)
    patch = gray[row0:row1, col0:col1]
    if patch.size == 0:
        return _no_snap(x_clamped, y_clamped, radius, "bright")

    local_median = float(np.median(patch))
    bright_response = np.clip(patch - local_median, 0.0, None)
    dark_response = np.clip(local_median - patch, 0.0, None)
    chosen_polarity = choose_polarity(bright_response, dark_response, polarity)
    response = bright_response if chosen_polarity == "bright" else dark_response
    score = float(np.max(response)) if response.size else 0.0
    if score < min_contrast:
        return _no_snap(x_clamped, y_clamped, radius, chosen_polarity)

    positive = response[response > 0.0]
    if positive.size == 0:
        return _no_snap(x_clamped, y_clamped, radius, chosen_polarity)
    threshold = float(np.percentile(positive, 75.0))
    feature = np.where(response >= threshold, response, 0.0)

    rows, cols = np.mgrid[row0:row1, col0:col1]
    distance_sq = (cols.astype(np.float64) - x_clamped) ** 2 + (
        rows.astype(np.float64) - y_clamped
    ) ** 2
    sigma = max(radius / 2.0, 1.0)
    click_weight = np.exp(-distance_sq / (2.0 * sigma**2))
    weights = feature * click_weight
    weight_sum = float(np.sum(weights))
    if weight_sum <= 0.0:
        return _no_snap(x_clamped, y_clamped, radius, chosen_polarity)

    snapped_x = float(np.sum(cols * weights) / weight_sum)
    snapped_y = float(np.sum(rows * weights) / weight_sum)
    return SnapResult(
        original=(x_pos, y_pos),
        snapped=(snapped_x, snapped_y),
        radius=radius,
        polarity=chosen_polarity,
        did_snap=True,
        score=score,
    )


def choose_polarity(
    bright_response: npt.NDArray[np.float64],
    dark_response: npt.NDArray[np.float64],
    requested: FeaturePolarity,
) -> Literal["bright", "dark"]:
    if requested in ("bright", "dark"):
        return requested
    bright_score = float(np.max(bright_response)) if bright_response.size else 0.0
    dark_score = float(np.max(dark_response)) if dark_response.size else 0.0
    return "dark" if dark_score > bright_score else "bright"


def to_grayscale_float(image: npt.NDArray[np.generic]) -> npt.NDArray[np.float64]:
    values = np.asarray(image)
    if values.ndim == 2:
        return cast(npt.NDArray[np.float64], values.astype(np.float64, copy=False))
    if values.ndim == 3 and values.shape[2] >= 3:
        rgb = values[:, :, :3].astype(np.float64, copy=False)
        gray = 0.299 * rgb[:, :, 0] + 0.587 * rgb[:, :, 1] + 0.114 * rgb[:, :, 2]
        return gray
    if values.ndim == 3 and values.shape[2] == 1:
        return cast(npt.NDArray[np.float64], values[:, :, 0].astype(np.float64, copy=False))
    msg = f"Unsupported image shape for snapping: {image.shape}"
    raise ValueError(msg)


def _no_snap(
    x_pos: float,
    y_pos: float,
    radius: int,
    polarity: Literal["bright", "dark"],
) -> SnapResult:
    return SnapResult(
        original=(x_pos, y_pos),
        snapped=(x_pos, y_pos),
        radius=radius,
        polarity=polarity,
        did_snap=False,
        score=0.0,
    )
