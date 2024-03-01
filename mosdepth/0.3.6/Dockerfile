# Define version args for both builds
ARG MOSDEPTH_VERSION=0.3.6
ARG PYTHON_VERSION=3.9
ARG SNAKEMAKEWRAPPERUTILS_VERSION=0.3.1

# The build-stage image:
FROM continuumio/miniconda3:23.5.2-0 AS build

# Import version-args to use when installing
ARG MOSDEPTH_VERSION
ARG PYTHON_VERSION
ARG SNAKEMAKEWRAPPERUTILS_VERSION

# Install softwares
RUN conda install -c conda-forge conda-libmamba-solver && \
	conda config --set solver libmamba && \
    conda create --name hydra -c bioconda  -c conda-forge \
          mosdepth=${MOSDEPTH_VERSION} \
          python=${PYTHON_VERSION} \
          snakemake-wrapper-utils=${SNAKEMAKEWRAPPERUTILS_VERSION}

# # The runtime-stage image; we can use Debian as the
# # base image since the Conda env also includes Python
# # for us.
FROM debian:buster-slim AS runtime

# Import version args to covert to env which persists after build command
ARG MOSDEPTH_VERSION
ARG PYTHON_VERSION
ARG SNAKEMAKEWRAPPERUTILS_VERSION
ENV MOSDEPTH_ENV_VERSION=${MOSDEPTH_VERSION}
ENV PYTHON_ENV_VERSION=${PYTHON_VERSION}
ENV SNAKEMAKEWRAPPERUTILS_ENV_VERSION=$SNAKEMAKEWRAPPERUTILS_VERSION

################## METADATA ######################
LABEL maintainer="arielle.munters@scilifelab.uu.se"
LABEL version=${MOSDEPTH_VERSION}
LABEL mosdepth=${MOSDEPTH_VERSION}
LABEL snakemake-wrapper-utils=${SNAKEMAKEWRAPPERUTILS_VERSION}
LABEL python=${PYTHON_VERSION}

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin