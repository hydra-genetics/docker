# The build-stage image:
FROM continuumio/miniconda3:23.5.2-0 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack conda-libmamba-solver && \
    conda create --name hydra -c bioconda -c conda-forge \
    python=3.11 \
    fastqc=0.12.1 \
    snakemake-wrapper-utils=0.9.0

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
FROM debian:bookworm-slim AS runtime

################## METADATA ######################
LABEL maintainer="patrik.smeds@scilifelab.uu.se"
LABEL version=0.12.1
LABEL fastqc=0.12.1
LABEL snakemake-wrapper-utils=0.9.0
LABEL python=3.11

RUN apt-get update && \
    apt-get install --no-install-recommends -y libfreetype6=2.12.1+dfsg-5+deb12u4 fontconfig=2.14.1-4 fonts-dejavu=2.37-6 && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /usr/local/man
ENV FONTCONFIG_PATH="/etc/fonts"
ENV FONTCONFIG_FILE="/etc/fonts/fonts.conf"

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr/local
