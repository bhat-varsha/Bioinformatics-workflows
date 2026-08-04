# Trimmomatic

Trimmomatic is a read trimming tool used to remove adapter sequences, low-quality bases, and short reads from FASTQ files before downstream analysis.

> **Alternative to:** fastp

## Purpose
- Remove adapter sequences
- Trim low-quality bases
- Remove leading/trailing poor-quality bases
- Remove short reads
- Improve read quality before alignment

## Installation

### Ubuntu/Debian

```bash
sudo apt update
sudo apt install trimmomatic
```

### Conda
If Conda is not installed, install Miniconda first.

Download Miniconda

```bash
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
```

Install

```bash
bash Miniconda3-latest-Linux-x86_64.sh
```

Reload the terminal

```bash
source ~/.bashrc
```

Install Trimmomatic

```bash
conda install -c bioconda trimmomatic
```

### Check Installation

```bash
trimmomatic -version
```

## Input

```text
sample_R1.fastq.gz
sample_R2.fastq.gz
```

## Run Trimmomatic

Paired-end reads

```bash
trimmomatic PE \
sample_R1.fastq.gz \
sample_R2.fastq.gz \
paired_R1.fastq.gz \
unpaired_R1.fastq.gz \
paired_R2.fastq.gz \
unpaired_R2.fastq.gz \
SLIDINGWINDOW:4:20 \
MINLEN:50
```

Single-end reads

```bash
trimmomatic SE \
sample.fastq.gz \
trimmed.fastq.gz \
SLIDINGWINDOW:4:20 \
MINLEN:50
```

## Common Options

| Option | Description |
|---------|-------------|
| `PE` | Paired-end mode |
| `SE` | Single-end mode |
| `SLIDINGWINDOW:4:20` | Trim when average quality in a 4-base window drops below 20 |
| `LEADING:3` | Remove low-quality bases from the start |
| `TRAILING:3` | Remove low-quality bases from the end |
| `MINLEN:50` | Discard reads shorter than 50 bases |
| `ILLUMINACLIP` | Remove adapter sequences |

## Output

```text
paired_R1.fastq.gz
unpaired_R1.fastq.gz
paired_R2.fastq.gz
unpaired_R2.fastq.gz
```

## Interpretation

- Paired files are used for downstream analysis.
- Unpaired files contain reads whose mate was removed during trimming.
- Reads with low quality or adapters are filtered out.

## Next Step

Run **STAR** or **HISAT2** to align the trimmed reads to the reference genome.