from __future__ import annotations

from pathlib import Path

from woodeye_alignment.core.project_io import create_project, load_project, save_project


def test_project_round_trip(tmp_path: Path) -> None:
    project = create_project(tmp_path, "WoodEye_diffusion_v1")
    save_project(tmp_path / "project.json", project)
    loaded = load_project(tmp_path / "project.json")
    assert loaded.name == "WoodEye_diffusion_v1"
