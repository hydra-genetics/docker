FROM ubuntu:22.10

ENV DEBIAN_FRONTEND=noninteractive

# install curl and libcurl
RUN apt-get update \
  && apt-get install --no-install-recommends -y git=1:2.37.2-1ubuntu1.4 curl=7.85.0-1ubuntu0.3 libcurl4-openssl-dev=7.85.0-1ubuntu0.3 wget=1.21.3-1ubuntu1 tar=1.34+dfsg-1ubuntu0.1.22.10.1 gzip=1.12-1ubuntu1 liblzma-dev=5.2.5-2.1 libxml2-dev=2.9.14+dfsg-1ubuntu0.1 libssl-dev=3.0.5-2ubuntu2.1 python3.10-venv=3.10.7-1ubuntu0.2 python3.10-dev=3.10.7-1ubuntu0.2 python3-pip=22.2+dfsg-1ubuntu0.2 r-base=4.2.1-3 build-essential=12.9ubuntu3 libpng-dev=1.6.38-2 libblas-dev=3.10.1-2 liblapack-dev=3.10.1-2 gfortran=4:12.2.0-1ubuntu1 libbz2-dev=1.0.8-5build1 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && R -e "install.packages('remotes')" \
  && R -e "library(remotes); install_version('BiocManager', version='1.30.20')" \
  && R -e "library(BiocManager)" && R -e "BiocManager::install(ask = F)" \
  && R -e "BiocManager::install(c('GenomicFeatures', 'Biostrings'))" \
  # && wget -q https://github.com/nghiavtr/FuSeq_WES/releases/download/v1.0.0/FuSeq_WES_v1.0.0.tar.gz -O FuSeq_WES_v1.0.0.tar.gz \
  # && tar -xzvf FuSeq_WES_v1.0.0.tar.gz \
  && git clone https://github.com/jonca79/FuSeq_WES.git /FuSeq_WES_v1.0.0 \
  && chmod +x -R /FuSeq_WES_v1.0.0/process_fuseq_wes.R \
  && chmod +x -R /FuSeq_WES_v1.0.0/fuseq_wes.py \
  && chmod +x -R /FuSeq_WES_v1.0.0/configure.sh

WORKDIR /FuSeq_WES_v1.0.0
RUN ./configure.sh

ENV PATH="/venv/bin/:${PATH}:/FuSeq_WES_v1.0.0"

RUN python3 -m venv /venv \
  # && . /venv/bin/activate \
  && pip install --no-cache-dir wheel==0.38.4 \
  && pip install --no-cache-dir pysam==0.18.0

################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=1.0.0
LABEL fuseq-wes=1.0.0
LABEL r-base=4.2.1
LABEL pysam=0.18.0
LABEL python=3.10
