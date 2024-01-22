# The build-stage image:
FROM continuumio/miniconda3:23.5.2-0 AS build

RUN conda install -c conda-forge conda-pack conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda  -c conda-forge \
	  bcftools=1.15.1 \
      minimap2=2.17 \
	  samtools=1.14 

FROM ubuntu:20.04 AS runtime

################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version=1.11.3
LABEL pyabpoa=1.5.1
LABEL bcftools=1.15.1
LABEL medaka=1.11.3
LABEL minimap2=2.17
LABEL python=3.9
LABEL samtools=1.14


ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    build-essential=12.8ubuntu1 \
    python3.9=3.9.5-3ubuntu0~20.04.1 \
    python3-dev=3.8.2-0ubuntu2 \
    python3-pip=20.0.2-5ubuntu1.10 \
    zlib1g-dev=1:1.2.11.dfsg-2ubuntu1.5 && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir pyabpoa==1.5.1 medaka==1.11.3


COPY --from=build /opt/conda /opt/conda
ENV PATH=${PATH}:/opt/conda/bin:/opt/conda/envs/hydra/bin
