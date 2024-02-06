# The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build


# Update package list, install dependencies for Conda
RUN apt-get update && apt-get install -y wget=1.20.1-1.1 bzip2=1.0.6-9.2~deb10u2 --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
    conda create --name hydra -c bioconda -c conda-forge \
    python=3.9 \
    pbmm2=1.10.0 \
    snakemake-wrapper-utils=0.5.3

# Set the environment variable
ENV CONDA_ENVIRONMENT hydra

# Modify the .bashrc file
RUN echo "source activate ${CONDA_ENVIRONMENT}" >> ~/.bashrc



# Use conda-pack to create a standalone enviornment
# in /venv:
#RUN conda-pack -n hydra -o /tmp/env.tar
#WORKDIR /venv
#RUN tar xf /tmp/env.tar

# We've put venv in same path it'll be in final image,
# so now fix up paths:
# RUN /venv/bin/conda-unpack

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
# FROM debian:buster-slim AS runtime

################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL pbmm2=1.10.0
LABEL version=1.10.0


# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
# COPY --from=build /venv /usr/local

# Unite test: pbmm2 align


