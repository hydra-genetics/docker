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
        autoconf=2.71-3 \
        autogen=1:5.18.16-5build1 \
        build-essential=12.10ubuntu1 \
        curl=8.5.0-2ubuntu10.6 \
        libbz2-dev=1.0.8-5.1build0.1 \
        libcurl4-gnutls-dev=8.5.0-2ubuntu10.6 \
        libhts3=1.19+ds-1.1build3 \
        libhts-dev=1.19+ds-1.1build3 \
        liblzma-dev=5.6.1+really5.4.5-1ubuntu0.2 \
        libncurses5-dev=6.4+20240113-1ubuntu2 \
        libnss-sss=1.0.0-2ubuntu0.1 \
        libssl-dev=3.0.13-0ubuntu3.6 \
        libxml2-dev=2.9.14+dfsg-1.3ubuntu3.6 \
        ncbi-blast+=2.12.0+ds-4build2 \
        r-base=4.3.3-2build2 \
        r-bioc-biostrings=2.70.2+dfsg-1 \
        r-bioc-rsamtools=2.18.0+dfsg-1build2 \
        r-cran-stringr=1.5.1-1 \
        r-cran-optparse=1.7.4-1 \
        zlib1g-dev=1:1.3.dfsg-3.1ubuntu2.1 \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*

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