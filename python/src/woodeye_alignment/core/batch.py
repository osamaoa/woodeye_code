from __future__ import annotations

import csv
from collections.abc import Iterable
from pathlib import Path

from tqdm import tqdm

from woodeye_alignment.core.export import ExportConfig, export_patches
from woodeye_alignment.core.filename_parser import detect_face
from woodeye_alignment.core.io import read_image
from woodeye_alignment.core.points_io import load_points
from woodeye_alignment.core.schemas import (
    BatchManifestRow,
    BatchResultRow,
    FaceName,
    TransformType,
)
from woodeye_alignment.core.transforms import fit_transform


def read_manifest(path: str | Path) -> list[BatchManifestRow]:
    manifest_path = Path(path)
    with manifest_path.open("r", encoding="utf-8-sig", newline="") as handle:
        reader = csv.DictReader(handle)
        return [BatchManifestRow.model_validate(row) for row in reader]


def write_results(path: str | Path, rows: Iterable[BatchResultRow]) -> None:
    result_path = Path(path)
    result_path.parent.mkdir(parents=True, exist_ok=True)
    fieldnames = list(BatchResultRow.model_fields)
    with result_path.open("w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fieldnames)
        writer.writeheader()
        for row in rows:
            writer.writerow(row.model_dump(mode="json"))


def resolve_face(row: BatchManifestRow) -> FaceName:
    if row.face is not None:
        return row.face
    detected = detect_face(row.optical_path) or detect_face(row.ct_path)
    if detected is None:
        msg = f"Could not detect face for beam {row.beam_id}; provide face in manifest"
        raise ValueError(msg)
    return detected


def process_manifest(
    manifest: str | Path,
    out_root: str | Path,
    *,
    transform_type: TransformType = "similarity",
    stride: int = 256,
    patch_size: int = 512,
    force: bool = False,
    show_progress: bool = True,
) -> list[BatchResultRow]:
    rows = read_manifest(manifest)
    results: list[BatchResultRow] = []
    iterator = tqdm(rows, desc="beams", unit="beam") if show_progress else rows
    for row in iterator:
        try:
            if row.points_path is None:
                results.append(
                    BatchResultRow(
                        beam_id=row.beam_id,
                        status="skipped",
                        error="Missing points_path",
                    )
                )
                continue
            points = load_points(row.points_path)
            fit = fit_transform(points.moving_pts, points.fixed_pts, transform_type)
            if not fit.ok or fit.tform is None:
                results.append(
                    BatchResultRow(
                        beam_id=row.beam_id,
                        status="failed",
                        error=fit.message,
                    )
                )
                continue
            optical = read_image(row.optical_path)
            ct = read_image(row.ct_path)
            export_result = export_patches(
                optical,
                ct,
                fit.tform.params,
                ExportConfig(
                    out_root=Path(out_root),
                    beam_id=row.beam_id,
                    face=resolve_face(row),
                    split=row.split,
                    patch_size=patch_size,
                    stride=stride,
                    force=force,
                ),
                transform_type=transform_type,
                optical_file=row.optical_path,
                ct_file=row.ct_path,
                fixed_pts=points.fixed_pts,
                moving_pts=points.moving_pts,
                residuals=[float(value) for value in fit.residuals],
                rms=fit.rms,
                max_residual=fit.max_resid,
                median_residual=fit.median_resid,
            )
            results.append(
                BatchResultRow(
                    beam_id=row.beam_id,
                    status="exported",
                    rms=fit.rms,
                    written_count=export_result.written_count,
                    skipped_count=export_result.skipped_count,
                    total_candidates=export_result.total_candidates,
                    alignment_json=str(export_result.alignment_json),
                )
            )
        except Exception as exc:  # pragma: no cover - per-beam resilience
            results.append(BatchResultRow(beam_id=row.beam_id, status="failed", error=str(exc)))

    write_results(Path(out_root) / "batch_results.csv", results)
    return results
