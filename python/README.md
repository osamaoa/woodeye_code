# WoodEye Alignment

Python desktop and CLI tooling for aligning optical RGB scans to CT-derived surface renders and exporting paired 512 x 512 training patches.

## Quickstart

```powershell
cd C:\dev\woodeye_code\python
python -m venv .venv
.\.venv\Scripts\Activate.ps1
pip install -e .[dev]
woodeye-align
```

Batch export:

```powershell
woodeye-align batch --manifest beams.csv --out-root D:\training\v1 --report report.html
```

The exporter writes:

```text
<outRoot>/<split>/<face>/<modality>/<beamId>_<row>_<col>.png
```

with `modality` equal to `optical` or `ct`, matching the MATLAB cleanup pipeline contract.
