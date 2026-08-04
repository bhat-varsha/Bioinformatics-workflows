# FastQC

FastQC is a quality control (QC) tool used to assess the quality of raw sequencing reads (FASTQ files).

## Installation

### Ubuntu/Debian

```bash
sudo apt update
sudo apt install fastqc
```

### Conda

```bash
conda install -c bioconda fastqc
```

### Check Installation

```bash
fastqc --version
```

## Input

```text
sample_R1.fastq.gz
sample_R2.fastq.gz
```

## Run FastQC

Single file

```bash
fastqc sample.fastq.gz
```

Paired-end reads

```bash
fastqc sample_R1.fastq.gz sample_R2.fastq.gz
```

Save output

```bash
mkdir fastqc

fastqc sample_R1.fastq.gz sample_R2.fastq.gz \
-o fastqc
```

## Output

```text
sample_R1_fastqc.html
sample_R1_fastqc.zip

sample_R2_fastqc.html
sample_R2_fastqc.zip
```

## View Report

Linux

```bash
xdg-open sample_R1_fastqc.html
```

Windows

Open the `.html` file in any web browser.

## Report Summary

| Module | Description |
|---------|-------------|
| Basic Statistics | File summary |
| Per Base Quality | Quality score across bases |
| GC Content | GC distribution |
| Duplication Levels | Duplicate reads |
| Adapter Content | Adapter contamination |
| Overrepresented Sequences | Frequent sequences |

## Interpretation

- PASS → Good quality
- WARN → Check the report
- FAIL → Trimming or cleaning may be needed

## Next Step

Run **fastp** to remove adapters and low-quality bases (if required).