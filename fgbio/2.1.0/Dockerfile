# The build-stage image:
FROM continuumio/miniconda3:23.5.2-0 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda -c conda-forge \
    bwa=0.7.15 \
    samtools=1.15 \
    fgbio=2.1.0 \
    samblaster=0.1.26 \
    snakemake-wrapper-utils=0.6.2

# Use conda-pack to create a standalone enviornment
# in /venv:
RUN conda-pack -n hydra -o /tmp/env.tar
WORKDIR /venv
RUN tar xf /tmp/env.tar

# We've put venv in same path it'll be in final image,
# so now fix up paths:
RUN /venv/bin/conda-unpack

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes 
# Python for us.
FROM debian:buster-slim AS runtime

################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=2.1.0
LABEL bwa=0.7.15
LABEL samtools=1.15
LABEL fgbio=2.1.0
LABEL samblaster=0.1.26
LABEL snakemake-wrapper-utils=0.6.2

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr
