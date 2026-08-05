# Limma (voom)

Limma (Linear Models for Microarray Data) is a Bioconductor package originally developed for microarray data analysis. When combined with the **voom** transformation, it can also be used for RNA-seq differential expression analysis.

The **voom** function converts raw read counts into log2-counts per million (logCPM) while estimating the mean-variance relationship, allowing Limma's linear modeling approach to analyze RNA-seq data accurately.

> **Alternative to:** DESeq2, edgeR

## Purpose

- Normalize RNA-seq count data using voom
- Model the mean-variance relationship
- Perform differential expression analysis
- Calculate Log2 Fold Change (log2FC)
- Calculate p-values and adjusted p-values (FDR)
- Identify significantly differentially expressed genes

## Installation

Open R or RStudio.

### Install BiocManager

```R
install.packages("BiocManager")
```

### Install Limma

```R
BiocManager::install("limma")
```

### Load Packages

```R
library(limma)
library(edgeR)
```

> **Note:** The `voom` function is part of the **limma** package, while **edgeR** is commonly used to create and normalize the count data before applying `voom`.

## Input

```text
Gene Count Matrix

counts.txt
```

```text
Sample Metadata

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
group <- factor(metadata$Condition)

dge <- DGEList(
    counts = counts,
    group = group
)
```

### Normalize Counts

```R
dge <- calcNormFactors(dge)
```

### Apply voom Transformation

```R
design <- model.matrix(~group)

v <- voom(dge, design)
```

### Fit Linear Model

```R
fit <- lmFit(v, design)
```

### Apply Empirical Bayes Statistics

```R
fit <- eBayes(fit)
```

### Extract Results

```R
results <- topTable(
    fit,
    coef = 2,
    number = Inf
)
```

### Save Results

```R
write.csv(results,
          "limma_results.csv")
```

## Output

```text
limma_results.csv
```

Example

| Gene | logFC | P.Value | adj.P.Val |
|------|-------|----------|-----------|
| TP53 | 2.08 | 0.0003 | 0.001 |
| BRCA1 | -1.63 | 0.001 | 0.007 |

## Interpretation

- **Positive logFC** → Upregulated genes
- **Negative logFC** → Downregulated genes
- **adj.P.Val < 0.05** → Statistically significant
- **|logFC| > 1** → Common threshold for biological significance

## Limma (voom) vs DESeq2 vs edgeR

| Feature | Limma (voom) | DESeq2 | edgeR |
|----------|--------------|---------|--------|
| Statistical Model | Linear Models | Negative Binomial | Negative Binomial |
| RNA-seq Support | Using voom | Native | Native |
| Normalization | voom + TMM | Median Ratio | TMM |
| Speed | Fast | Moderate | Fast |
| Best For | Large RNA-seq datasets | General RNA-seq | Small sample sizes |

## Next Step

Visualize differentially expressed genes using **MA plots**, **Volcano plots**, **Heatmaps**, **PCA**, and perform **GO/KEGG pathway enrichment analysis**.