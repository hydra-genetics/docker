# The build-stage image:
FROM continuumio/miniconda3:25.3.1-1 AS build

RUN conda install -c conda-forge conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda -c conda-forge \
    picard=2.25.0 \
    python=3.11 \
    r-base=3.6.2 \
    snakemake-wrapper-utils=0.9.0

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:bookworm-slim AS runtime

################## METADATA ######################
LABEL maintainer="patrik.smeds@scilifelab.uu.se"
LABEL version=2.25.0-1
LABEL picard=2.25.0
LABEL python=3.11
LABEL r-base=3.6.2
LABEL snakemake-wrapper-utils=0.9.0

# Copy the Conda environment from the build stage
# and update PATH to make tools available without
# explicit activation
COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin
