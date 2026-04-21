# syntax=docker/dockerfile:1
FROM debian:bookworm-slim

LABEL description="Arriba v2.5.1 - Fusion gene detection from RNA-Seq data"
LABEL arriba="2.5.1"
LABEL maintainer="nina.hollfelder@scilifelab.uu.se"
LABEL version="2.5.1"

ARG ARRIBA_VERSION=2.5.1
ARG DEBIAN_FRONTEND=noninteractive

# Set pipefail so piped commands fail properly (DL4006)
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install system dependencies
# - build-essential, make, g++: compile arriba from source
# - wget, ca-certificates: download source and references
# - rna-star, samtools: alignment tools required by arriba
# - r-base + R packages: required by draw_fusions.R
# - libxml2: runtime dependency
# - zlib1g-dev, libbz2-dev, liblzma-dev: htslib build dependencies
# hadolint ignore=DL3008
RUN apt-get update -y && \
    apt-get install -y --no-install-recommends \
        wget \
        ca-certificates \
        build-essential \
        make \
        g++ \
        zlib1g-dev \
        libbz2-dev \
        liblzma-dev \
        rna-star \
        samtools \
        r-base \
        r-cran-circlize \
        r-bioc-genomicalignments \
        r-bioc-genomicranges \
        libxml2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and compile arriba from source
WORKDIR /opt/arriba_v${ARRIBA_VERSION}
RUN wget -qO - "https://github.com/suhrig/arriba/releases/download/v${ARRIBA_VERSION}/arriba_v${ARRIBA_VERSION}.tar.gz" | \
    tar -xzf - --strip-components=1 && \
    make && \
    # Install the arriba binary to /usr/local/bin
    cp arriba /usr/local/bin/ && \
    cp draw_fusions.R /usr/local/bin/ && \
    chmod a+x /usr/local/bin/draw_fusions.R && \
    # Copy helper scripts
    cp run_arriba.sh /usr/local/bin/ && \
    cp download_references.sh /usr/local/bin/ && \
    chmod a+x /usr/local/bin/run_arriba.sh /usr/local/bin/download_references.sh && \
    # Copy database files (blacklists, known fusions, protein domains, cytobands)
    mkdir -p /usr/local/share/arriba && \
    cp -r database/* /usr/local/share/arriba/

# Create directories for references and output
RUN mkdir -p /references /output

# Wrapper script for download_references.sh
COPY --chmod=755 <<'EOF' /usr/local/bin/download_refs.sh
#!/bin/bash
cd /references || exit 1
/usr/local/bin/download_references.sh "$1" && \
ASSEMBLY=$(sed -e "s/viral+.*//" -e "s/+.*//" <<<"$1") && \
cp /usr/local/share/arriba/*"${ASSEMBLY}"* /references
EOF

# Wrapper script for running arriba
COPY --chmod=755 <<'EOF' /usr/local/bin/arriba.sh
#!/bin/bash
cd /output || exit 1
/usr/local/bin/run_arriba.sh \
  /references/STAR_index_* \
  /references/*.gtf \
  /references/*.fa \
  /references/blacklist_*.tsv.gz \
  /references/known_fusions_*.tsv.gz \
  /references/protein_domains_*.gff3 \
  "${THREADS-8}" \
  /read1.fastq.gz \
  $(ls /read2.fastq.gz 2> /dev/null)
EOF

# Wrapper script for draw_fusions.R
COPY --chmod=755 <<'EOF' /usr/local/bin/draw_fusions.sh
#!/bin/bash
Rscript /usr/local/bin/draw_fusions.R \
  --annotation="$(ls /references/*.gtf)" \
  --fusions=/fusions.tsv \
  --output=/output/fusions.pdf \
  --proteinDomains="$(ls /references/protein_domains_*.gff3)" \
  --alignments=/Aligned.sortedByCoord.out.bam \
  --cytobands="$(ls /references/cytobands_*.tsv)"
EOF

WORKDIR /output

# Verify installation
RUN arriba -h 2>&1 || true && \
    Rscript -e 'library(circlize); library(GenomicAlignments); library(GenomicRanges); cat("R packages OK\n")'

CMD ["bash"]

