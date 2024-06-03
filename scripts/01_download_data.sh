#!/bin/bash

# Download data (example URLs, replace with your actual data source)
mkdir -p data
cd data

echo "Downloading sample data..."
wget -q http://example.com/sample1_R1.fastq.gz -O sample1_R1.fastq.gz
wget -q http://example.com/sample1_R2.fastq.gz -O sample1_R2.fastq.gz

echo "Download complete."
cd ..
