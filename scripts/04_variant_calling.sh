#!/bin/bash

# Variant calling with bcftools
mkdir -p results/variants
REFERENCE="config/reference_genome.fasta"
ALIGNMENT_DIR="results/alignment"

echo "Calling variants..."
for BAM in $ALIGNMENT_DIR/*_sorted.bam
do
    SAMPLE_NAME=$(basename $BAM | cut -d '_' -f 1)
    
    samtools mpileup -f $REFERENCE $BAM | bcftools call -mv -Ov -o results/variants/${SAMPLE_NAME}.vcf
done

echo "Variant calling complete."
