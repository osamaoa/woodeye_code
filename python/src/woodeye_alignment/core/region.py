from __future__ import annotations

import numpy as np
import numpy.typing as npt


def outline_centroid(points: list[tuple[float, float]]) -> tuple[float, float]:
    """Return the centroid of a drawn outline.

    The input uses image coordinates: x is column, y is row. If the outline is
    too short or nearly colinear, fall back to the arithmetic mean.
    """
    if not points:
        msg = "outline needs at least one point"
        raise ValueError(msg)
    if len(points) < 3:
        return mean_point(points)

    arr = np.asarray(points, dtype=np.float64)
    x_values = arr[:, 0]
    y_values = arr[:, 1]
    x_next = np.roll(x_values, -1)
    y_next = np.roll(y_values, -1)
    cross = x_values * y_next - x_next * y_values
    area_twice = float(np.sum(cross))
    if abs(area_twice) < 1e-9:
        return mean_point(points)

    centroid_x = float(np.sum((x_values + x_next) * cross) / (3.0 * area_twice))
    centroid_y = float(np.sum((y_values + y_next) * cross) / (3.0 * area_twice))
    return centroid_x, centroid_y


def mean_point(points: list[tuple[float, float]]) -> tuple[float, float]:
    arr: npt.NDArray[np.float64] = np.asarray(points, dtype=np.float64)
    return float(np.mean(arr[:, 0])), float(np.mean(arr[:, 1]))
