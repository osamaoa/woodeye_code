from __future__ import annotations

from dataclasses import dataclass

import numpy as np
import numpy.typing as npt


@dataclass(frozen=True)
class RefinementResult:
    matrix: npt.NDArray[np.float64]
    accepted: bool
    before_score: float
    after_score: float
    message: str


def refinement_unavailable(matrix: npt.NDArray[np.float64]) -> RefinementResult:
    """Return an explicit no-op result for the optional v1 refinement toggle."""
    return RefinementResult(
        matrix=matrix,
        accepted=False,
        before_score=float("nan"),
        after_score=float("nan"),
        message="Intensity refinement is not enabled in this build.",
    )
