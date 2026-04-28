from __future__ import annotations

from dataclasses import dataclass
from typing import cast

import numpy as np
import numpy.typing as npt
from skimage.transform import estimate_transform
from skimage.transform._geometric import (
    AffineTransform,
    EuclideanTransform,
    ProjectiveTransform,
    SimilarityTransform,
)

from woodeye_alignment.core.schemas import TransformType

PointArray = npt.NDArray[np.float64]
TransformModel = EuclideanTransform | SimilarityTransform | AffineTransform | ProjectiveTransform

MIN_POINTS: dict[TransformType, int] = {
    "euclidean": 2,
    "similarity": 2,
    "affine": 3,
    "projective": 4,
}


@dataclass(frozen=True)
class FitResult:
    tform: TransformModel | None
    residuals: PointArray
    rms: float
    max_resid: float
    median_resid: float
    std_resid: float
    n_points: int
    ok: bool
    message: str


def as_points(points: npt.ArrayLike) -> PointArray:
    arr = np.asarray(points, dtype=np.float64)
    if arr.ndim != 2 or arr.shape[1] != 2:
        msg = "points must have shape (N, 2)"
        raise ValueError(msg)
    if not np.all(np.isfinite(arr)):
        msg = "points contain non-finite values"
        raise ValueError(msg)
    return arr


def empty_result(n_points: int, message: str) -> FitResult:
    return FitResult(
        tform=None,
        residuals=np.array([], dtype=np.float64),
        rms=float("nan"),
        max_resid=float("nan"),
        median_resid=float("nan"),
        std_resid=float("nan"),
        n_points=n_points,
        ok=False,
        message=message,
    )


def residuals_for(
    tform: TransformModel,
    moving_pts: PointArray,
    fixed_pts: PointArray,
) -> PointArray:
    projected = np.asarray(tform(moving_pts), dtype=np.float64)
    return cast(PointArray, np.linalg.norm(projected - fixed_pts, axis=1))


def matrix_condition(matrix: PointArray) -> float:
    try:
        return float(np.linalg.cond(matrix))
    except np.linalg.LinAlgError:
        return float("inf")


def fit_transform(
    moving_pts: npt.ArrayLike,
    fixed_pts: npt.ArrayLike,
    ttype: TransformType = "similarity",
    *,
    condition_threshold: float = 1e10,
) -> FitResult:
    moving = as_points(moving_pts)
    fixed = as_points(fixed_pts)
    if len(moving) != len(fixed):
        msg = "moving_pts and fixed_pts must have the same length"
        raise ValueError(msg)

    n_points = len(moving)
    min_points = MIN_POINTS[ttype]
    if n_points < min_points:
        return empty_result(n_points, f"{ttype} needs >= {min_points} pairs (have {n_points})")

    if n_points >= 3 and np.linalg.matrix_rank(fixed - fixed.mean(axis=0), tol=1e-6) < 2:
        return empty_result(n_points, "Points are colinear - spread along beam length AND width")

    try:
        tform = cast(TransformModel, estimate_transform(ttype, moving, fixed))  # type: ignore[no-untyped-call]
    except Exception as exc:  # pragma: no cover - skimage exception types vary by version
        return empty_result(n_points, f"Transform estimation failed: {exc}")

    params = np.asarray(tform.params, dtype=np.float64)
    if not np.all(np.isfinite(params)):
        return empty_result(n_points, "Transform contains non-finite values")

    cond = matrix_condition(params)
    if not np.isfinite(cond) or cond > condition_threshold:
        return empty_result(n_points, f"Transform is numerically unstable (condition={cond:.3g})")

    residuals = residuals_for(tform, moving, fixed)
    rms = float(np.sqrt(np.mean(residuals**2)))
    max_resid = float(np.max(residuals))
    median_resid = float(np.median(residuals))
    std_resid = float(np.std(residuals))
    return FitResult(
        tform=tform,
        residuals=residuals,
        rms=rms,
        max_resid=max_resid,
        median_resid=median_resid,
        std_resid=std_resid,
        n_points=n_points,
        ok=True,
        message=f"{ttype} fit OK (n={n_points}, RMS={rms:.2f} px)",
    )


def residual_status(residuals: npt.ArrayLike) -> list[str]:
    values = np.asarray(residuals, dtype=np.float64)
    if values.size == 0:
        return []
    median = float(np.median(values))
    threshold = max(5.0, 3.0 * median)
    return ["outlier" if float(value) >= threshold else "ok" for value in values]
