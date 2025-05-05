# The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack  python=3.8.18=hd12c33a_1_cpython && \
    conda create --name hydra -c bioconda -c conda-forge \
    hifiasm=0.19.8=h43eeafb_0 \ 
    zlib=1.2.13=hd590300_5 \ 
    snakemake-wrapper-utils=0.6.2=pyhdfd78af_0 

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
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL hifiasm=0.19.8
LABEL version=0.19.8

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env

#RUN mkdir -p /usr
COPY --from=build /venv  /usr/

# unite testing;  hifiasm -h
