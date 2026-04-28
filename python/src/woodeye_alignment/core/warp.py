from __future__ import annotations

from typing import Any, cast

import cv2
import numpy as np
import numpy.typing as npt

ImageArray = npt.NDArray[Any]
FloatMatrix = npt.NDArray[np.float64]


def normalize_matrix(matrix: npt.ArrayLike) -> FloatMatrix:
    arr = np.asarray(matrix, dtype=np.float64)
    if arr.shape != (3, 3):
        msg = "transform matrix must be 3x3"
        raise ValueError(msg)
    return arr


def is_affine_matrix(matrix: npt.ArrayLike) -> bool:
    mat = normalize_matrix(matrix)
    return bool(np.allclose(mat[2], np.array([0.0, 0.0, 1.0]), atol=1e-9))


def warp_to_reference(
    ct_img: ImageArray,
    tform_matrix_3x3: npt.ArrayLike,
    ref_size_hw: tuple[int, int],
    *,
    interpolation: int = cv2.INTER_CUBIC,
    border_value: int | tuple[int, int, int] = 0,
) -> ImageArray:
    height, width = ref_size_hw
    matrix = normalize_matrix(tform_matrix_3x3)
    if is_affine_matrix(matrix):
        return cast(
            ImageArray,
            cv2.warpAffine(
                ct_img,
                matrix[:2],
                (width, height),
                flags=interpolation,
                borderValue=border_value,
            ),
        )
    return cast(
        ImageArray,
        cv2.warpPerspective(
            ct_img,
            matrix,
            (width, height),
            flags=interpolation,
            borderValue=border_value,
        ),
    )


def warp_footprint(
    moving_shape_hw: tuple[int, int],
    tform_matrix_3x3: npt.ArrayLike,
    ref_size_hw: tuple[int, int],
) -> npt.NDArray[np.bool_]:
    moving_mask = np.ones(moving_shape_hw, dtype=np.uint8)
    warped = warp_to_reference(
        moving_mask,
        tform_matrix_3x3,
        ref_size_hw,
        interpolation=cv2.INTER_NEAREST,
        border_value=0,
    )
    return cast(npt.NDArray[np.bool_], np.asarray(warped > 0, dtype=np.bool_))
