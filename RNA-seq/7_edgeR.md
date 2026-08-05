# edgeR

edgeR is a Bioconductor package used for differential gene expression analysis of RNA-seq count data. It models read counts using the Negative Binomial distribution and is especially suitable for experiments with small sample sizes.

> **Alternative to:** DESeq2, Limma (voom)

## Purpose

- Normalize RNA-seq count data
- Estimate biological variability (dispersion)
- Perform differential expression analysis
- Calculate Log2 Fold Change (log2FC)
- Calculate p-values and False Discovery Rate (FDR)
- Identify significantly differentially expressed genes

## Installation

Open R or RStudio.

### Install BiocManager

```R
install.packages("BiocManager")
```

### Install edgeR

```R
BiocManager::install("edgeR")
```

### Load Package

```R
library(edgeR)
```

## Input

```text
Gene Count Matrix

counts.txt
```

```text
Sample Metadata

metadata.csv
```

> **Note:** The sample names in `metadata.csv` must exactly match the column names of the count matrix.

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
counts <- read.table("counts.txt",
                     header = TRUE,
                     row.names = 1)
```

### Read Metadata

```R
metadata <- read.csv("metadata.csv",
                     row.names = 1)
```

### Create DGEList Object

```R
library(edgeR)

group <- factor(metadata$Condition)

dge <- DGEList(
    counts = counts,
    group = group
)
```

### Filter Lowly Expressed Genes

```R
keep <- filterByExpr(dge)

dge <- dge[keep, , keep.lib.sizes = FALSE]
```

> Removing genes with very low counts improves statistical accuracy.

### Normalize Counts

```R
dge <- calcNormFactors(dge)
```

### Estimate Dispersion

```R
dge <- estimateDisp(dge)
```

### Fit Statistical Model

```R
fit <- glmFit(dge)
```

### Perform Differential Expression Analysis

```R
lrt <- glmLRT(fit)
```

### Extract Results

```R
results <- topTags(
    lrt,
    n = Inf
)$table
```

### Save Results

```R
write.csv(results,
          "edgeR_results.csv")
```

## Output

```text
edgeR_results.csv
```

Example

| Gene | logFC | PValue | FDR |
|------|-------|---------|------|
| TP53 | 2.12 | 0.0004 | 0.001 |
| BRCA1 | -1.45 | 0.002 | 0.008 |

## Interpretation

- **Positive logFC** → Upregulated genes
- **Negative logFC** → Downregulated genes
- **FDR < 0.05** → Statistically significant
- **|logFC| > 1** → Common threshold for biological significance

## edgeR vs DESeq2

| edgeR | DESeq2 |
|--------|---------|
| Faster for many datasets | Slightly slower |
| Excellent for small sample sizes | Very popular for general RNA-seq |
| Uses TMM normalization | Uses Median Ratio normalization |
| Negative Binomial model | Negative Binomial model |
| Widely used in transcriptomics | Widely used in transcriptomics |


## Next Step

Visualize differentially expressed genes using **MA plots**, **Volcano plots**, **Heatmaps**, **PCA**, and perform **GO/KEGG pathway enrichment analysis**.