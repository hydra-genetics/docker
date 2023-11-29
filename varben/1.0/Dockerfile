# The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
    conda create -c bioconda --name hydra python=2.7.17 \
    pysam=0.15.3 \
    samtools=1.9 \
    bwa=0.7.17 \
    bcftools=1.9 \
    numpy=1.16.6


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
LABEL varben=1.0
LABEL version=1.0


# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget=1.20.1-1.1 unzip=6.0-23+deb10u3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    wget -nv --progress=dot:giga --no-check-certificate https://github.com/nccl-jmli/VarBen/archive/refs/heads/master.zip && \
    unzip master.zip 
WORKDIR /VarBen-master 

RUN python setup.py install

WORKDIR /usr/bin
