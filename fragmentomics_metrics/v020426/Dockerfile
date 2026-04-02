FROM condaforge/mambaforge:23.3.1-1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

################## METADATA ######################
LABEL version=020426
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL snakemake=7.15.1
LABEL bedtools=2.26.0
LABEL sambamba=0.8.2
LABEL bedops=2.4.40
LABEL r-base=4.3.3
LABEL r-tidyverse=2.0.0
LABEL r-entropy=1.3.1
LABEL r-tidymodels=1.1.0
LABEL r-glmnet=4.1-7
LABEL r-fmsb=0.7.5
LABEL r-proc=1.18.2
LABEL r-dosnow=1.0.20
LABEL r-themis=1.0.1
LABEL r-patchwork=1.1.2
LABEL r-pals=1.8
LABEL r-rcolorbrewer=1.1-3

WORKDIR /app

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    build-essential=12.8* \
    libxml2-dev=2.9.10* \
    libcurl4-openssl-dev=7.68.0* \
    libssl-dev=1.1.1f* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY environment.yaml .

RUN mamba env create -f environment.yaml && \
    mamba clean -afy && \
    groupadd -r fragmentomics && useradd -m -r -g fragmentomics fragmentomics && \
    chown -R fragmentomics:fragmentomics /app /opt/conda/envs/fragmentomics_metrics

USER fragmentomics

ENV PATH="/opt/conda/envs/fragmentomics_metrics/bin:$PATH"

CMD ["/bin/bash"]