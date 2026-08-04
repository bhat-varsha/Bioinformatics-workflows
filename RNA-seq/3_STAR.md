# STAR

STAR (Spliced Transcripts Alignment to a Reference) is a high-performance RNA-seq aligner that maps sequencing reads to a reference genome. It is designed to accurately align reads spanning exon-exon junctions.

> **Alternative to:** HISAT2

## Purpose
- Align RNA-seq reads to a reference genome
- Detect splice junctions
- Generate SAM/BAM alignment files

## Installation

### Ubuntu/Debian

```bash
sudo apt update
sudo apt install star
```

> If STAR is not available through your Ubuntu repository, install it using Conda.

### Conda

```bash
conda install -c bioconda star
```

### Check Installation

```bash
STAR --version
```

## Input

```text
Reference Genome (genome.fa)

Gene Annotation (annotation.gtf)

Trimmed Reads
clean_R1.fastq.gz
clean_R2.fastq.gz
```

## Step 1: Generate Genome Index (does not align reads , preparing the  reference genome )

```bash
mkdir genome_index

STAR \
--runThreadN 8 \
--runMode genomeGenerate \
--genomeDir genome_index \
--genomeFastaFiles genome.fa \
--sjdbGTFfile annotation.gtf \
--sjdbOverhang 99
```

> This step is performed only once for each reference genome.

## Step 2: Align Reads(alignment commands)

```bash
STAR \
--runThreadN 8 \
--genomeDir genome_index \
--readFilesIn clean_R1.fastq.gz clean_R2.fastq.gz \
--readFilesCommand zcat \
--outFileNamePrefix sample_ \
--outSAMtype BAM SortedByCoordinate
```

## Common Options

| Option | Description |
|---------|-------------|
| `--runThreadN` | Number of CPU threads | can use 16 based on your computer cpu 
| `--runMode genomeGenerate `| build a genome index
| `--genomeDir` | Genome index directory |
| `--readFilesIn` | Input FASTQ files |
| `--readFilesCommand zcat` | Read compressed FASTQ files |
| `--outFileNamePrefix` | Output file prefix |
| `--outSAMtype BAM SortedByCoordinate` | Generate sorted BAM file |

## Output

```text
sample_Aligned.sortedByCoord.out.bam
sample_Log.final.out
sample_Log.out
sample_Log.progress.out
sample_SJ.out.tab
```

## Interpretation

- **Aligned.sortedByCoord.out.bam** → Main alignment file used for downstream analysis.
- **SJ.out.tab** → Detected splice junctions.
- **Log.final.out** → Alignment statistics (mapping rate, uniquely mapped reads, etc.).

## Next Step

Use the sorted BAM file as input for **featureCounts** to quantify gene expression.