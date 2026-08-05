# RNA-seq Workflow

RNA sequencing (RNA-seq) is a next-generation sequencing (NGS) technique used to study gene expression by sequencing RNA transcripts. It enables the identification of differentially expressed genes, novel transcripts, splice variants, and biological pathways associated with different experimental conditions.

This workflow provides a step-by-step guide for performing RNA-seq analysis, starting from raw sequencing reads (FASTQ files) through quality control, read preprocessing, alignment, read quantification, differential expression analysis, and downstream visualization.

---

# Prerequisites

Before starting the RNA-seq workflow, the following files are required.

## 1. Raw Sequencing Reads (FASTQ)

The workflow begins with raw sequencing reads in **FASTQ** format.

Example

```text
sample_R1.fastq.gz
sample_R2.fastq.gz
```

These files contain:

- DNA/RNA sequences
- Quality scores (Phred scores)
- Read identifiers

### Where to download

Public RNA-seq datasets are available from:

- NCBI Sequence Read Archive (SRA)
- Gene Expression Omnibus (GEO)
- European Nucleotide Archive (ENA)

The downloaded datasets can be converted into FASTQ format using the **SRA Toolkit** (`fasterq-dump`).

---

## 2. Reference Genome

A reference genome is required for aligning sequencing reads.

Example

```text
genome.fa
```

### Where to download

Reference genomes can be downloaded from:

- NCBI Genome
- Ensembl Genome Browser
- UCSC Genome Browser

Choose the correct genome assembly (for example, **GRCh38** for human).

---

## 3. Gene Annotation File

Gene annotation provides the genomic coordinates of genes and transcripts.

Example

```text
annotation.gtf
```

This file is required by alignment and read-counting tools such as STAR and featureCounts.

### Where to download

Annotation files can be obtained from:

- Ensembl
- GENCODE
- RefSeq (NCBI)

Ensure that the annotation file corresponds to the same genome assembly as the reference genome.

---

## 4. Sample Metadata

Differential expression analysis requires sample metadata describing the experimental conditions.

Example

| Sample | Condition |
|---------|-----------|
| Sample1 | Control |
| Sample2 | Control |
| Sample3 | Disease |
| Sample4 | Disease |

Save this file as:

```text
metadata.csv
```

---

# Software Required

Install the following tools before running the workflow.

## Quality Control

- FastQC

## Read Trimming

- Trimmomatic (or fastp)

## Alignment

- HISAT2 (or STAR)

## Alignment Processing

- Samtools

## Read Quantification

- featureCounts (Subread)

## Differential Expression Analysis

- DESeq2
- edgeR
- Limma (voom)

## Visualization

- ggplot2
- EnhancedVolcano
- pheatmap
- clusterProfiler
- org.Hs.eg.db

---

# Notes

- Use raw FASTQ files as input.
- Ensure that the reference genome and annotation file belong to the same genome assembly.
- Biological replicates are recommended for reliable differential expression analysis.
- Use raw read counts (not TPM or FPKM) as input for DESeq2, edgeR, and Limma.