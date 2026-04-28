from __future__ import annotations

import csv
from pathlib import Path

import numpy as np

from woodeye_alignment.core.batch import process_manifest
from woodeye_alignment.core.io import write_png
from woodeye_alignment.core.points_io import make_points_file, save_points


def test_batch_processes_manifest(tmp_path: Path) -> None:
    image = np.full((512, 512, 3), 180, dtype=np.uint8)
    optical = tmp_path / "Beam_01_top_opt.png"
    ct = tmp_path / "Beam_01_top_ct.png"
    points_path = tmp_path / "points.json"
    write_png(optical, image)
    write_png(ct, image)
    save_points(
        points_path,
        make_points_file(
            beam_id="Beam_01",
            optical_file=optical,
            ct_file=ct,
            fixed_pts=[(0.0, 0.0), (511.0, 0.0), (0.0, 511.0), (511.0, 511.0)],
            moving_pts=[(0.0, 0.0), (511.0, 0.0), (0.0, 511.0), (511.0, 511.0)],
        ),
    )
    manifest = tmp_path / "manifest.csv"
    with manifest.open("w", encoding="utf-8", newline="") as handle:
        writer = csv.DictWriter(
            handle,
            fieldnames=["beam_id", "optical_path", "ct_path", "points_path", "face", "split"],
        )
        writer.writeheader()
        writer.writerow(
            {
                "beam_id": "Beam_01",
                "optical_path": str(optical),
                "ct_path": str(ct),
                "points_path": str(points_path),
                "face": "Top",
                "split": "train",
            }
        )
    results = process_manifest(
        manifest,
        tmp_path / "out",
        patch_size=512,
        stride=512,
        show_progress=False,
    )
    assert results[0].status == "exported"
    assert results[0].written_count == 1
    assert (tmp_path / "out" / "batch_results.csv").exists()
