from __future__ import annotations

import numpy as np
import pyqtgraph as pg


class ResidualsPlot(pg.PlotWidget):  # type: ignore[misc]
    def set_residuals(self, residuals: list[float]) -> None:
        self.clear()
        if residuals:
            y_values, edges = np.histogram(residuals, bins=min(20, len(residuals)))
            self.plot(edges, y_values, stepMode=True, fillLevel=0, brush=(0, 188, 212, 120))
