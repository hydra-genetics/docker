ARG VERSION=2.2
FROM continuumio/miniconda3:4.10.3 AS build

# Set the working directory
WORKDIR /usr/local

# Install git
RUN apt-get update && apt-get install -y git=1:2.20.1-2+deb10u3 --no-install-recommends  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Change to the cloned directory
WORKDIR /usr/local

# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
conda create -y -n hydra -c bioconda sniffles=2.2 && \
conda clean -afy

# Use conda-pack to create a standalone enviornment
# in /venv:
# We've put venv in same path it'll be in final image,
# so now fix up paths:
RUN conda-pack -n hydra -o /tmp/env.tar
WORKDIR /venv
RUN tar xf /tmp/env.tar && \
 /venv/bin/conda-unpack

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:buster-slim AS runtime
ARG VERSION

################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL sniffles2e=${VERSION}
RUN echo "${VERSION}"

# Unite test: samtools;  sniffles

#RUN mkdir -p /usr
COPY --from=build /venv  /usr/


