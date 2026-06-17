# Tests

The default pytest suite uses the Seurat RDS fixtures in `testdata/seurat_objects/`, validates the saved reference TSVs, and runs a Snakemake dry run against `testdata/results/`:

```bash
pytest tests -q
```

The dry-run test checks that the DAG includes the `bootstrap_clusters` rule and expected testdata outputs without executing R code.

To execute the single workflow rule on one test fixture, run the optional rule test:

```bash
pytest tests --run-rule -q
```

To execute the full testdata workflow and write outputs under `testdata/results/`, run:

```bash
pytest tests --run-workflow -q
```

GitHub Actions runs the default suite, the optional rule test, and the full
workflow test on pull requests. The same workflow can also be started manually
from the Actions tab with `workflow_dispatch`.

The full-workflow test removes `testdata/results/` before running so that both expected test fixture outputs are regenerated from scratch. It validates each output table and compares it to the reference snapshot under `tests/reference_outputs/testdata/results/`.

By default Snakemake creates rule conda environments under `.snakemake/conda` in the repository root. To use an explicit Snakemake conda prefix:

```bash
pytest tests --run-workflow --snakemake-conda-prefix /path/to/snakemake-conda-envs -q
```

Snakemake uses the explicit Linux lock file `workflow/envs/downsample_clusters.linux-64.pin.txt` when creating the rule environment on Linux. The workflow test uses two downsampling replicates, a 50% downsampling rate, and `workflowSeed=12345`.

Reference outputs are compared by `(bootstrap_number, clusterid)`. The `max_jaccard` column is numeric-compared with `DOWNSAMPLE_REFERENCE_REL_TOLERANCE` defaulting to `1e-6` and `DOWNSAMPLE_REFERENCE_ABS_TOLERANCE` defaulting to `1e-8`.

To refresh the reference outputs after an intentional workflow change, first run:

```bash
pytest tests --run-workflow -q
```

Then copy the regenerated outputs into `tests/reference_outputs/`:

```bash
python tests/update_reference_outputs.py
```
