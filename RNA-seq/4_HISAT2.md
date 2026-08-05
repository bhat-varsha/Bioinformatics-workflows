# HISAT2

HISAT2 (Hierarchical Indexing for Spliced Alignment of Transcripts) is a splice-aware aligner used to map RNA-seq reads to a reference genome. It efficiently aligns reads spanning exon-exon junctions while using less memory than STAR.

> **Alternative to:** STAR

## Purpose
- Align RNA-seq reads to the reference genome
- Detect splice junctions
- Generate alignment (SAM/BAM) files

## Installation

### Ubuntu/Debian

```bash
sudo apt update
sudo apt install hisat2
```

### Conda

```bash
conda install -c bioconda hisat2
```

### Check Installation

```bash
hisat2 --version
```

## Input

```text
Reference Genome (genome.fa)

Trimmed Reads
clean_R1.fastq.gz
clean_R2.fastq.gz
```

## Step 1: Build Genome Index(same as star)

```bash
hisat2-build genome.fa genome_index
```

> This step is performed only once for each reference genome.

## Step 2: Align Reads

```bash
hisat2 \
-x genome_index \
-1 clean_R1.fastq.gz \
-2 clean_R2.fastq.gz \
-S sample.sam
```

## Common Options

| Option | Description |
|---------|-------------|
| `-x` | Genome index prefix |
| `-1` | Forward reads (R1) |
| `-2` | Reverse reads (R2) |
| `-S` | Output SAM file |
| `-p` | Number of CPU threads |

Example using 8 threads

```bash
hisat2 \
-p 8 \
-x genome_index \
-1 clean_R1.fastq.gz \
-2 clean_R2.fastq.gz \
-S sample.sam
```
## Install Samtools

### Ubuntu/Debian

```bash
sudo apt update
sudo apt install samtools
```

### Conda

```bash
conda install -c bioconda samtools
```

### Check Installation

```bash
samtools --version
```

## Convert SAM to BAM

```bash
samtools view -bS sample.sam > sample.bam
```

## Sort BAM

```bash
samtools sort sample.bam -o sample.sorted.bam
```

## Index BAM

```bash
samtools index sample.sorted.bam
```

## Output

```text
sample.sam
sample.bam
sample.sorted.bam
sample.sorted.bam.bai
```

## Interpretation

- **sample.sam** → Raw alignment file.
- **sample.bam** → Binary version of the SAM file.
- **sample.sorted.bam** → Coordinate-sorted BAM used for downstream analysis.
- **sample.sorted.bam.bai** → Index file for quick access to BAM regions.

## Next Step

Use the sorted BAM file for **featureCounts** to quantify gene expression.


## extras

## STAR vs HISAT2

| STAR                                  | HISAT2 |
|------                                 |---------|
| Faster alignment                      | Lower memory usage |
| Higher RAM requirement                | Lower RAM requirement |
| Produces sorted BAM directly          | Produces SAM (convert using Samtools) |
| Widely used for large RNA-seq datasets | Popular for systems with limited resources |

**Recommendation**

- Use **STAR** when you have sufficient RAM and want faster alignment.
- Use **HISAT2** when working on systems with limited memory or when following established HISAT2-based workflows.