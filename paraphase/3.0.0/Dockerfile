# Use the specified Miniconda base image
ARG VERSION="3.0.0" 
FROM continuumio/miniconda3:4.10.3 AS build
ARG VERSION

# Set the working directory
WORKDIR /usr/local

# Install git
RUN apt-get update && apt-get install -y git=1:2.20.1-2+deb10u3 --no-install-recommends  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Change to the cloned directory
WORKDIR /usr/local/paraphase

# Install conda-pack:
RUN conda install -c conda-forge conda-pack
COPY ./paraphase/${VERSION}/environment.yml /tmp/environment.yml
RUN conda env create -f /tmp/environment.yml && \
    rm /tmp/environment.yml

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
ARG VERSION

################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version="${VERSION}"
LABEL paraphase="${VERSION}"
RUN echo "${VERSION}"

# Unite test: samtools;  minimap2;  paraphase

#RUN mkdir -p /usr
COPY --from=build /venv  /usr/





