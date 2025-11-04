# Originally created by Carlos Borroto (https://github.com/GeneDx/scramble)

## Edited by Julia Höglund to update R and Bioconductor versions
## as well as for buillding from the hydra-genetics docker repo.
# Updated ubuntu to support rBLAST from Bioconductor 3.18+
# Added locked versions to apt packages
# changed biocmanager to be installed in a run R command
# added biocmanager dependencies that need to explicitly be installed before rblast
# updated rBLAST to install from dev branch and set dependencies to TRUE
# added additional devtools dependencies after updating ubuntu base image
# added CRAN snapshot to lock R package versions


FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV R_VERSION=4.3.3
ENV BIOC_VERSION=3.18

# apt-get update and install global requirements
RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y --no-install-recommends \
        autoconf=2.71* \
        autogen=1:5.18.16* \
        build-essential=12.10* \
        curl=8.5.0* \
        git=1:2.43.0* \
        libfontconfig1-dev=2.15.0* \
        libfreetype-dev=2.13.2* \
        libfribidi-dev=1.0.13* \
        libharfbuzz-dev=8.3.0* \
        libgit2-dev=1.7.2* \
        libpng-dev=1.6.43* \
        libtiff-dev=4.5.1* \
        libjpeg-dev=8c* \
        libbz2-dev=1.0.8* \
        libcurl4-gnutls-dev=8.5.0* \
        libhts3t64=1.19* \
        libhts-dev=1.19* \
        liblzma-dev=5.6.1* \
        libncurses-dev=6.4* \
        libssl-dev=3.0.13* \
        libsqlite3-dev=3.45.1* \
        libxml2-dev=2.9.14* \
        ncbi-blast+=2.12.0* \
        r-base=4.3.3* \
        r-bioc-biostrings=2.70.2* \
        r-bioc-rsamtools=2.18.0* \
        r-cran-stringr=1.5.1* \
        r-cran-optparse=1.7.4* \
        zlib1g-dev=1:1.3* \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

# install global r requirements
# Using a recent CRAN snapshot compatible with Ubuntu 24.04
ENV CRAN_SNAPSHOT=https://packagemanager.posit.co/cran/2024-10-01
RUN echo "local({ r <- getOption('repos'); r['CRAN'] <- '${CRAN_SNAPSHOT}'; options(repos = r) })" > ~/.Rprofile \
  && Rscript -e "if (!require('BiocManager', quietly = TRUE)) install.packages('BiocManager')" \
  && Rscript -e "BiocManager::install(version = '${BIOC_VERSION}', ask = FALSE, update = FALSE)" \
  && Rscript -e "if (!require('devtools', quietly = TRUE)) install.packages('devtools')" \
  && Rscript -e "BiocManager::install('BiocFileCache', ask = FALSE, update = FALSE)" \
  && Rscript -e "devtools::install_github('mhahsler/rBLAST', ref = 'devel', dependencies = TRUE)" \
  && Rscript -e "if (!require('rBLAST')) stop('rBLAST installation failed')"

# install scramble from GitHub
RUN git clone https://github.com/GeneDx/scramble.git /opt/scramble
WORKDIR /opt/scramble/cluster_identifier/src
RUN make \
  && ln -s /opt/scramble/cluster_identifier/src/build/cluster_identifier /usr/local/bin/cluster_identifier \
  && ln -s /opt/scramble/cluster_analysis/bin/SCRAMble.R /usr/local/bin/SCRAMble.R

# Set working directory
WORKDIR /data

# define default command
CMD ["Rscript"]

################## METADATA ######################
LABEL maintainer="julia.hoglund@scilifelab.uu.se"
LABEL version=1.0.2
LABEL r-base=4.3.3
LABEL bioconductor=3.18