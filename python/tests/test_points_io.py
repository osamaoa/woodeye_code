from __future__ import annotations

from pathlib import Path

from woodeye_alignment.core.points_io import load_points, make_points_file, save_points


def test_points_round_trip(tmp_path: Path) -> None:
    path = tmp_path / "points.json"
    points = make_points_file(
        beam_id="Beam_01",
        optical_file="C:/data/opt.png",
        ct_file="C:/data/ct.png",
        fixed_pts=[(1.0, 2.0)],
        moving_pts=[(3.0, 4.0)],
    )
    save_points(path, points)
    loaded = load_points(path)
    assert loaded.beam_id == "Beam_01"
    assert loaded.optical_file == "C:/data/opt.png"
