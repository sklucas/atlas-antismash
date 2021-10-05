#!/bin/bash
#SBATCH --job-name=atlas-antismash
#SBATCH --output=slurm_logs/%x-%j.out
#SBATCH --mail-user=salucas@umich.edu
#SBATCH --mail-type=BEGIN,END,FAIL
#SBATCH --account=pschloss0
#SBATCH --partition=standard
#SBATCH --time=300:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=5g

### Set Up Environment
# Conda environment:
source ~/miniconda3/etc/profile.d/conda.sh
conda activate snakemake

# This chunk changes directory to the directory from which it was submitted
echo "Changing directory to $SLURM_SUBMIT_DIR"
cd $SLURM_SUBMIT_DIR

# Run script
snakemake -d ../../Lucas_BGCinCRC_XXXX_XXXX/exploratory/Lucas_BGCinCRC_XXXX_XXXX_atlas/ --profile cluster --jobs 79