FROM r-base:4.1.2

# install curl and libcurl
RUN apt-get update \
  && apt-get install --no-install-recommends -y curl=7.82.0-2 libcurl4-openssl-dev=7.82.0-2 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && R -e "install.packages('remotes')" \
  && R -e "library(remotes); install_version('BiocManager', version='1.30.17')" \
  && R -e "library(BiocManager)" && R -e "BiocManager::install(ask = F)" \
  && R -e "BiocManager::install(c('GenomicRanges', 'Biostrings', 'Rsamtools', 'GenomicAlignments'))" \
  && R -e "library(remotes); install_version('ExomeDepth', v='1.1.15')"

################## METADATA ######################
LABEL maintainer="arielle.munters@scilifelab.uu.se"
LABEL version=1.1.15
LABEL exomedepth=1.1.15
LABEL r-base=4.1.2
LABEL genomicranges=1.46.1
LABEL rlang=1.0.2
