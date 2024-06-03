#!/bin/bash

# Analysis and report generation
VARIANTS_DIR="results/variants"

echo "Analyzing variants..."
for VCF in $VARIANTS_DIR/*.vcf
do
    SAMPLE_NAME=$(basename $VCF | cut -d '.' -f 1)
    
    # Example analysis: count the number of variants
    VARIANT_COUNT=$(grep -v "#" $VCF | wc -l)
    echo "Sample: $SAMPLE_NAME, Variants: $VARIANT_COUNT"
    
    # Save results to a summary file
    echo "$SAMPLE_NAME,$VARIANT_COUNT" >> results/variant_summary.csv
done

echo "Analysis complete. Summary saved to results/variant_summary.csv."
