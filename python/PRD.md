# PRD

Canonical PRD: [`../PRD_alignment_tool.md`](../PRD_alignment_tool.md)

## Implementation Notes

This Python package follows the requested module structure under `python/src/woodeye_alignment`.

Current v1 implementation status:

- Implemented: core schemas, Unicode-safe OpenCV I/O, transform fitting, RANSAC wrapper, warping, footprint coverage, black tile detection, patch export, alignment JSON, project JSON, CLI batch mode, HTML report, and a PyQt6 GUI shell for manual landmark placement.
- Partially implemented: GUI project management, thumbnails, coverage report export, and detailed dock persistence. The code contains the extension points but not the complete user-facing workflow.
- Not implemented in this pass: true draggable markers, snap-to-feature, linked zoom assist, magnifier, and intensity-based refinement. Intensity refinement is represented by an explicit no-op module so the toggle can fail transparently instead of silently changing data.

The MATLAB scripts are left untouched. Export layout remains compatible with `cropBlackMargins.m`.
