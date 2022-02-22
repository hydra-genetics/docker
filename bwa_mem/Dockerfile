# The build-stage image:
FROM continuumio/miniconda3:4.10.3  AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
    conda create --name hydra -c bioconda bwa=0.7.17 samtools=1.12 snakemake-wrapper-utils=0.2.0

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
LABEL VERSION=0.7.17
LABEL bwa=0.7.17
LABEL samtools=1.12
LABEL snakemake-wrapper-utils=0.2.0

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
RUN rm -rf /usr/local/*
COPY --from=build /venv /usr/local
