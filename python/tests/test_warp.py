from __future__ import annotations

import numpy as np
import numpy.typing as npt

from woodeye_alignment.core.warp import warp_footprint, warp_to_reference


def test_identity_warp_leaves_image_unchanged(
    rgb_image: npt.NDArray[np.uint8], identity_matrix: npt.NDArray[np.float64]
) -> None:
    warped = warp_to_reference(rgb_image, identity_matrix, (rgb_image.shape[0], rgb_image.shape[1]))
    np.testing.assert_array_equal(warped, rgb_image)


def test_identity_footprint_is_full(
    rgb_image: npt.NDArray[np.uint8], identity_matrix: npt.NDArray[np.float64]
) -> None:
    size = (rgb_image.shape[0], rgb_image.shape[1])
    footprint = warp_footprint(size, identity_matrix, size)
    assert footprint.all()
