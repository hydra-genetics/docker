ARG VERSION=2.3
ARG CONTAINER_VERSION=2.3-s9

# The build-stage image:
FROM continuumio/miniconda3:25.3.1-1 AS build

ARG VERSION
ENV VERSION=${VERSION}
ARG CONTAINER_VERSION
ENV CONTAINER_VERSION=${CONTAINER_VERSION}

RUN conda install -c conda-forge conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda -c conda-forge \
    bwa-mem2=${VERSION} \
    samtools=1.23 \
    python=3.11 \
    snakemake-wrapper-utils=0.9.0

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:bookworm-slim AS runtime

ARG VERSION
ENV VERSION=${VERSION}
ARG CONTAINER_VERSION

################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=${CONTAINER_VERSION}
LABEL bwa-mem2=${VERSION}
LABEL samtools=1.23
LABEL python=3.11
LABEL snakemake-wrapper-utils=0.9.0

COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin
