ARG VERSION=4.6.2.0
# The build-stage image:
FROM continuumio/miniconda3:25.3.1-1 AS build

ARG VERSION
ENV VERSION=${VERSION}

# Install conda-pack:
RUN conda install -c conda-forge conda-pack conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda  -c conda-forge \
        gatk4=${VERSION} \
        python=3.12 \
        snakemake-wrapper-utils=0.9.0

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:bookworm-slim AS runtime

ARG VERSION
ENV VERSION=${VERSION}  

################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version=${VERSION}-1
LABEL gatk4=${VERSION}
LABEL python=3.12
LABEL snakemake-wrapper-utils=0.9.0

COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin
