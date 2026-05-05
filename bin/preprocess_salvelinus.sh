#!/bin/bash
#SBATCH --qos long
#SBATCH --mem 60G
#SBATCH -c 25
#SBATCH -t 48:00:00
#SBATCH -o logs/reads_salvelinus.out
#SBATCH -e logs/reads_salvelinus.err
#SBATCH -J salvelinus_prepro


set -eou pipefail

module load anaconda
source activate isoseq

pbmerge data/Salvelinus_alpinus/*.bam -o results/S_alpinus/All_tissues.flnc.bam

isoseq cluster2 results/S_alpinus/All_tissues.flnc.bam results/preprocessing/S_alpinus/All_tissues.cluster.bam
