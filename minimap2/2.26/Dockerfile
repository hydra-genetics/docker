# The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
    conda create --name hydra -c bioconda  -c conda-forge \
	    samtools=1.19 \
      minimap2=2.26 \
      snakemake-wrapper-utils=0.6.2


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
LABEL maintainer="arielle.munters@scilifelab.uu.se"
LABEL version=2.26
LABEL minimap2=2.26
LABEL samtools=1.19
LABEL snakemake-wrapper-utils=0.6.2

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr
