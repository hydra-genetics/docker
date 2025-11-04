# Define version args for both builds
ARG FREEBAYES_VERSION=1.3.7
ARG BCFTOOLS_VERSION=1.18
ARG BEDTOOLS_VERSION=2.29
ARG PARALLEL_VERSION=20190522
ARG SED_VERSION=4.7
ARG SNAKEMAKEWRAPPERUTILS_VERSION=0.6.2

# The build-stage image:
FROM continuumio/miniconda3:23.5.2-0 AS build

# Import version-args to use when installing
ARG FREEBAYES_VERSION
ARG BCFTOOLS_VERSION
ARG BEDTOOLS_VERSION
ARG PARALLEL_VERSION
ARG SED_VERSION
ARG SNAKEMAKEWRAPPERUTILS_VERSION

# Install softwares
RUN conda install -c conda-forge conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda  -c conda-forge \
    bcftools=${BCFTOOLS_VERSION} \
    bedtools=${BEDTOOLS_VERSION} \
    freebayes=${FREEBAYES_VERSION} \
    parallel=${PARALLEL_VERSION} \
    sed=${SED_VERSION} \
    #snakemake-wrapper-utils=${SNAKEMAKEWRAPPERUTILS_VERSION} \
    git



# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:buster-slim AS runtime

# Import version args to covert to env which persists after build command
ARG FREEBAYES_VERSION
ARG BCFTOOLS_VERSION
ARG BEDTOOLS_VERSION
ARG PARALLEL_VERSION
ARG SED_VERSION
ARG SNAKEMAKEWRAPPERUTILS_VERSION

ENV FREEBAYES_VERSION=${FREEBAYES_VERSION}
ENV BCFTOOLS_VERSION=${BCFTOOLS_VERSION}
ENV BEDTOOLS_VERSION=${BEDTOOLS_VERSION}
ENV PARALLEL_VERSION=${PARALLEL_VERSION}
ENV SED_VERSION=${SED_VERSION}
ENV SNAKEMAKEWRAPPERUTILS_VERSION=${SNAKEMAKEWRAPPERUTILS_VERSION}

################## METADATA ######################
LABEL maintainer="patrik.smeds@scilifelab.uu.se"
LABEL version=${FREEBAYES_VERSION}
LABEL bcftools=${BCFTOOLS_VERSION}
LABEL bedtools=${BEDTOOLS_VERSION}
LABEL freebayes=${FREEBAYES_VERSION}
LABEL parallel=${PARALLEL_VERSION}
LABEL sed=${SED_VERSION}
LABEL snakemake-wrapper-utils=${SNAKEMAKEWRAPPERUTILS_VERSION}

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin

RUN pip3 install git+https://github.com/snakemake/snakemake-wrapper-utils.git@Smeds-patch-1
