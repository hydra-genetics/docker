# Originally created by Carlos Borroto (https://github.com/GeneDx/scramble)

## Edited by Julia Höglund to update R and Bioconductor versions
## as well as for buillding from the hydra-genetics docker repo.
# Updated ubuntu to support rBLAST from Bioconductor 3.18+
# Added fixed versions to apt packages
# Changed biocmanager to be installed in a run R command
# updated rBLAST to install from dev branch and set dependencies to TRUE

FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV R_VERSION=4.3.3
ENV BIOC_VERSION=3.18

# apt-get update and install global requirements
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
# todo: doublecheck snapshot if needed; doublecheck rBLAST version
ENV CRAN_SNAPSHOT=https://packagemanager.posit.co/cran/2024-04-01
RUN echo "local({ r <- getOption('repos'); r['CRAN'] <- '${CRAN_SNAPSHOT}'; options(repos = r) })" > ~/.Rprofile \
  && Rscript -e "if (!require('BiocManager', quietly = TRUE)) install.packages('BiocManager')" \
  && Rscript -e "BiocManager::install(version = '${BIOC_VERSION}', ask = FALSE, update = FALSE)" \
  && Rscript -e "if (!require('devtools', quietly = TRUE)) install.packages('devtools')" \
  && Rscript -e "devtools::install_github('mhahsler/rBLAST', ref = 'devel', dependencies = TRUE)" \
  && Rscript -e "if (!require('rBLAST')) stop('rBLAST installation failed')"

# install scramble
# todo: change path to hardcoded
COPY . /app
RUN cd /app/cluster_identifier/src && \
  make
RUN ln -s /app/cluster_identifier/src/build/cluster_identifier /usr/local/bin

# define default command
CMD ["Rscript"]

################## METADATA ######################
LABEL maintainer="julia.hoglund@scilifelab.uu.se"
LABEL version=1.0.2
LABEL r-base=4.3.3
LABEL bioconductor=3.18