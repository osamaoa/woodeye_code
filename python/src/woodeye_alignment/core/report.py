from __future__ import annotations

from pathlib import Path

from jinja2 import Template

from woodeye_alignment.core.schemas import BatchResultRow

REPORT_TEMPLATE = """<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>WoodEye Alignment Batch Report</title>
  <style>
    body { font-family: system-ui, sans-serif; margin: 2rem; color: #1f2933; }
    table { border-collapse: collapse; width: 100%; }
    th, td { border-bottom: 1px solid #d9e2ec; padding: 0.5rem; text-align: left; }
    th { background: #f0f4f8; }
    .failed { color: #b42318; font-weight: 600; }
    .exported { color: #027a48; font-weight: 600; }
    .skipped { color: #b54708; font-weight: 600; }
  </style>
</head>
<body>
  <h1>WoodEye Alignment Batch Report</h1>
  <table>
    <thead>
      <tr>
        <th>Beam</th><th>Status</th><th>RMS</th><th>Written</th>
        <th>Skipped</th><th>Total</th><th>Error</th><th>Alignment JSON</th>
      </tr>
    </thead>
    <tbody>
      {% for row in rows %}
      <tr>
        <td>{{ row.beam_id }}</td>
        <td class="{{ row.status }}">{{ row.status }}</td>
        <td>{% if row.rms is not none %}{{ "%.3f"|format(row.rms) }}{% endif %}</td>
        <td>{{ row.written_count }}</td>
        <td>{{ row.skipped_count }}</td>
        <td>{{ row.total_candidates }}</td>
        <td>{{ row.error }}</td>
        <td>{{ row.alignment_json }}</td>
      </tr>
      {% endfor %}
    </tbody>
  </table>
</body>
</html>
"""


def render_report(rows: list[BatchResultRow], output_path: str | Path) -> Path:
    path = Path(output_path)
    path.parent.mkdir(parents=True, exist_ok=True)
    html = Template(REPORT_TEMPLATE).render(rows=rows)
    path.write_text(html, encoding="utf-8")
    return path
