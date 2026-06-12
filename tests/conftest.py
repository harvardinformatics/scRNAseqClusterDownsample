def pytest_addoption(parser):
    parser.addoption(
        "--run-rule",
        action="store_true",
        default=False,
        help="execute the downsample_clusters Snakemake rule on one test fixture",
    )
    parser.addoption(
        "--run-workflow",
        action="store_true",
        default=False,
        help="execute the full Snakemake workflow on testdata",
    )
    parser.addoption(
        "--snakemake-conda-prefix",
        action="store",
        default=None,
        help="optional conda-prefix to pass to Snakemake for rule/workflow execution tests",
    )
