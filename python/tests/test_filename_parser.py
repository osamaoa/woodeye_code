from __future__ import annotations

from woodeye_alignment.core.filename_parser import detect_face, parse_beam_id


def test_detect_face_from_surface_name() -> None:
    assert detect_face("RB-2026-01__surface-top.png") == "Top"


def test_detect_face_from_plain_name() -> None:
    assert detect_face("Beam_05_bottom_v2.png") == "Bottom"


def test_parse_beam_id_removes_face_and_ct_suffix() -> None:
    assert parse_beam_id("26-01-CT__surface-top__subsurface-offset__depth-3.00mm.png") == "26-01-CT"
