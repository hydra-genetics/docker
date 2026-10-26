ARG VERSION=1.1.a
ARG WRAPPER_UTILS_VERSION=0.3.1

# The build-stage image:
FROM continuumio/miniconda3:25.3.1-1 AS build

ARG VERSION
ARG WRAPPER_UTILS_VERSION
ENV VERSION=${VERSION}

RUN conda install -c conda-forge conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda -c conda-forge \
      msisensor-pro=${VERSION} \
      python=3.9 \
      snakemake-wrapper-utils=${WRAPPER_UTILS_VERSION}

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:bookworm-slim AS runtime

ARG VERSION
ARG WRAPPER_UTILS_VERSION
ENV VERSION=${VERSION}

################## METADATA ######################
LABEL maintainer="patrik.smeds@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL msisensor-pro=${VERSION}
LABEL snakemake-wrapper-utils=${WRAPPER_UTILS_VERSION}

# Copy the Conda environment from the build stage
# and update PATH to make tools available without
# explicit activation
COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin
