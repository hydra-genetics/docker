# Updated to support rBLAST from Bioconductor 3.18+
FROM ubuntu:24.04

# Metadata
LABEL maintainer="updated by julia höglund 2025-10-27"
LABEL description="SCRAMble - https://github.com/GeneDx/scramble"
LABEL version="1.0"

# set noninterative mode
ENV DEBIAN_FRONTEND=noninteractive

# R 4.3.3 (from Ubuntu 24.04) -> Bioconductor 3.18
ENV R_VERSION=4.3.3
ENV BIOC_VERSION=3.18

# apt-get update and install global requirements
# linting: ha versioner på paketen här 
# info: se docker repo på hydra genetics
# pipa log när den byggs istället för som den gör och lås senare.
RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  \
        autoconf \
        autogen \
        build-essential \
        curl \
        libbz2-dev \
        libcurl4-gnutls-dev \
        libhts3 \
        libhts-dev \
        liblzma-dev \
        libncurses5-dev \
        libnss-sss \
        libssl-dev \
        libxml2-dev \
        ncbi-blast+ \
        r-base \
        r-bioc-biostrings \
        r-bioc-rsamtools \
        r-cran-stringr \
        r-cran-optparse \
        zlib1g-dev

# apt-get clean and remove cached source lists
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install global r requirements
# Using snapshot from 2024-04-01 for reproducibility; compatible with R 4.3.3
ENV CRAN_SNAPSHOT=https://packagemanager.posit.co/cran/2024-04-01
RUN echo "local({ r <- getOption('repos'); r['CRAN'] <- '${CRAN_SNAPSHOT}'; options(repos = r) })" > ~/.Rprofile

# Install BiocManager and set Bioconductor version
# kommer klaga sätt dom som och (&&)
RUN Rscript -e "if (!require('BiocManager', quietly = TRUE)) install.packages('BiocManager')"
RUN Rscript -e "BiocManager::install(version = '${BIOC_VERSION}', ask = FALSE, update = FALSE)"

RUN Rscript -e "if (!require('devtools', quietly = TRUE)) install.packages('devtools')"
RUN Rscript -e "devtools::install_github('mhahsler/rBLAST', ref = 'devel', dependencies = TRUE)"
RUN Rscript -e "if (!require('rBLAST')) stop('rBLAST installation failed')"

# install scramble
# ändra path i env så den inte hårdkodas i kommandot
COPY . /app
RUN cd /app/cluster_identifier/src && \
  make
RUN ln -s /app/cluster_identifier/src/build/cluster_identifier /usr/local/bin

# define default command
CMD ["Rscript"]

