from __future__ import annotations

import pytest

from woodeye_alignment.core.region import outline_centroid


def test_outline_centroid_for_rectangle() -> None:
    points = [(0.0, 0.0), (10.0, 0.0), (10.0, 20.0), (0.0, 20.0)]
    assert outline_centroid(points) == pytest.approx((5.0, 10.0))


def test_outline_centroid_falls_back_to_mean_for_line() -> None:
    points = [(0.0, 0.0), (10.0, 0.0), (20.0, 0.0)]
    assert outline_centroid(points) == pytest.approx((10.0, 0.0))


def test_outline_centroid_rejects_empty_outline() -> None:
    with pytest.raises(ValueError, match="outline needs"):
        outline_centroid([])
