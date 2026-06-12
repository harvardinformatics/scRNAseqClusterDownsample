# scRNAseqClusterDownsample

The Snakemake workflow in this repository takes as input Seurat scRNA-seq objects, and performs multiple replicates of downsampling and re-clustering, producing output tables that can be used to generate metrics of cell cluster stability. Interactive visualization of Seurat objects and downsampling results can be conducted using [scRNAseqWorkflowExplorer](https://github.com/harvardinformatics/scRNAseqWorkflowExplorer).

## Tests

For information on how to run the test suite, including the optional rule-execution test, see `tests/README.md`.
