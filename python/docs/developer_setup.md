# Developer Setup

```powershell
cd C:\dev\woodeye_code\python
python -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
pip install -e .[dev]
```

Run checks:

```powershell
ruff check .
ruff format --check .
mypy src tests
pytest
```

The console entry point is:

```powershell
woodeye-align
```

Batch mode:

```powershell
woodeye-align batch --manifest beams.csv --out-root D:\training\v1 --report report.html
```
