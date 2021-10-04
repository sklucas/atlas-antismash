# atlas-antismash
This is a repository for the snakemake workflow to take the output of metagenome-atlas as input for antismash analysis for the detection of biosynthetic gene clusters.

## Step 1: Run Metagenome Atlas.
See the [docs](https://metagenome-atlas.rtfd.io/) for more details.

Running this workflow should give you a working directory with atlas output. The important files used as input for this workflow will be in the individual sample contigs.fasta and .gff files. 

## Step 2: Installation

### Clone this repository:
```
git clone https://github.com/sklucas/atlas-antismash.git
```

### Install antiSMASH
Follow the instructions for antiSMASH installation in the [antiSMASH documentation](https://docs.antismash.secondarymetabolites.org/install/): 

I recommend using the bioconda package. Create a new conda environment with antismash. Activate the new environment. Download the necessary antismash databases. If desired, deactivate the conda environment. 
```
conda create -n antismash antismash
conda activate antismash
download-antismash-databases
conda deactivate
```

Also, you will need snakemake installed in your base environment, or environment of your choosing. E.g.:
```
conda create -n snakemake snakemake
```

## Step 3: Execute the workflow
**A note about configuration**
This workflow piggybacks off the snakemake profile made using cookiecutter, which was created in the setup for running Metagenome Atlas. Adjustment to default and rule specific parameters for this antismash rule can be done in the resources specified in the rule (memory, threads), or in the cluster config file (usually found at $HOME/.config/snakemake/cluster/cluster_config.yaml). The cluster config file is sourced using the same snakemake profile method used to run Metagenome atlas (see below ```--profile```)

The workflow can be executed as a slurm submission. As an example, I started an interactive job and activated my snakemake conda environment:
```
srun --nodes=1 --account=pschloss0 --ntasks-per-node=1 --cpus-per-task=1 --mem=10g --time=12:00:00  --pty /bin/bash
conda activate snakemake
```
Activate the antismash conda environment and run the snakemake workflow in your atlas working directory (As an example, jobs is set to 100 - pick what's right for you):
```
conda activate snakemake
snakemake -d atlas_working_dir --jobs 100 --profile cluster
```

## Step 4: Look at results
A new antismash folder should show up in your atlas working directory with subfolders for each sample containing the antiSMASH results. 
The organization is ready for downstream analysis by tools such as BiG-SCAPE, Big-MAP, etc.