from __future__ import annotations

import argparse
import sys
import webbrowser
from collections.abc import Sequence
from pathlib import Path

from woodeye_alignment.core.batch import process_manifest
from woodeye_alignment.core.report import render_report
from woodeye_alignment.core.schemas import TransformType


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(prog="woodeye-align")
    subparsers = parser.add_subparsers(dest="command")

    subparsers.add_parser("gui", help="Launch the desktop GUI")

    batch = subparsers.add_parser("batch", help="Process a manifest CSV headlessly")
    batch.add_argument(
        "--manifest",
        required=True,
        help="CSV with beam_id,optical_path,ct_path,...",
    )
    batch.add_argument("--out-root", required=True, help="Patch output root")
    batch.add_argument(
        "--transform",
        default="similarity",
        choices=["euclidean", "similarity", "affine", "projective"],
    )
    batch.add_argument("--stride", type=int, default=256)
    batch.add_argument("--patch", type=int, default=512)
    batch.add_argument("--report", default=None, help="Optional HTML report path")
    batch.add_argument("--force", action="store_true", help="Overwrite existing patches")
    batch.add_argument(
        "--no-open-report",
        action="store_true",
        help="Do not open the report in a browser",
    )

    return parser


def main(argv: Sequence[str] | None = None) -> None:
    args = build_parser().parse_args(list(sys.argv[1:] if argv is None else argv))
    command = args.command or "gui"
    if command == "gui":
        from woodeye_alignment.app import run_app

        raise SystemExit(run_app())
    if command == "batch":
        rows = process_manifest(
            args.manifest,
            args.out_root,
            transform_type=args.transform,
            stride=args.stride,
            patch_size=args.patch,
            force=args.force,
            show_progress=True,
        )
        if args.report:
            report_path = render_report(rows, Path(args.report))
            if not args.no_open_report:
                webbrowser.open(report_path.resolve().as_uri())
        return
    msg = f"Unknown command: {command}"
    raise SystemExit(msg)


def parse_transform(value: str) -> TransformType:
    allowed: set[str] = {"euclidean", "similarity", "affine", "projective"}
    if value not in allowed:
        msg = f"Unsupported transform type: {value}"
        raise ValueError(msg)
    return value  # type: ignore[return-value]
