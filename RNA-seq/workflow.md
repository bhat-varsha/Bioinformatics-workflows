# RNA-seq Workflow

RNA sequencing (RNA-seq) is a high-throughput sequencing technique used to study gene expression by sequencing RNA transcripts. A typical RNA-seq workflow consists of quality assessment, read preprocessing, alignment, quantification, differential expression analysis, and visualization.

## Workflow Overview

```text
Raw RNA-seq Reads (FASTQ)
        │
        ▼
    FastQC
        │
        ▼
fastp / Trimmomatic
        │
        ▼
(Optional) FastQC
        │
        ▼
STAR / HISAT2
        │
        ▼
featureCounts
        │
        ▼
DESeq2 / edgeR / Limma (voom)
        │
        ▼
Visualization
        │
        ▼
GO / KEGG Enrichment Analysis
```

---

## Step 1 – Quality Control

**Tool:** FastQC

The raw sequencing reads are assessed for quality before any downstream analysis.

Output:

```text
sample_R1_fastqc.html
sample_R2_fastqc.html
```

---

## Step 2 – Read Preprocessing

**Tools:**

- fastp
- Trimmomatic

Reads are cleaned by removing adapter sequences, low-quality bases, and short reads.

Output:

```text
clean_R1.fastq.gz
clean_R2.fastq.gz
```

---

## Step 3 – Alignment

**Tools:**

- STAR
- HISAT2

The cleaned reads are aligned to the reference genome to determine their genomic locations.

Output:

```text
sample.sorted.bam
```

---

## Step 4 – Read Quantification

**Tool:**

- featureCounts

Reads aligned to genomic features are counted to generate a gene expression matrix.

Output:

```text
counts.txt
```

---

## Step 5 – Differential Expression Analysis

**Tools:**

- DESeq2
- edgeR
- Limma (voom)

Gene expression is compared between experimental conditions to identify differentially expressed genes.

Output:

```text
DESeq2_results.csv

or

edgeR_results.csv

or

limma_results.csv
```

---

## Step 6 – Visualization

Common visualizations include:

- MA Plot
- Volcano Plot
- Heatmap
- PCA Plot

These plots help interpret differential expression results and evaluate sample relationships.

---

## Step 7 – Functional Enrichment Analysis

Common analyses include:

- Gene Ontology (GO)
- KEGG Pathway Analysis

These analyses identify biological processes and pathways enriched among differentially expressed genes.

---

## Complete Workflow Summary

| Step | Tool | Output |
|------|------|--------|
| Quality Control | FastQC | HTML Reports |
| Read Cleaning | fastp / Trimmomatic | Clean FASTQ |
| Alignment | STAR / HISAT2 | BAM |
| Quantification | featureCounts | Counts Matrix |
| Differential Expression | DESeq2 / edgeR / Limma | Differential Expression Results |
| Visualization | R Packages | MA, Volcano, Heatmap, PCA |
| Functional Analysis | clusterProfiler | GO / KEGG Results |