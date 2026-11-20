# hydra-genetics version tag
ARG VERSION=4.3.0

# The build-stage image:
FROM continuumio/miniconda3:25.3.1-1 AS build
ARG VERSION

RUN conda install -c conda-forge conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda -c conda-forge \
      bc=1.07.1 \
      bcftools=1.21 \
      bedtools=2.31.1 \
      cyvcf2=0.31.1 \
      datrie=0.8.2 \
      git=2.52.0 \
      pysam=0.23.0 \
      python=3.9 \
      samtools=1.21 \
      pyaml-env=1.2.2 \
      pyvcf=0.6.8 \
      snakemake-wrapper-utils=0.7.2 \
      scipy=1.13.1 \
      snakemake-minimal=7.32.4 \
      xlsxwriter=3.2.3 && \
    conda run -n hydra pip install --no-cache-dir hydra-genetics==${VERSION}

FROM debian:bookworm-slim AS runtime
ARG VERSION

################## METADATA ######################
LABEL maintainer="patrik.smeds@scilifelab.uu.se,jonas.almlof@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL bc=1.07.1
LABEL bcftools=1.21
LABEL bedtools=2.31.1
LABEL cyvcf2=0.31.1
LABEL datrie=0.8.2
LABEL git=2.52.0
LABEL hydra-genetics=${VERSION}
LABEL python=3.9
LABEL pysam=0.23.0
LABEL samtools=1.21
LABEL pyaml-env=1.2.2
LABEL pyvcf=0.6.8
LABEL snakemake-wrapper-utils=0.7.2
LABEL snakemake=7.32.4
LABEL xlsxwriter=3.2.3
LABEL scipy=1.13.1

# Create a non-root user/group with fixed UID/GID
RUN groupadd --gid 1000 hydra && \
    useradd --uid 1000 --gid 1000 --create-home --shell /bin/bash hydra

# Copy the Conda environment from the build stage (owned by root,
# read-only for the hydra user)
# and update PATH to make tools available without
# explicit activation
COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=/opt/conda/envs/hydra/bin:${PATH}

USER hydra
