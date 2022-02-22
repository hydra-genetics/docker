# The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
    conda create --name hydra -c bioconda -c conda-forge \
    bcftools=1.14 \
    bedtools=2.29 \
    freebayes=1.3.1 \
    parallel=20190522 \
    sed=4.7 \
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
LABEL version=1.3.1
LABEL bcftools=1.11
LABEL bedtools=2.29
LABEL freebayes=1.3.1
LABEL parallel=20190522
LABEL sed=4.7
LABEL snakemake-wrapper-utils=0.3.1

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr/local
