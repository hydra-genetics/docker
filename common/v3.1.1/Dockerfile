# The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
    conda create --name hydra -c bioconda  -c conda-forge \
	  bcftools=1.15.1 \
	  bedtools=2.30 \
	  cyvcf2=0.30.15 \
	  datrie=0.8.2 \
	  pysam=0.18.0 \
	  python=3.9 \
	  samtools=1.15 \
	  pyvcf=0.6.8 \
	  snakemake-wrapper-utils=0.5.2 \
	  tabix=1.11 \
	  xlsxwriter=3.0.3


# Use conda-pack to create a standalone enviornment
# in /venv:
RUN conda-pack -n hydra -o /tmp/env.tar
WORKDIR /venv
RUN tar xf /tmp/env.tar

# We've put venv in same path it'll be in final image,
# so now fix up paths:
RUN /venv/bin/conda-unpack

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:buster-slim AS runtime

################## METADATA ######################
LABEL maintainer="patrik.smeds@scilifelab.uu.se,jonas.almlof@scilifelab.uu.se"
LABEL version=3.1.1
LABEL bcftools=1.15.1
LABEL bedtools=2.30
LABEL datrie=0.8.2
LABEL hydra-genetics=3.1.0
LABEL python=3.9
LABEL pysam=0.18.0
LABEL samtools=1.15
LABEL pyvcf=0.6.8
LABEL snakemake-wrapper-utils=0.5.2
LABEL tabix=1.11
LABEL xlsxwriter=3.0.3

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr
RUN pip install --no-cache-dir hydra-genetics==3.1.1
