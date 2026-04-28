from __future__ import annotations

from pathlib import Path

import numpy as np
import numpy.typing as npt
from PIL import Image

from woodeye_alignment.core.alignment_json import load_alignment
from woodeye_alignment.core.export import ExportConfig, export_patches


def test_export_writes_expected_layout(
    tmp_path: Path, rgb_image: npt.NDArray[np.uint8], identity_matrix: npt.NDArray[np.float64]
) -> None:
    result = export_patches(
        rgb_image,
        rgb_image,
        identity_matrix,
        ExportConfig(out_root=tmp_path, beam_id="Beam_01", face="Top", patch_size=512, stride=256),
    )
    assert result.written_count == 3
    assert result.skipped_count == 0
    optical_files = sorted((tmp_path / "train" / "Top" / "optical").glob("*.png"))
    ct_files = sorted((tmp_path / "train" / "Top" / "ct").glob("*.png"))
    assert len(optical_files) == 3
    assert len(ct_files) == 3
    for image_path in optical_files + ct_files:
        Image.open(image_path).verify()
    sidecar = load_alignment(tmp_path / "train" / "Top" / "Beam_01.alignment.json")
    assert sidecar.export.written_count == 3


def test_export_skips_black_tiles(tmp_path: Path, identity_matrix: npt.NDArray[np.float64]) -> None:
    black = np.zeros((512, 512, 3), dtype=np.uint8)
    result = export_patches(
        black,
        black,
        identity_matrix,
        ExportConfig(out_root=tmp_path, beam_id="Beam_02", face="Top", patch_size=512, stride=512),
    )
    assert result.written_count == 0
    assert result.skipped_count == 1
