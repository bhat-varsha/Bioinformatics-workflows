#!/bin/bash

####################################################
# RNA-seq Analysis Pipeline
####################################################

############################
# Step 1 - Quality Control
############################

fastqc sample_R1.fastq.gz sample_R2.fastq.gz

####################################################
# Step 2 - Read Trimming (Trimmomatic)
####################################################

trimmomatic PE \
sample_R1.fastq.gz \
sample_R2.fastq.gz \
paired_R1.fastq.gz \
unpaired_R1.fastq.gz \
paired_R2.fastq.gz \
unpaired_R2.fastq.gz \
SLIDINGWINDOW:4:20 \
MINLEN:50

# Alternatively, fastp can be used for read trimming.(refer fastp documentation for usage)

####################################################
# Step 3 - Build HISAT2 Index
####################################################

hisat2-build genome.fa genome_index

####################################################
# Step 4 - Align Reads
####################################################

hisat2 \
-p 8 \
-x genome_index \
-1 paired_R1.fastq.gz \
-2 paired_R2.fastq.gz \
-S sample.sam

# Alternatively, STAR can also be used for alignment.(refer STAR documentation for usage)

####################################################
# Step 5 - Convert SAM to BAM(install samtools if not already installed)
####################################################

samtools view -bS sample.sam > sample.bam

####################################################
# Step 6 - Sort BAM
####################################################

samtools sort sample.bam -o sample.sorted.bam

####################################################
# Step 7 - Index BAM
####################################################

samtools index sample.sorted.bam

####################################################
# Step 8 - Quantify Gene Expression
####################################################

featureCounts \
-T 8 \
-a annotation.gtf \
-o counts.txt \
sample.sorted.bam

####################################################
# Step 9 - Differential Expression Analysis
####################################################

# Open R or RStudio

library(DESeq2)

counts <- read.table("counts.txt", header = TRUE, row.names = 1)

metadata <- read.csv("metadata.csv", row.names = 1)

dds <- DESeqDataSetFromMatrix(
    countData = counts,
    colData = metadata,
    design = ~ Condition
)

dds <- DESeq(dds)

results <- results(dds)

write.csv(results, "DESeq2_results.csv")

# Alternatively, edgeR or Limma (voom) can be used.(refer to their respective documentation for usage)

####################################################
# Step 10 - Visualization
####################################################

library(ggplot2)
library(EnhancedVolcano)
library(pheatmap)
library(clusterProfiler)
library(org.Hs.eg.db)

# MA Plot

plotMA(results)

# Volcano Plot

EnhancedVolcano(
    results,
    lab = rownames(results),
    x = "log2FoldChange",
    y = "padj"
)

# Heatmap

vsd <- vst(dds)

pheatmap(
    assay(vsd),
    scale = "row"
)

# PCA Plot

plotPCA(
    vsd,
    intgroup = "Condition"
)

# GO Enrichment Analysis

ego <- enrichGO(
    gene = gene_list,
    OrgDb = org.Hs.eg.db,
    ont = "BP"
)

# KEGG Pathway Analysis

ekegg <- enrichKEGG(
    gene = gene_list,
    organism = "hsa"
)

####################################################
# RNA-seq Workflow Completed
####################################################