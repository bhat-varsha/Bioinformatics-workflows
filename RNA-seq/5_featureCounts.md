# featureCounts

featureCounts is a read quantification tool that counts how many sequencing reads are mapped to each gene or genomic feature from an aligned BAM file.

## Purpose

- Count reads mapped to genes
- Generate a gene count matrix
- Prepare input for differential expression analysis (DESeq2)

## Installation

### Ubuntu/Debian

```bash
sudo apt update
sudo apt install subread
```

### Conda

```bash
conda install -c bioconda subread
```

### Check Installation

```bash
featureCounts -v
```

## Input

```text
Reference Annotation
annotation.gtf

Aligned BAM File
sample.sorted.bam
```

## Run featureCounts

```bash
featureCounts \
-a annotation.gtf \
-o counts.txt \
sample.sorted.bam
```

Using multiple threads

```bash
featureCounts \
-T 8 \
-a annotation.gtf \
-o counts.txt \
sample.sorted.bam
```

## Common Options

| Option | Description |
|---------|-------------|
| `-a` | Annotation (GTF/GFF) file |
| `-o` | Output count file |
| `-T` | Number of CPU threads |
| `-t exon` | Feature type to count |
| `-g gene_id` | Group counts by gene ID |

## Output

```text
counts.txt
```

Example

```text
Geneid      Counts

BRCA1       2456
TP53        1832
MYC         968
EGFR        3021
```

## Interpretation

- Each row represents one gene.
- The count indicates how many reads were assigned to that gene.
- Higher counts generally indicate higher gene expression.

## Next Step

Use the generated **counts.txt** file as input for **DESeq2** to identify differentially expressed genes.