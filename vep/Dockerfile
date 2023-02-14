# The build-stage image:
FROM continuumio/miniconda3:22.11.1 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
    conda create --name hydra -c bioconda \
    bcftools=1.8 \
    ensembl-vep=108.0 \
    snakemake-wrapper-utils=0.4.0

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
LABEL version=108.0
LABEL bcftools=1.8
LABEL ensembl-vep=108.0
LABEL snakemake-wrapper-utils=0.4.0

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr/local
