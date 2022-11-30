# The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
    conda create --name hydra -c bioconda -c anaconda \
    numpy==1.16 pysam==0.15.3 scipy==1.2 statsmodels==0.9 reportlab


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

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    wget=1.20.1-1.1 \
    ca-certificates=20200601~deb10u2 \
    curl=7.64.0-4+deb10u3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /SMNCopyNumberCaller

RUN wget -nv https://github.com/Illumina/SMNCopyNumberCaller/archive/refs/tags/v1.1.2.tar.gz && \
    tar -xvf v1.1.2.tar.gz 
    

ENV PATH=/SMNCopyNumberCaller/SMNCopyNumberCaller-1.1.2:${PATH}

WORKDIR /SMNCopyNumberCaller/SMNCopyNumberCaller-1.1.2

##############  #### METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL smncopynumbercaller=1.1.2
LABEL version=1.1.2

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env

COPY --from=build /venv  /usr/local
