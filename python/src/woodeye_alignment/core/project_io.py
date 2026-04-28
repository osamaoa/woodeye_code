from __future__ import annotations

import json
import shutil
from pathlib import Path

from woodeye_alignment.core.schemas import ProjectFile


def load_project(path: str | Path) -> ProjectFile:
    project_path = Path(path)
    with project_path.open("r", encoding="utf-8") as handle:
        data = json.load(handle)
    if data.get("schema_version") != "1.0":
        backup = project_path.with_suffix(project_path.suffix + ".bak")
        shutil.copy2(project_path, backup)
        data["schema_version"] = "1.0"
    return ProjectFile.model_validate(data)


def save_project(path: str | Path, project: ProjectFile) -> None:
    project_path = Path(path)
    project_path.parent.mkdir(parents=True, exist_ok=True)
    with project_path.open("w", encoding="utf-8") as handle:
        json.dump(project.model_dump(mode="json"), handle, indent=2)
        handle.write("\n")


def create_project(path: str | Path, name: str) -> ProjectFile:
    project = ProjectFile(name=name)
    save_project(Path(path) / "project.json", project)
    (Path(path) / "beams").mkdir(parents=True, exist_ok=True)
    return project
