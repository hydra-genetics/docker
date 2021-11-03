# The build-stage image:
FROM continuumio/miniconda3  AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack
RUN conda create --name hydra -c bioconda -c conda-forge freebayes=1.3.1 bcftools=1.14 parallel=20190522 bedtools=2.29 sed=4.7 snakemake-wrapper-utils=0.2.0

# Use conda-pack to create a standalone enviornment
# in /venv:
RUN conda-pack -n hydra -o /tmp/env.tar && \
  mkdir /venv && cd /venv && tar xf /tmp/env.tar && \
  rm /tmp/env.tar

# We've put venv in same path it'll be in final image,
# so now fix up paths:
RUN /venv/bin/conda-unpack

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:buster-slim AS runtime

################## METADATA ######################
LABEL VERSION=1.3.1
LABEL freebayes=1.3.1
LABEL bcftools=1.11
LABEL parallel=20190522
LABEL bedtools=2.29
LABEL sed=4.7
LABEL snakemake-wrapper-utils=0.2.0
################## MAINTAINER ######################
MAINTAINER Patrik Smeds <patrik.smeds@scilifelab.uu.se>

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr/local
