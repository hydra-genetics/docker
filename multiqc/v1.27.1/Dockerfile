# Define version args for both builds
ARG MULTIQC_VERSION=1.27.1
ARG MULTIQC_CGS_VERSION=1.0.0
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

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
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

# copy conda env from the build image and bin to path
COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin
RUN pip install --no-cache-dir setuptools==75.1.0 multiqc==${MULTIQC_VERSION} multiqc-cgs==${MULTIQC_CGS_VERSION}


