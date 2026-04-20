FROM debian:bookworm-slim

LABEL description="Arriba v2.5.1 - Fusion gene detection from RNA-Seq data"
LABEL arriba="2.5.1"
LABEL maintainer="nina.hollfelder@scilifelab.uu.se"
LABEL version="2.5.1"

ARG ARRIBA_VERSION=2.5.1
ARG DEBIAN_FRONTEND=noninteractive

# Install system dependencies
# - build-essential, make, g++: compile arriba from source
# - wget, ca-certificates: download source and references
# - rna-star, samtools: alignment tools required by arriba
# - r-base + R packages: required by draw_fusions.R
# - libxml2: runtime dependency
# - zlib1g-dev, libbz2-dev, liblzma-dev: htslib build dependencies
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
WORKDIR /opt
RUN wget -qO - "https://github.com/suhrig/arriba/releases/download/v${ARRIBA_VERSION}/arriba_v${ARRIBA_VERSION}.tar.gz" | \
    tar -xzf - && \
    cd arriba_v${ARRIBA_VERSION} && \
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

# Make wrapper script for download_references.sh
RUN echo '#!/bin/bash\n\
cd /references\n\
/usr/local/bin/download_references.sh $1 && \\\n\
ASSEMBLY=$(sed -e "s/viral+.*//" -e "s/+.*//" <<<"$1") && \\\n\
cp /usr/local/share/arriba/*${ASSEMBLY}* /references' > /usr/local/bin/download_refs.sh && \
    chmod a+x /usr/local/bin/download_refs.sh

# Make wrapper script for running arriba
RUN echo '#!/bin/bash\n\
cd /output && \\\n\
/usr/local/bin/run_arriba.sh \
/references/STAR_index_* \
/references/*.gtf \
/references/*.fa \
/references/blacklist_*.tsv.gz \
/references/known_fusions_*.tsv.gz \
/references/protein_domains_*.gff3 \
${THREADS-8} \
/read1.fastq.gz \
$(ls /read2.fastq.gz 2> /dev/null)' > /usr/local/bin/arriba.sh && \
    chmod a+x /usr/local/bin/arriba.sh

# Make wrapper script for draw_fusions.R
RUN echo '#!/bin/bash\n\
Rscript /usr/local/bin/draw_fusions.R \
  --annotation=$(ls /references/*.gtf) \
  --fusions=/fusions.tsv \
  --output=/output/fusions.pdf \
  --proteinDomains=$(ls /references/protein_domains_*.gff3) \
  --alignments=/Aligned.sortedByCoord.out.bam \
  --cytobands=$(ls /references/cytobands_*.tsv)' > /usr/local/bin/draw_fusions.sh && \
    chmod a+x /usr/local/bin/draw_fusions.sh

WORKDIR /output

# Verify installation
RUN arriba -h 2>&1 | head -1 && \
    Rscript -e 'library(circlize); library(GenomicAlignments); library(GenomicRanges); cat("R packages OK\n")'

CMD ["bash"]

