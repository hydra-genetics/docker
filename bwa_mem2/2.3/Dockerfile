ARG VERSION=2.3

# The build-stage image:
FROM continuumio/miniconda3:23.5.2-0 AS build

ARG VERSION
ENV VERSION=${VERSION}

RUN conda install -c conda-forge conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda -c conda-forge \
    bwa-mem2=${VERSION} \
    samtools=1.23 \
    python=3.9 \
    snakemake-wrapper-utils=0.6.1

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:buster-slim AS runtime

ARG VERSION
ENV VERSION=${VERSION}

################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL bwa-mem2=${VERSION}
LABEL samtools=1.23
LABEL python=3.9
LABEL snakemake-wrapper-utils=0.6.1

COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin
