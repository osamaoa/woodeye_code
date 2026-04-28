from __future__ import annotations

from pathlib import Path
from typing import Any, cast

import cv2
import numpy as np
import numpy.typing as npt

ImageArray = npt.NDArray[Any]


def read_image(path: str | Path, flags: int = cv2.IMREAD_UNCHANGED) -> ImageArray:
    """Read an image through OpenCV while supporting Unicode paths on Windows."""
    image_path = Path(path)
    data = np.fromfile(str(image_path), dtype=np.uint8)
    image = cv2.imdecode(data, flags)
    if image is None:
        msg = f"Could not read image: {image_path}"
        raise OSError(msg)
    return _opencv_to_rgb(image)


def write_png(path: str | Path, image: ImageArray) -> None:
    """Write a PNG through OpenCV while supporting Unicode paths on Windows."""
    output_path = Path(path)
    output_path.parent.mkdir(parents=True, exist_ok=True)
    encoded_ok, encoded = cv2.imencode(".png", _rgb_to_opencv(image))
    if not encoded_ok:
        msg = f"Could not encode PNG: {output_path}"
        raise OSError(msg)
    encoded.tofile(str(output_path))


def _opencv_to_rgb(image: ImageArray) -> ImageArray:
    if image.ndim == 3 and image.shape[2] == 3:
        return cast(ImageArray, cv2.cvtColor(image, cv2.COLOR_BGR2RGB))
    if image.ndim == 3 and image.shape[2] == 4:
        return cast(ImageArray, cv2.cvtColor(image, cv2.COLOR_BGRA2RGBA))
    return image


def _rgb_to_opencv(image: ImageArray) -> ImageArray:
    if image.ndim == 3 and image.shape[2] == 3:
        return cast(ImageArray, cv2.cvtColor(image, cv2.COLOR_RGB2BGR))
    if image.ndim == 3 and image.shape[2] == 4:
        return cast(ImageArray, cv2.cvtColor(image, cv2.COLOR_RGBA2BGRA))
    return image


def ensure_rgb_uint8(image: ImageArray) -> npt.NDArray[np.uint8]:
    """Return a 3-channel uint8 RGB image for training patch output."""
    if image.ndim == 2:
        image_3 = np.repeat(image[:, :, None], 3, axis=2)
    elif image.ndim == 3 and image.shape[2] == 1:
        image_3 = np.repeat(image, 3, axis=2)
    elif image.ndim == 3 and image.shape[2] >= 3:
        image_3 = image[:, :, :3]
    else:
        msg = f"Unsupported image shape: {image.shape}"
        raise ValueError(msg)

    if image_3.dtype == np.uint8:
        return cast(npt.NDArray[np.uint8], image_3.copy())

    image_float = image_3.astype(np.float64, copy=False)
    if np.issubdtype(image_3.dtype, np.integer):
        info = np.iinfo(image_3.dtype)
        scaled = np.clip(image_float / float(info.max) * 255.0, 0.0, 255.0)
    else:
        max_value = float(np.nanmax(image_float)) if image_float.size else 1.0
        if max_value <= 1.0:
            scaled = np.clip(image_float * 255.0, 0.0, 255.0)
        else:
            scaled = np.clip(image_float, 0.0, 255.0)
    return cast(npt.NDArray[np.uint8], scaled.astype(np.uint8))
