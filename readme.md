# slum-dnaseq-analysis-bash-workflow

# DNASeq Analysis Workflow

This repository contains a complete workflow for analyzing DNASeq data using Bash scripts and Slurm for batch processing. The workflow includes the following steps:

1. Data download and preparation
2. Quality control
3. Read alignment
4. Variant detection
5. Results analysis and report generation

## Directory Structure

DNASeq_analysis_workflow
├── scripts
│ ├── 01_download_data.sh
│ ├── 02_quality_control.sh
│ ├── 03_alignment.sh
│ ├── 04_variant_calling.sh
│ ├── 05_analysis.sh
│ └── submit_jobs.sh
├── config
│ ├── reference_genome.fasta
│ ├── samples.txt
├── results
└── README.md

## Prerequisites

Ensure you have the following tools installed:

- `wget`: for downloading data
- `fastqc`: for quality control
- `bwa`: for read alignment
- `samtools`: for handling alignment files
- `bcftools`: for variant calling
- `Slurm`: for batch processing

## Setup

1. **Clone the repository**:

    ```sh
    git clone https://github.com/yourusername/DNASeq_analysis_workflow.git
    cd DNASeq_analysis_workflow
    ```

2. **Prepare your data and configuration files**:

    - Modify the `config/samples.txt` file to include the paths to your FASTQ files. The format should be:
    
        ```txt
        data/sample1_R1.fastq.gz data/sample1_R2.fastq.gz
        data/sample2_R1.fastq.gz data/sample2_R2.fastq.gz
        ```

    - Ensure your reference genome file is placed in the `config` directory and named `reference_genome.fasta`.

3. **Create a directory for logs**:

    ```sh
    mkdir logs
    ```

## Usage

Run the `submit_jobs.sh` script to submit all steps as Slurm jobs:

```sh
bash scripts/submit_jobs.sh


