# Visualization

Visualization helps interpret differential expression analysis results by highlighting significantly expressed genes, sample relationships, and expression patterns.

These plots are commonly generated after differential expression analysis using **DESeq2**, **edgeR**

## Purpose

- Identify significantly differentially expressed genes
- Visualize expression patterns
- Detect sample clustering
- Assess data quality
- Support biological interpretation

## Required Packages

```R
install.packages("BiocManager")

BiocManager::install(c(
    "DESeq2",
    "EnhancedVolcano",
    "pheatmap",
    "clusterProfiler"
))

install.packages("ggplot2")
```

Load the packages

```R
library(DESeq2)
library(ggplot2)
library(EnhancedVolcano)
library(pheatmap)
library(clusterProfiler)
library(org.Hs.eg.db)
```

## Input

```text
Differential Expression Results

DESeq2_results.csv
edgeR_results.csv
```

or

```R
results <- results(dds)
```

---

# MA Plot

An MA plot displays the relationship between gene expression level and fold change.

```R
plotMA(results)
```

## Output

```text
MA_plot.png
```

## Interpretation

- Red points indicate significantly differentially expressed genes.
- Genes above zero are upregulated.
- Genes below zero are downregulated.

---

# Volcano Plot

A volcano plot combines statistical significance and fold change.

```R
EnhancedVolcano(
    results,
    lab = rownames(results),
    x = "log2FoldChange",
    y = "padj"
)
```

## Output

```text
volcano_plot.png
```

## Interpretation

- Left side → Downregulated genes
- Right side → Upregulated genes
- Higher points → More statistically significant

---

# Heatmap

Heatmaps display expression patterns across all samples.

```R
pheatmap(
    assay(vst(dds)),
    scale = "row"
)
```

## Output

```text
heatmap.png
```

## Interpretation

- Similar expression patterns cluster together.
- Highly expressed genes appear as warmer colors.
- Lowly expressed genes appear as cooler colors.

---

# PCA Plot

Principal Component Analysis (PCA) visualizes similarities among samples.

```R
vsd <- vst(dds)

plotPCA(vsd,
        intgroup = "Condition")
```

## Output

```text
PCA_plot.png
```

## Interpretation

- Samples from the same condition should cluster together.
- Large separation indicates biological differences.

---

# GO Enrichment Analysis

Gene Ontology (GO) enrichment identifies biological processes associated with differentially expressed genes.

Example

```R
ego <- enrichGO(
    gene = gene_list,
    OrgDb = org.Hs.eg.db,
    ont = "BP"
)
```

## Output

```text
GO_results.csv
```

---

# KEGG Pathway Analysis

KEGG identifies pathways enriched with differentially expressed genes.

Example

```R
ekegg <- enrichKEGG(
    gene = gene_list,
    organism = "hsa"
)
```

## Output

```text
KEGG_results.csv
```

---

## Summary

| Visualization | Purpose |
|--------------|---------|
| MA Plot | Expression vs Fold Change |
| Volcano Plot | Fold Change vs Significance |
| Heatmap | Expression Patterns |
| PCA Plot | Sample Clustering |
| GO Analysis | Biological Processes |
| KEGG Analysis | Pathway Analysis |

## Next Step

Interpret the biological significance of the identified genes and validate important findings using external databases or experimental methods.