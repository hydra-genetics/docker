# The build-stage image:
FROM continuumio/miniconda3:25.3.1-1 AS build

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
      pyvcf=0.6.8 \
      snakemake-wrapper-utils=0.7.2 \
      tabix=1.11 \
      scipy=1.13.1 \
      xlsxwriter=3.2.3 && \
    conda run -n hydra pip install --no-cache-dir hydra-genetics==4.0.0


FROM debian:bookworm-slim AS runtime

################## METADATA ######################
LABEL maintainer="patrik.smeds@scilifelab.uu.se,jonas.almlof@scilifelab.uu.se"
LABEL version=4.0.0
LABEL bc=1.07.1
LABEL bcftools=1.21
LABEL bedtools=2.31.1
LABEL cyvcf2=0.31.1
LABEL datrie=0.8.2
LABEL git=2.52.0
LABEL hydra-genetics=4.0.0
LABEL python=3.9
LABEL pysam=0.23.0
LABEL samtools=1.21
LABEL pyvcf=0.6.8
LABEL snakemake-wrapper-utils=0.7.2
LABEL tabix=1.11
LABEL xlsxwriter=3.2.3
LABEL scipy=1.13.1

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
