from __future__ import annotations

import json
from pathlib import Path

from woodeye_alignment import __version__
from woodeye_alignment.core.schemas import Point2D, PointsFile, TransformType, posix_path, utc_now


def load_points(path: str | Path) -> PointsFile:
    points_path = Path(path)
    with points_path.open("r", encoding="utf-8") as handle:
        data = json.load(handle)
    return PointsFile.model_validate(data)


def save_points(path: str | Path, points: PointsFile) -> None:
    points_path = Path(path)
    points_path.parent.mkdir(parents=True, exist_ok=True)
    payload = points.model_dump(mode="json")
    with points_path.open("w", encoding="utf-8") as handle:
        json.dump(payload, handle, indent=2)
        handle.write("\n")


def make_points_file(
    *,
    beam_id: str,
    optical_file: str | Path,
    ct_file: str | Path,
    fixed_pts: list[Point2D],
    moving_pts: list[Point2D],
    tform_type: TransformType = "similarity",
    residuals: list[float] | None = None,
    rms: float | None = None,
) -> PointsFile:
    now = utc_now()
    return PointsFile(
        beam_id=beam_id,
        optical_file=posix_path(str(optical_file)),
        ct_file=posix_path(str(ct_file)),
        fixed_pts=fixed_pts,
        moving_pts=moving_pts,
        tform_type=tform_type,
        residuals=[] if residuals is None else residuals,
        rms=rms,
        app_version=__version__,
        created_at=now,
        updated_at=now,
    )
