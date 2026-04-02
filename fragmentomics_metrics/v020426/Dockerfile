FROM condaforge/mambaforge:23.3.1-1

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se" \
      version="020426" \
      snakemake="7.15.1" \
      bedtools="2.26.0" \
      sambamba="0.8.2" \
      bedops="2.4.40" \
      r-base="4.3.3" \
      r-tidyverse="2.0.0" \
      r-entropy="1.3.1" \
      r-tidymodels="1.1.0" \
      r-glmnet="4.1-7" \
      r-fmsb="0.7.5" \
      r-proc="1.18.2" \
      r-dosnow="1.0.20" \
      r-themis="1.0.1" \
      r-patchwork="1.1.2" \
      r-pals="1.8" \
      r-rcolorbrewer="1.1-3"

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