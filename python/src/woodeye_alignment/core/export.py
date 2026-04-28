from __future__ import annotations

from collections.abc import Callable
from dataclasses import dataclass
from pathlib import Path

import numpy as np
import numpy.typing as npt

from woodeye_alignment import __version__
from woodeye_alignment.core.alignment_json import save_alignment
from woodeye_alignment.core.black_detect import is_mostly_black
from woodeye_alignment.core.coverage import tile_origins
from woodeye_alignment.core.io import ImageArray, ensure_rgb_uint8, write_png
from woodeye_alignment.core.schemas import (
    AlignmentFile,
    ExportRecord,
    FaceName,
    Point2D,
    SplitName,
    TransformRecord,
    TransformType,
    posix_path,
    utc_now,
)
from woodeye_alignment.core.warp import warp_footprint, warp_to_reference


@dataclass(frozen=True)
class ExportConfig:
    out_root: Path
    beam_id: str
    face: FaceName
    split: SplitName = "train"
    patch_size: int = 512
    stride: int = 256
    force: bool = False
    black_threshold: float = 10.0
    black_fraction: float = 0.95


@dataclass(frozen=True)
class ExportResult:
    written_count: int
    skipped_count: int
    total_candidates: int
    optical_dir: Path
    ct_dir: Path
    alignment_json: Path


def output_dirs(config: ExportConfig) -> tuple[Path, Path, Path]:
    face_root = config.out_root / config.split / config.face
    return face_root / "optical", face_root / "ct", face_root


def patch_name(beam_id: str, row: int, col: int) -> str:
    return f"{beam_id}_{row:05d}_{col:05d}.png"


def matrix_to_nested_list(matrix: npt.ArrayLike) -> list[list[float]]:
    arr = np.asarray(matrix, dtype=np.float64)
    if arr.shape != (3, 3):
        msg = "transform matrix must be 3x3"
        raise ValueError(msg)
    return [[float(value) for value in row] for row in arr]


def export_patches(
    optical: ImageArray,
    ct: ImageArray,
    transform_matrix: npt.ArrayLike,
    config: ExportConfig,
    *,
    transform_type: TransformType = "similarity",
    optical_file: str = "",
    ct_file: str = "",
    fixed_pts: list[Point2D] | None = None,
    moving_pts: list[Point2D] | None = None,
    residuals: list[float] | None = None,
    rms: float | None = None,
    max_residual: float | None = None,
    median_residual: float | None = None,
    progress: Callable[[int, int], None] | None = None,
) -> ExportResult:
    if config.patch_size <= 0 or config.stride <= 0:
        msg = "patch_size and stride must be positive"
        raise ValueError(msg)
    height, width = optical.shape[:2]
    warped_ct = warp_to_reference(ct, transform_matrix, (height, width))
    ct_shape = (int(ct.shape[0]), int(ct.shape[1]))
    footprint = warp_footprint(ct_shape, transform_matrix, (height, width))
    origins = tile_origins(height, width, config.patch_size, config.stride)

    optical_dir, ct_dir, face_root = output_dirs(config)
    optical_dir.mkdir(parents=True, exist_ok=True)
    ct_dir.mkdir(parents=True, exist_ok=True)

    written = 0
    skipped = 0
    for index, (row, col) in enumerate(origins, start=1):
        window = np.s_[row : row + config.patch_size, col : col + config.patch_size]
        filename = patch_name(config.beam_id, row, col)
        optical_path = optical_dir / filename
        ct_path = ct_dir / filename
        if not config.force and (optical_path.exists() or ct_path.exists()):
            skipped += 1
            if progress is not None:
                progress(index, len(origins))
            continue
        if not bool(np.all(footprint[window])):
            skipped += 1
            if progress is not None:
                progress(index, len(origins))
            continue

        optical_tile = optical[window]
        ct_tile = warped_ct[window]
        if is_mostly_black(optical_tile, config.black_threshold, config.black_fraction):
            skipped += 1
            if progress is not None:
                progress(index, len(origins))
            continue
        if is_mostly_black(ct_tile, config.black_threshold, config.black_fraction):
            skipped += 1
            if progress is not None:
                progress(index, len(origins))
            continue

        write_png(optical_path, ensure_rgb_uint8(optical_tile))
        write_png(ct_path, ensure_rgb_uint8(ct_tile))
        written += 1
        if progress is not None:
            progress(index, len(origins))

    alignment_path = face_root / f"{config.beam_id}.alignment.json"
    now = utc_now()
    alignment = AlignmentFile(
        beam_id=config.beam_id,
        optical_file=posix_path(optical_file),
        ct_file=posix_path(ct_file),
        fixed_pts=[] if fixed_pts is None else fixed_pts,
        moving_pts=[] if moving_pts is None else moving_pts,
        tform_type=transform_type,
        residuals=[] if residuals is None else residuals,
        rms=rms,
        app_version=__version__,
        created_at=now,
        updated_at=now,
        transform=TransformRecord(
            type=transform_type,
            matrix=matrix_to_nested_list(transform_matrix),
        ),
        export=ExportRecord(
            patch_size=config.patch_size,
            stride=config.stride,
            out_root=posix_path(str(config.out_root)),
            written_count=written,
            skipped_count=skipped,
            total_candidates=len(origins),
            split=config.split,
        ),
        max_residual=max_residual,
        median_residual=median_residual,
    )
    save_alignment(alignment_path, alignment)
    return ExportResult(
        written_count=written,
        skipped_count=skipped,
        total_candidates=len(origins),
        optical_dir=optical_dir,
        ct_dir=ct_dir,
        alignment_json=alignment_path,
    )
