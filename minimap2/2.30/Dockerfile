ARG VERSION=2.30

# The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build

ARG VERSION
ENV VERSION=${VERSION}

RUN conda install -c conda-forge conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda -c conda-forge \
    minimap2=${VERSION} \
    samtools=1.23 \
    snakemake-wrapper-utils=0.6.1

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:buster-slim AS runtime

ARG VERSION
ENV VERSION=${VERSION}

################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL samtools=1.23
LABEL snakemake-wrapper-utils=0.6.1

COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin
