from __future__ import annotations

import json
from pathlib import Path

from woodeye_alignment.core.schemas import AlignmentFile


def load_alignment(path: str | Path) -> AlignmentFile:
    alignment_path = Path(path)
    with alignment_path.open("r", encoding="utf-8") as handle:
        data = json.load(handle)
    return AlignmentFile.model_validate(data)


def save_alignment(path: str | Path, alignment: AlignmentFile) -> None:
    alignment_path = Path(path)
    alignment_path.parent.mkdir(parents=True, exist_ok=True)
    with alignment_path.open("w", encoding="utf-8") as handle:
        json.dump(alignment.model_dump(mode="json"), handle, indent=2)
        handle.write("\n")
