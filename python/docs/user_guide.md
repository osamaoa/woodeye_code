# User Guide

## Align One Beam

1. Launch the app with `woodeye-align`.
2. Click **Load optical...** and select the RGB scan.
3. Click **Load CT...** and select the CT surface render.
4. Click **Add pair** or press `A`.
5. Click a knot in the optical view, then the matching knot in the CT view.
6. Repeat until there are enough landmarks. Similarity needs at least two pairs; affine needs three; projective needs four.
7. Select the transform type and click **Compute**.
8. Click **Verify** to inspect the falsecolor overlay.
9. Pick the output root and click **Generate**.

The app writes:

```text
<outRoot>/<split>/<face>/optical/<beamId>_<row>_<col>.png
<outRoot>/<split>/<face>/ct/<beamId>_<row>_<col>.png
<outRoot>/<split>/<face>/<beamId>.alignment.json
```

## Batch Mode

Prepare a CSV:

```csv
beam_id,optical_path,ct_path,points_path,face,split
Beam_01,C:/data/Beam_01_top_opt.png,C:/data/Beam_01_top_ct.png,C:/project/beams/Beam_01/points.json,Top,train
```

Run:

```powershell
woodeye-align batch --manifest beams.csv --out-root D:\training\v1 --report report.html
```

Batch mode writes `batch_results.csv` in the output root and continues to the next beam if one beam fails.

## Landmark Quality

Use knots that are bright, sharp, and visible in both modalities. Spread control points along both beam length and width; colinear point sets are rejected for affine and projective fits.

## Snap-To-Feature

Enable **Snap placed clicks** in the settings dock before adding point pairs. The app moves each click to the local high-contrast centroid inside the configured radius.

Use **Snap polarity: auto** unless you know the knot core is always bright or always dark in the current image. If snapping jumps to the wrong nearby feature, reduce the snap radius and place the click closer to the knot center.

## Region Point Pairs

Click **Add region pair** or press `R` when a knot center is ambiguous. Drag around the knot border in the optical image, release, then drag around the matching knot border in the CT image. The app adds one point pair using the centroid of each drawn outline.

Use this for broad knots or CT halos where a single click is hard to place consistently. The computed transform still uses point landmarks, but those points come from the drawn knot outlines.
