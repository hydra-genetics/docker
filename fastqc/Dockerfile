# The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
    conda create --name hydra -c bioconda \
    fastqc=0.11.9 \
    snakemake-wrapper-utils=0.3.1

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
LABEL version=0.11.9
LABEL fastqc=0.11.9
LABEL snakemake-wrapper-utils=0.3.1

RUN apt-get update && \
    apt-get install --no-install-recommends -y libfreetype6=2.9.1-3+deb10u2 fontconfig=2.13.1-2 fonts-dejavu=2.37-1 && \
    rm -rf /var/lib/apt/lists/*
ENV FONTCONFIG_PATH="/etc/fonts"
ENV FONTCONFIG_FILE="/etc/fonts/fonts.conf"

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr/local
