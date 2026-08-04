# fastp

fastp is an all-in-one FASTQ preprocessing tool used to improve read quality by trimming adapters, filtering low-quality reads, and generating quality reports.

## Purpose

- Remove adapter sequences
- Trim low-quality bases
- Filter poor-quality reads
- Remove short reads
- Generate quality reports

## Installation

### Ubuntu/Debian

```bash
sudo apt update
sudo apt install fastp
```

### Conda

```bash
conda install -c bioconda fastp
```

### Check Installation

```bash
fastp --version
```

## Input

```text
sample_R1.fastq.gz
sample_R2.fastq.gz
```

## Run fastp

Paired-end reads

```bash
fastp \
-i sample_R1.fastq.gz \
-I sample_R2.fastq.gz \
-o clean_R1.fastq.gz \
-O clean_R2.fastq.gz
```

Single-end reads

```bash
fastp \
-i sample.fastq.gz \
-o clean.fastq.gz
```

Generate HTML and JSON reports

```bash
fastp \
-i sample_R1.fastq.gz \
-I sample_R2.fastq.gz \
-o clean_R1.fastq.gz \
-O clean_R2.fastq.gz \
-h fastp.html \
-j fastp.json
```

## Common Options

| Option | Description |
|--------|-------------|
| `-i` | Input Read 1 |
| `-I` | Input Read 2 |
| `-o` | Output Read 1 |
| `-O` | Output Read 2 |
| `-h` | HTML report |
| `-j` | JSON report |
| `-w` | Number of threads |

Example using 8 threads

```bash
fastp \
-i sample_R1.fastq.gz \
-I sample_R2.fastq.gz \
-o clean_R1.fastq.gz \
-O clean_R2.fastq.gz \
-h fastp.html \
-j fastp.json \
-w 8
```

## Output

```text
clean_R1.fastq.gz
clean_R2.fastq.gz
fastp.html
fastp.json
```

## View Report

Linux

```bash
xdg-open fastp.html
```

Windows

Open `fastp.html` in any web browser.

## Report Summary

| Section | Description |
|---------|-------------|
| Before Filtering | Quality before trimming |
| After Filtering | Quality after trimming |
| Quality Curves | Base quality across reads |
| Adapter Trimming | Adapters removed |
| Read Filtering | Reads retained and discarded |
| Duplication Rate | Duplicate reads |
| Insert Size | Fragment size distribution (paired-end) |

## Interpretation

- Higher quality scores after filtering indicate successful trimming.
- Adapter content should be reduced or eliminated.
- Low-quality reads should decrease.
- Review the number of reads retained after filtering.

## Next Step

Run **FastQC** again on the cleaned FASTQ files to verify that trimming improved the read quality, then proceed to **STAR** or **HISAT2** for alignment.