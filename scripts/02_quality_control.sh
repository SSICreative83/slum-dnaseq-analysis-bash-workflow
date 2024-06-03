#!/bin/bash

# Quality control with FastQC
mkdir -p results/fastqc
cd data

echo "Running FastQC..."
for file in *.fastq.gz
do
    fastqc -o ../results/fastqc $file
done

echo "Quality control complete."
cd ..
