from __future__ import annotations

from datetime import UTC, datetime
from typing import Literal

from pydantic import BaseModel, ConfigDict, Field, field_validator, model_validator

TransformType = Literal["euclidean", "similarity", "affine", "projective"]
FaceName = Literal["Top", "Bottom", "Left", "Right"]
SplitName = Literal["train", "val", "test"]
BeamStatus = Literal["unaligned", "aligned", "exported", "failed"]
Point2D = tuple[float, float]


def utc_now() -> datetime:
    return datetime.now(tz=UTC)


def posix_path(path: str) -> str:
    return path.replace("\\", "/")


class StrictModel(BaseModel):
    model_config = ConfigDict(validate_assignment=True, extra="forbid")


class TransformRecord(StrictModel):
    type: TransformType
    matrix: list[list[float]]

    @field_validator("matrix")
    @classmethod
    def validate_matrix(cls, value: list[list[float]]) -> list[list[float]]:
        if len(value) != 3 or any(len(row) != 3 for row in value):
            msg = "transform matrix must be 3x3"
            raise ValueError(msg)
        return value


class ExportRecord(StrictModel):
    patch_size: int = Field(ge=1)
    stride: int = Field(ge=1)
    out_root: str
    written_count: int = Field(ge=0)
    skipped_count: int = Field(ge=0)
    total_candidates: int = Field(ge=0)
    split: SplitName = "train"

    @field_validator("out_root")
    @classmethod
    def normalize_out_root(cls, value: str) -> str:
        return posix_path(value)


class PointsFile(StrictModel):
    schema_version: Literal["1.0"] = "1.0"
    beam_id: str
    optical_file: str
    ct_file: str
    fixed_pts: list[Point2D]
    moving_pts: list[Point2D]
    tform_type: TransformType = "similarity"
    residuals: list[float] = Field(default_factory=list)
    rms: float | None = None
    app_version: str
    created_at: datetime = Field(default_factory=utc_now)
    updated_at: datetime = Field(default_factory=utc_now)

    @field_validator("optical_file", "ct_file")
    @classmethod
    def normalize_path(cls, value: str) -> str:
        return posix_path(value)

    @model_validator(mode="after")
    def validate_lengths(self) -> PointsFile:
        if len(self.fixed_pts) != len(self.moving_pts):
            msg = "fixed_pts and moving_pts must have the same length"
            raise ValueError(msg)
        if self.residuals and len(self.residuals) != len(self.fixed_pts):
            msg = "residuals length must match point count"
            raise ValueError(msg)
        return self


class AlignmentFile(PointsFile):
    transform: TransformRecord
    export: ExportRecord
    max_residual: float | None = None
    median_residual: float | None = None


class BeamRecord(StrictModel):
    beam_id: str
    optical_file: str
    ct_file: str
    status: BeamStatus = "unaligned"
    face: FaceName | None = None
    split: SplitName = "train"
    rms: float | None = None

    @field_validator("optical_file", "ct_file")
    @classmethod
    def normalize_beam_path(cls, value: str) -> str:
        return posix_path(value)


class ProjectDefaults(StrictModel):
    tform_type: TransformType = "similarity"
    stride: int = Field(default=256, ge=32, le=1024)
    patch_size: int = Field(default=512, ge=1)
    out_root: str | None = None
    snap_radius: int = Field(default=25, ge=1)
    snap_enabled: bool = False
    magnifier_enabled: bool = False
    linked_zoom_enabled: bool = False

    @field_validator("out_root")
    @classmethod
    def normalize_optional_path(cls, value: str | None) -> str | None:
        return None if value is None else posix_path(value)


class ProjectFile(StrictModel):
    schema_version: Literal["1.0"] = "1.0"
    name: str
    created_at: datetime = Field(default_factory=utc_now)
    beams: list[BeamRecord] = Field(default_factory=list)
    defaults: ProjectDefaults = Field(default_factory=ProjectDefaults)


class BatchManifestRow(StrictModel):
    beam_id: str
    optical_path: str
    ct_path: str
    points_path: str | None = None
    face: FaceName | None = None
    split: SplitName = "train"

    @field_validator("optical_path", "ct_path", "points_path")
    @classmethod
    def normalize_manifest_path(cls, value: str | None) -> str | None:
        if value is None or value == "":
            return None
        return posix_path(value)


class BatchResultRow(StrictModel):
    beam_id: str
    status: Literal["exported", "skipped", "failed"]
    rms: float | None = None
    written_count: int = 0
    skipped_count: int = 0
    total_candidates: int = 0
    error: str = ""
    alignment_json: str = ""

