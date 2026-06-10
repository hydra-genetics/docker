# Dockerfile for Pelops – DUX4 rearrangement caller
# https://github.com/Illumina/Pelops

FROM python:3.12-slim

LABEL maintainer="nina.hollfelder@scilifelab.uu.se"
LABEL description="Pelops – Dedicated caller for DUX4 rearrangements from whole genome sequencing data"
LABEL org.opencontainers.image.source="https://github.com/Illumina/Pelops"
LABEL pelops=0.8.0
LABEL version=0.8.0

# Install system dependencies required for pysam / htslib (BAM/CRAM support)
# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        gcc \
        libz-dev \
        libbz2-dev \
        liblzma-dev \
        libcurl4-openssl-dev \
        libssl-dev \
        make \
        autoconf \
        automake \
        perl \
        procps \
    && rm -rf /var/lib/apt/lists/*

# Install Pelops from PyPI
RUN pip install --no-cache-dir ilmn-pelops==0.8.0 --upgrade

# Create a working directory for data
WORKDIR /data

# Default entrypoint: the pelops CLI
ENTRYPOINT ["pelops"]
CMD ["--help"]

