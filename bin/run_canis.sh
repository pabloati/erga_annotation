#!/bin/bash
#SBATCH --qos long
#SBATCH --mem 4G
#SBATCH -c 2
#SBATCH -t 10-00:00:00
#SBATCH -o logs/canis.out
#SBATCH -e logs/canis.out
#SBATCH -J jackal_annot

module load anaconda
source activate snakemake

#snakemake --use-conda --jobs 10 --snakefile ../snakefile --configfile test_config.yaml --rerun-incomplete --executor slurm --default-resources slurm_account=gge

/home/patienza/oscars/LR_annotation/sqanti_evidence -c configs/canis_aureus.yaml -j 20 -s -se "--jobname {name}.{jobid} --default-resources slurm_account=gge" -R -e "--rerun-triggers input params code --max-jobs-per-second 5 --max-status-checks-per-second 5"
