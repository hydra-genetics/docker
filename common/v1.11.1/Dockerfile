# The build-stage image:
FROM continuumio/miniconda3:23.5.2-0 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack conda-libmamba-solver && \
	conda config --set solver libmamba && \
    conda create --name hydra -c bioconda  -c conda-forge \
	  bcftools=1.15.1 \
	  bedtools=2.30 \
	  cyvcf2=0.30.15 \
	  datrie=0.8.2 \
	  git=2.39.1 \
	  pysam=0.18.0 \
	  python=3.9 \
	  samtools=1.15 \
	  pyvcf=0.6.8 \
	  snakemake-wrapper-utils=0.5.2 \
	  tabix=1.11 \
	  xlsxwriter=3.0.3

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:buster-slim AS runtime

################## METADATA ######################
LABEL maintainer="patrik.smeds@scilifelab.uu.se"
LABEL version=1.11.1
LABEL bcftools=1.15.1
LABEL bedtools=2.30
LABEL datrie=0.8.2
LABEL git=2.39.1
LABEL hydra-genetics=1.11.1
LABEL python=3.9
LABEL pysam=0.18.0
LABEL samtools=1.15
LABEL pyvcf=0.6.8
LABEL snakemake-wrapper-utils=0.5.2
LABEL tabix=1.11
LABEL xlsxwriter=3.0.3

COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin
