#!/bin/bash
#SBATCH --qos long
#SBATCH --mem 60G
#SBATCH -c 25
#SBATCH -t 48:00:00
#SBATCH -o logs/reads_salvelinus.log
#SBATCH -e logs/reads_salvelinus.log
#SBATCH -J salvelinus_prepro


set -eou pipefail

module load anaconda
source activate isoseq

outdir=results/preprocessing/S_alpinus

mkdir -p $outdir

pbmerge data/Salvelinus_alpinus/*.bam -o $outdir/All_tissues.flnc.bam

echo "Files merged, running cluster"
isoseq cluster2 $outdir/All_tissues.flnc.bam $outdir/All_tissues.cluster.bam

echo "Clustered and done"
