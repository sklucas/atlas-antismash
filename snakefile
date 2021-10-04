import os
import pandas as pd

sample_table = "samples.tsv"
sampleTable = pd.read_csv(sample_table, index_col=0, sep="\t")
SAMPLES = sampleTable.index.values

rule all:
    input:
        expand("antismash/{sample}/antismash.txt", sample = SAMPLES)

rule run_antismash:
    input:
        gff="{sample}/annotation/predicted_genes/{sample}.gff",
        contigs="{sample}/assembly/{sample}_final_contigs.fasta"
    output:
        touch("antismash/{sample}/antismash.txt")
    threads:
        15
    resources:
        mem=120
        #time=360
    shell:
        """
        source ~/miniconda3/etc/profile.d/conda.sh
        conda activate antismash
        antismash --cb-general --cb-subclusters --cb-knownclusters --rre --cc-mibig --pfam2go --asf -c {threads} \
        --output-dir antismash/{wildcards.sample}/  --genefinding-gff3 {input.gff} {input.contigs}
        """
        