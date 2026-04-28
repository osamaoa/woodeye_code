from __future__ import annotations

from woodeye_alignment.cli import build_parser


def test_cli_batch_help_constructs() -> None:
    parser = build_parser()
    assert parser.prog == "woodeye-align"
