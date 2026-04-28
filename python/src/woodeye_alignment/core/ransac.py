from __future__ import annotations

from dataclasses import dataclass
from typing import cast

import numpy as np
import numpy.typing as npt
from skimage.measure import ransac
from skimage.transform._geometric import (
    AffineTransform,
    EuclideanTransform,
    ProjectiveTransform,
    SimilarityTransform,
)

from woodeye_alignment.core.schemas import TransformType
from woodeye_alignment.core.transforms import (
    MIN_POINTS,
    FitResult,
    TransformModel,
    as_points,
    fit_transform,
)

TFORM_CLS: dict[TransformType, type[TransformModel]] = {
    "euclidean": EuclideanTransform,
    "similarity": SimilarityTransform,
    "affine": AffineTransform,
    "projective": ProjectiveTransform,
}


@dataclass(frozen=True)
class RansacResult:
    fit: FitResult
    inliers: npt.NDArray[np.bool_]
    inlier_count: int
    ok: bool
    message: str


def ransac_fit(
    moving_pts: npt.ArrayLike,
    fixed_pts: npt.ArrayLike,
    ttype: TransformType = "similarity",
    *,
    residual_threshold: float = 3.0,
    max_trials: int = 1000,
) -> RansacResult:
    moving = as_points(moving_pts)
    fixed = as_points(fixed_pts)
    if len(moving) != len(fixed):
        msg = "moving_pts and fixed_pts must have the same length"
        raise ValueError(msg)

    n_points = len(moving)
    min_points = MIN_POINTS[ttype]
    if n_points < max(6, min_points):
        fit = fit_transform(moving, fixed, ttype)
        return RansacResult(
            fit=fit,
            inliers=np.ones(n_points, dtype=bool),
            inlier_count=n_points,
            ok=False,
            message=f"RANSAC needs at least {max(6, min_points)} points; used plain fit",
        )

    model, inliers = ransac(  # type: ignore[no-untyped-call]
        (moving, fixed),
        TFORM_CLS[ttype],
        min_samples=min_points,
        residual_threshold=residual_threshold,
        max_trials=max_trials,
    )
    inlier_mask = np.asarray(inliers, dtype=bool)
    inlier_count = int(inlier_mask.sum())
    if model is None or inlier_count < min_points:
        fit = fit_transform(moving, fixed, ttype)
        return RansacResult(
            fit=fit,
            inliers=inlier_mask,
            inlier_count=inlier_count,
            ok=False,
            message="RANSAC found too few inliers; used plain fit",
        )

    fit = fit_transform(moving[inlier_mask], fixed[inlier_mask], ttype)
    model_cast = cast(TransformModel, model)
    if fit.ok:
        full_residuals = fit_transform(moving, fixed, ttype).residuals
        fit = FitResult(
            tform=model_cast,
            residuals=full_residuals,
            rms=fit.rms,
            max_resid=fit.max_resid,
            median_resid=fit.median_resid,
            std_resid=fit.std_resid,
            n_points=n_points,
            ok=True,
            message=(
                f"RANSAC {ttype} fit OK ({inlier_count}/{n_points} inliers, RMS={fit.rms:.2f} px)"
            ),
        )
    return RansacResult(
        fit=fit,
        inliers=inlier_mask,
        inlier_count=inlier_count,
        ok=fit.ok,
        message=fit.message,
    )
