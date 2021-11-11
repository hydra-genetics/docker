# The build-stage image:
FROM continuumio/miniconda3  AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack
RUN conda create --name hydra -c bioconda  -c conda-forge  \
	bcftools=1.14 \
	samtools=1.14 \
	bedtools=2.30 \
	tabix=1.11 \
	python=3.9 \
	pysam=0.17.0 \
        snakemake-wrapper-utils=0.2.0

RUN conda install -c conda-forge conda-pack

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
LABEL VERSION=0.0.1
LABEL bcftools=1.14
LABEL samtools=1.14
LABEL bedtools=2.30
LABEL tabix=1.11
LABEL python=3.9
LABEL pysam=0.17.0
LABEL snakemake-wrapper-utils=0.2.0
################## MAINTAINER ######################
MAINTAINER Patrik Smeds <patrik.smeds@scilifelab.uu.se>

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr/local
