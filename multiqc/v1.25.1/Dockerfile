# Define version args for both builds
ARG MULTIQC_VERSION=1.25.1
ARG MULTIQC_CGS_VERSION=0.2
ARG SNAKEMAKEWRAPPERUTILS_VERSION=0.6.2

FROM continuumio/miniconda3:23.5.2-0 AS build

# Import version args to covert to env which persists after build command
ARG MULTIQC_VERSION
ARG MULTIQC_CGS_VERSION
ARG SNAKEMAKEWRAPPERUTILS_VERSION
ENV MULTIQC_VERSION=${MULTIQC_VERSION}
ENV MULTIQC_CGS_VERSION=${MULTIQC_CGS_VERSION}
ENV SNAKEMAKEWRAPPERUTILS_VERSION=${SNAKEMAKEWRAPPERUTILS_VERSION}

RUN conda install -c conda-forge conda-pack conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda -c conda-forge \
    snakemake-wrapper-utils=${SNAKEMAKEWRAPPERUTILS_VERSION}

# Use conda-pack to create a standalone enviornment
# in /venv:
RUN conda-pack -n hydra -o /tmp/env.tar
WORKDIR /venv
RUN tar xf /tmp/env.tar

# We've put venv in same path it'll be in final image,
# so now fix up paths:
RUN /venv/bin/conda-unpack


FROM debian:buster-slim AS runtime

ARG MULTIQC_VERSION
ARG MULTIQC_CGS_VERSION
ARG SNAKEMAKEWRAPPERUTILS_VERSION
ENV MULTIQC_VERSION=${MULTIQC_VERSION}
ENV MULTIQC_CGS_VERSION=${MULTIQC_CGS_VERSION}
ENV SNAKEMAKEWRAPPERUTILS_VERSION=${SNAKEMAKEWRAPPERUTILS_VERSION}

################## METADATA ######################
LABEL maintainer="patrik.smeds@scilifelab.uu.se"
LABEL version=${MULTIQC_VERSION}
LABEL multiqc=${MULTIQC_VERSION}
LABEL multiqc-cgs=${MULTIQC_CGS_VERSION}
LABEL snakemake-wrapper-utils=${SNAKEMAKEWRAPPERUTILS_VERSION}

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr
RUN pip install --no-cache-dir setuptools==75.1.0 multiqc==${MULTIQC_VERSION} multiqc-cgs==${MULTIQC_CGS_VERSION}

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env

