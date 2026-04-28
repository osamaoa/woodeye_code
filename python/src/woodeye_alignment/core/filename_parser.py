from __future__ import annotations

import re
from pathlib import Path

from woodeye_alignment.core.schemas import FaceName

FACE_PATTERNS: list[tuple[FaceName, re.Pattern[str]]] = [
    ("Top", re.compile(r"(^|[_\-\s])(?:top|surface[-_]?top)([_\-\s.]|$)", re.IGNORECASE)),
    ("Bottom", re.compile(r"(^|[_\-\s])(?:bottom|surface[-_]?bottom)([_\-\s.]|$)", re.IGNORECASE)),
    ("Left", re.compile(r"(^|[_\-\s])(?:left|surface[-_]?left)([_\-\s.]|$)", re.IGNORECASE)),
    ("Right", re.compile(r"(^|[_\-\s])(?:right|surface[-_]?right)([_\-\s.]|$)", re.IGNORECASE)),
]


def detect_face(filename: str | Path) -> FaceName | None:
    name = Path(filename).name
    for face, pattern in FACE_PATTERNS:
        if pattern.search(name):
            return face
    return None


def parse_beam_id(filename: str | Path) -> str:
    stem = Path(filename).stem
    cleaned = re.sub(r"(?i)(__?surface[-_]?)(top|bottom|left|right)", "", stem)
    cleaned = re.sub(r"(?i)(^|[_\-\s])(top|bottom|left|right)(?=$|[_\-\s])", "_", cleaned)
    cleaned = re.sub(r"(?i)__?subsurface.*$", "", cleaned)
    cleaned = re.sub(r"[_\-\s]+$", "", cleaned)
    cleaned = re.sub(r"^[_\-\s]+", "", cleaned)
    return cleaned or stem


def parse_face_and_beam_id(filename: str | Path) -> tuple[FaceName | None, str]:
    return detect_face(filename), parse_beam_id(filename)
