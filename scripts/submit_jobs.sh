#!/bin/bash

# Submit data download job
download_job_id=$(sbatch --parsable <<EOF
#!/bin/bash
#SBATCH --job-name=download_data
#SBATCH --output=logs/download_data_%j.out
#SBATCH --error=logs/download_data_%j.err
#SBATCH --time=01:00:00
#SBATCH --mem=4G

bash scripts/01_download_data.sh
EOF
)

echo "Data download job submitted with Job ID: $download_job_id"

# Submit quality control job, dependent on data download
qc_job_id=$(sbatch --parsable <<EOF
#!/bin/bash
#SBATCH --job-name=quality_control
#SBATCH --output=logs/quality_control_%j.out
#SBATCH --error=logs/quality_control_%j.err
#SBATCH --time=01:00:00
#SBATCH --mem=4G
#SBATCH --dependency=afterok:$download_job_id

bash scripts/02_quality_control.sh
EOF
)

echo "Quality control job submitted with Job ID: $qc_job_id"

# Submit alignment job, dependent on quality control
alignment_job_id=$(sbatch --parsable <<EOF
#!/bin/bash
#SBATCH --job-name=alignment
#SBATCH --output=logs/alignment_%j.out
#SBATCH --error=logs/alignment_%j.err
#SBATCH --time=04:00:00
#SBATCH --mem=16G
#SBATCH --dependency=afterok:$qc_job_id

bash scripts/03_alignment.sh
EOF
)

echo "Alignment job submitted with Job ID: $alignment_job_id"

# Submit variant calling job, dependent on alignment
variant_calling_job_id=$(sbatch --parsable <<EOF
#!/bin/bash
#SBATCH --job-name=variant_calling
#SBATCH --output=logs/variant_calling_%j.out
#SBATCH --error=logs/variant_calling_%j.err
#SBATCH --time=04:00:00
#SBATCH --mem=16G
#SBATCH --dependency=afterok:$alignment_job_id

bash scripts/04_variant_calling.sh
EOF
)

echo "Variant calling job submitted with Job ID: $variant_calling_job_id"

# Submit analysis job, dependent on variant calling
analysis_job_id=$(sbatch --parsable <<EOF
#!/bin/bash
#SBATCH --job-name=analysis
#SBATCH --output=logs/analysis_%j.out
#SBATCH --error=logs/analysis_%j.err
#SBATCH --time=02:00:00
#SBATCH --mem=8G
#SBATCH --dependency=afterok:$variant_calling_job_id

bash scripts/05_analysis.sh
EOF
)

echo "Analysis job submitted with Job ID: $analysis_job_id"
