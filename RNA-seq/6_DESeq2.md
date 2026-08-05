# DESeq2

DESeq2 is an R package used to identify differentially expressed genes (DEGs) from RNA-seq count data by comparing gene expression between different experimental conditions.

> **Alternative to:** edgeR, Limma (voom)

## Purpose

- Normalize read counts
- Perform differential expression analysis
- Calculate Log2 Fold Change (log2FC)
- Calculate p-values and adjusted p-values (FDR)
- Identify significantly differentially expressed genes

## Installation

Open R or RStudio

### Install BiocManager

```R
install.packages("BiocManager")
```

### Install DESeq2

```R
BiocManager::install("DESeq2")
```

### Load Package

```R
library(DESeq2)
```

## Input

```text
Gene Count Matrix (count.txt is the output file from featurecounts)
counts.txt

Sample Metadata
Metadata is a sample information file that describes the experimental conditions (e.g., Control, Disease, Treated) for each sample. It is created manually using the sample information provided in the experiment or downloaded dataset (e.g., GEO).

metadata.csv
```
> **Note:** Sample names in `metadata.csv` must exactly match the column names in the count matrix.

Example metadata

| Sample | Condition |
|---------|-----------|
| Sample1 | Control |
| Sample2 | Control |
| Sample3 | Disease |
| Sample4 | Disease |

## Basic Workflow

### Read Count Matrix 

```R
counts <- read.table("counts.txt", header = TRUE, row.names = 1)
```

### Read Metadata

```R
metadata <- read.csv("metadata.csv", row.names = 1)
```

### Create DESeq Dataset

```R
dds <- DESeqDataSetFromMatrix(
    countData = counts,
    colData = metadata,
    design = ~ Condition
)
```

### Run Differential Expression Analysis

```R
dds <- DESeq(dds)
```

### Extract Results

```R
results <- results(dds)
```

### Save Results

```R
write.csv(results, "DESeq2_results.csv")
```

## Output

```text
DESeq2_results.csv
```

Example

| Gene | log2FoldChange | pvalue | padj |
|------|----------------|---------|------|
| TP53 | 2.31 | 0.0002 | 0.001 |
| BRCA1 | -1.84 | 0.002 | 0.010 |

## Interpretation

- **Positive log2FC** → Upregulated genes
- **Negative log2FC** → Downregulated genes
- **padj < 0.05** → Statistically significant
- **|log2FC| > 1** → Common threshold for biological significance

## Next Step

Visualize differentially expressed genes using MA plots, Volcano plots, Heatmaps, PCA, and perform GO/KEGG pathway enrichment analysis.