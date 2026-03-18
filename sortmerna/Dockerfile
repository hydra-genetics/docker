# The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
    conda create --name hydra -c bioconda -c conda-forge \
    jinja2=3.0.1 \
    pigz=2.9rc3 \
    python=3.9 \
    pyyaml=6.0.3 \
    rapidgzip=0.16.0 \
    requests=2.32.5 \
    snakemake-wrapper-utils=0.3.1 \
    sortmerna=4.3.4

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
LABEL maintainer="martin.rippin@scilifelab.uu.se"
LABEL version=4.3.4
LABEL jinja2=3.0.1
LABEL pigz=2.9rc3
LABEL python=3.9
LABEL pyyaml=6.0.3
LABEL rapidgzip=0.16.0
LABEL requests=2.32.5
LABEL snakemake-wrapper-utils=0.3.1
LABEL sortmerna=4.3.4

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr/local
