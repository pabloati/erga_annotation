#!/bin/bash
#SBATCH --qos long
#SBATCH --mem 60G
#SBATCH -c 25
#SBATCH -t 48:00:00
#SBATCH -o logs/reads_caureus.out
#SBATCH -e logs/reads_caureus.out
#SBATCH -J canis_isoseq

set -e

module load anaconda
source activate isoseq

file=/home/patienza/oscars/erga/data/Canis_aureus/m64358e_220706_164001.reads.bam
primers=/home/patienza/oscars/genomes_benchmark/data/Old_IsoSeq_primers.fasta

dir=/home/patienza/oscars/erga
id=C_aureus


mkdir -p $dir/preprocessing

# Lima demultiplexing
lima_out=$dir/preprocessing/C_aureus/${id}_demultiplexed.bam
#lima $file $primers $lima_out \
#    --isoseq --peek-guess --overwrite-biosample-names \
#    --split-named

# Refine
echo "Refining reads of $file"
refine_out=$dir/preprocessing/C_aureus/${id}_refine.bam
isoseq refine --require-polya $dir/preprocessing/$id/*.bam $primers $refine_out

#Cluster
echo "Done IsoSeq refine."
echo "Clustering"
isoseq cluster2 $refine_out $dir/preprocessing/C_aureus/${id}_cluster.bam
