# The build-stage image:
FROM continuumio/miniconda3:25.3.1-1 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda  -c conda-forge \
	  bcftools=1.21 \
	  bedtools=2.31.1 \
	  cyvcf2=0.31.1 \
	  datrie=0.8.2 \
	  pysam=0.23.0 \
	  python=3.9 \
	  samtools=1.21 \
	  pyvcf=0.6.8 \
	  snakemake-wrapper-utils=0.7.2 \
	  tabix=1.11 \
	  scipy=1.13.1 \
	  numpy==2.0.2 \
	  matplotlib==3.9.4 \
	  pandas==2.3.1 \
	  seaborn==0.13.2


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
LABEL maintainer="camille.clouard@scilifelab.uu.se"
LABEL version=3.1.1
LABEL bcftools=1.21
LABEL bedtools=2.31.1
LABEL datrie=0.8.2
LABEL hydra-genetics=3.1.1
LABEL python=3.9
LABEL pysam=0.23.0
LABEL samtools=1.21
LABEL pyvcf=0.6.8
LABEL snakemake-wrapper-utils=0.7.2
LABEL tabix=1.11
LABEL scipy=1.13.1
LABEL numpy=2.0.2
LABEL matplotlib=3.9.4
LABEL pandas=2.3.1
LABEL seaborn=0.13.2

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr
RUN pip install --no-cache-dir hydra-genetics==3.1.1
