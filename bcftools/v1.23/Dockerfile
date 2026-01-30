ARG VERSION=1.23

# The build-stage image:
FROM continuumio/miniconda3:23.5.2-0 AS build

ARG VERSION
ENV VERSION=${VERSION}

# Install conda-pack:
RUN conda install -c conda-forge conda-pack conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda  -c conda-forge \
        python=3.8 \
        bcftools=${VERSION} \
        snakemake-wrapper-utils=0.8.0

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:bookworm-slim AS runtime

ARG VERSION
ENV VERSION=${VERSION}

################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL bcftools=${VERSION}
LABEL snakemake-wrapper-utils=0.8.0


COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin
