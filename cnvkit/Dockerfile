# The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack
RUN conda create --name hydra -c bioconda -c conda-forge \
    cnvkit=0.9.9 \
    joblib=0.17.0 \
    python=3.9 \
    r-base=4.1.2 \
    snakemake-wrapper-utils=0.3.1

# Use conda-pack to create a standalone enviornment
# in /venv:
RUN conda-pack -n hydra -o /tmp/env.tar
WORKDIR /venv
RUN tar xf /tmp/env.tar && \
    rm /tmp/env.tar

# We've put venv in same path it'll be in final image,
# so now fix up paths:
RUN /venv/bin/conda-unpack

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:buster-slim AS runtime

################## METADATA ######################
LABEL VERSION=0.9.9
LABEL cnvkit=0.9.9
LABEL snakemake-wrapper-utils=0.3.1
################## MAINTAINER ######################
MAINTAINER Patrik Smeds <patrik.smeds@scilifelab.uu.se>

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
RUN rm -rf /usr/local/*
COPY --from=build /venv /usr/local
