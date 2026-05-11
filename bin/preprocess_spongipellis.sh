#!/bin/bash
#SBATCH --qos long
#SBATCH --mem 60G
#SBATCH -c 25
#SBATCH -t 48:00:00
#SBATCH -o logs/reads_spongipellis.log
#SBATCH -e logs/reads_spongipellis.log
#SBATCH -J spongipellis_prepro

set -eou pipefail

module load anaconda
source activate isoseq

infile=/home/patienza/oscars/erga/data/Spongipellis_delectans/m64036e_220308_174404.hifi_reads.fastq.gz
reference_bam=~/oscars/LR_annotation/test/results/full_mouse_miniprot/isoseq/refine/id1/id1.flnc.bam
out_bam=${infile%.fastq}


outdir=results/preprocessing/S_alpinus
mkdir -p $outdir

python ~/oscars/genomes_benchmark/bin/convert_to_pacbio_bam2.py $infile $reference_bam $out_bam.bam -t 25

isoseq refine $out_bam.bam  ~/oscars/genomes_benchmark/data/IsoSeq_v2_primers_12.fasta $outdir/Converted.refine.bam
echo "Files merged, running cluster"
isoseq cluster2 $outdir/Converted.refine.bam $outdir/Converted.cluster.bam

echo "Clustered and done"
