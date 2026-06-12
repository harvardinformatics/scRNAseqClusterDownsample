rule bootstrap_clusters:
    input:
        "seurat_objects/{sample}.rds"
    output:
        "results/{sample}_clusterdownsampling.tsv"
    conda:
        "../envs/downsample_clusters.yml"
    resources:
        mem_mb = lambda wildcards, attempt: int(24000 * (2 ** (attempt - 1))),
        runtime=960
    shell:
        """
        Rscript workflow/scripts/downsample_clusters.R {input} {output}
        """
