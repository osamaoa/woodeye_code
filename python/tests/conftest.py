from __future__ import annotations

import numpy as np
import numpy.typing as npt
import pytest


@pytest.fixture
def rgb_image() -> npt.NDArray[np.uint8]:
    image = np.full((512, 1024, 3), 180, dtype=np.uint8)
    image[128:256, 128:256] = (220, 80, 40)
    return image


@pytest.fixture
def identity_matrix() -> npt.NDArray[np.float64]:
    return np.eye(3, dtype=np.float64)
