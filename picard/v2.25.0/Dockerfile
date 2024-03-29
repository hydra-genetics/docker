# The build-stage image:
FROM continuumio/miniconda3:23.5.2-0 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda -c conda-forge \
    picard=2.25.0 \
    python=3.9 \
    r-base=3.6.2 \
    snakemake-wrapper-utils=0.5.3

# Use conda-pack to create a standalone enviornment
# in /venv:
RUN conda-pack -n hydra -o /tmp/env.tar
WORKDIR /venv 
RUN tar xf /tmp/env.tar

# We've put venv in same path it'll be in final image,
# so now fix up paths:
RUN /venv/bin/conda-unpack

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:buster-slim AS runtime

################## METADATA ######################
LABEL maintainer="patrik.smeds@scilifelab.uu.se"
LABEL version=2.25.0
LABEL picard=2.25.0
LABEL bcftools=1.15.1
LABEL python=3.9
LABEL r-base=3.6.2
LABEL snakemake-wrapper-utils=0.6.2

# Copy /venv from the previous stage:
# to /usr to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr

RUN mkdir /venv && \
    ln -s /usr/lib /venv/lib && \
    ln -s /usr/bin /venv/bin && \
    ln -s /usr/ssl /venv/ssl
