from __future__ import annotations

from pathlib import Path

import numpy as np
import numpy.typing as npt

from woodeye_alignment.core.export import ExportConfig, export_patches
from woodeye_alignment.core.transforms import fit_transform


def test_synthetic_points_to_patches(
    tmp_path: Path, rgb_image: npt.NDArray[np.uint8], identity_matrix: npt.NDArray[np.float64]
) -> None:
    fixed = [(0.0, 0.0), (1023.0, 0.0), (0.0, 511.0), (1023.0, 511.0)]
    moving = fixed.copy()
    fit = fit_transform(moving, fixed, "projective")
    assert fit.ok
    assert fit.tform is not None
    result = export_patches(
        rgb_image,
        rgb_image,
        fit.tform.params,
        ExportConfig(out_root=tmp_path, beam_id="Beam_E2E", face="Top", patch_size=512, stride=256),
        fixed_pts=fixed,
        moving_pts=moving,
        residuals=[float(value) for value in fit.residuals],
        rms=fit.rms,
    )
    assert result.total_candidates == 3
    assert result.written_count == 3
