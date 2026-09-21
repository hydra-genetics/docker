# The build-stage image:
FROM continuumio/miniconda3:25.3.1-1 AS build

RUN conda install -c conda-forge conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda -c conda-forge \
      bwa=0.7.17 \
      fgbio-minimal=4.1.1 \
      picard-slim=3.5.0 \
      python=3.12 \
      samtools=1.15 \
      snakemake-wrapper-utils=0.9.0

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:bookworm-slim AS runtime

################## METADATA ######################
LABEL maintainer="patrik.smeds@scilifelab.uu.se"
LABEL version=0.7.17-1
LABEL bwa=0.7.17
LABEL fgbio-minimal=4.1.1 
LABEL picard-slim=3.5.0 
LABEL python=3.12
LABEL samtools=1.15
LABEL snakemake-wrapper-utils=0.9.0

# Create a non-root user/group with fixed UID/GID
RUN groupadd --gid 1000 hydra && \
    useradd --uid 1000 --gid 1000 --no-create-home --shell /bin/bash hydra

# Copy the Conda environment from the build stage
# and update PATH to make tools available without
# explicit activation
COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
RUN chown -R hydra:hydra /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin

USER hydra
