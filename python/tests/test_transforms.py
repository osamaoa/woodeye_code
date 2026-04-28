from __future__ import annotations

import numpy as np
from skimage.transform import SimilarityTransform

from woodeye_alignment.core.transforms import fit_transform, residual_status


def test_similarity_fit_recovers_known_points() -> None:
    fixed = np.array([[0.0, 0.0], [100.0, 20.0], [40.0, 140.0], [200.0, 200.0]])
    truth = SimilarityTransform(  # type: ignore[no-untyped-call]
        scale=1.2,
        rotation=0.05,
        translation=(12.0, -7.0),
    )
    moving = truth.inverse(fixed)
    result = fit_transform(moving, fixed, "similarity")
    assert result.ok
    assert result.rms < 1e-9


def test_rejects_too_few_points() -> None:
    result = fit_transform([[0.0, 0.0]], [[1.0, 1.0]], "similarity")
    assert not result.ok
    assert "needs" in result.message


def test_rejects_colinear_affine_points() -> None:
    moving = np.array([[0.0, 0.0], [1.0, 0.0], [2.0, 0.0]])
    fixed = np.array([[10.0, 0.0], [11.0, 0.0], [12.0, 0.0]])
    result = fit_transform(moving, fixed, "affine")
    assert not result.ok
    assert "colinear" in result.message


def test_residual_status_uses_training_thresholds() -> None:
    assert residual_status([1.99, 2.0, 4.99, 5.0, 133.0]) == [
        "ok",
        "review",
        "review",
        "outlier",
        "outlier",
    ]
