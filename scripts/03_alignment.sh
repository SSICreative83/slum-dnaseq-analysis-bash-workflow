#!/bin/bash

# Alignment with BWA
mkdir -p results/alignment
REFERENCE="config/reference_genome.fasta"
SAMPLES="config/samples.txt"

# Index the reference genome
echo "Indexing reference genome..."
bwa index $REFERENCE

# Read the sample list and align reads
echo "Aligning reads..."
while IFS= read -r SAMPLE
do
    R1=$(echo $SAMPLE | cut -d ' ' -f 1)
    R2=$(echo $SAMPLE | cut -d ' ' -f 2)
    SAMPLE_NAME=$(basename $R1 | cut -d '_' -f 1)
    
    bwa mem $REFERENCE $R1 $R2 | samtools view -Sb - > results/alignment/${SAMPLE_NAME}.bam
    samtools sort -o results/alignment/${SAMPLE_NAME}_sorted.bam results/alignment/${SAMPLE_NAME}.bam
    samtools index results/alignment/${SAMPLE_NAME}_sorted.bam
done < $SAMPLES

echo "Alignment complete."
