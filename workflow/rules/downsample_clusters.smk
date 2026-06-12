rule bootstrap_clusters:
    input:
        f"{SEURAT_OBJECT_DIR}/{{sample}}.rds"
    output:
        f"{RESULTS_DIR}/{{sample}}_clusterdownsampling.tsv"
    params:
        replicates=lambda wildcards: int(config.get("nDownsampleReplicates", 100)),
        downsample_rate=lambda wildcards: float(config.get("downsampleRate", 0.8)),
        seed=lambda wildcards: int(config.get("workflowSeed", 12345))
    conda:
        "../envs/downsample_clusters.yml"
    resources:
        mem_mb=lambda wildcards, attempt: int(24000 * (2 ** (attempt - 1))),
        runtime=960
    shell:
        """
        SCRNASEQ_DOWNSAMPLE_SEED={params.seed} Rscript workflow/scripts/downsample_clusters.R {input} {output} {params.replicates} {params.downsample_rate}
        """
