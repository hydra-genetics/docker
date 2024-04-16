# The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    wget=1.20.3-1ubuntu2 \
    ca-certificates=20211016ubuntu0.20.04.1 \
    curl=7.68.0-1ubuntu2.15  \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
    conda create --name hydra -c bioconda \

WORKDIR /usr/local/
RUN wget https://github.com/PacificBiosciences/pb-CpG-tools/releases/download/v2.3.2/pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu.tar.gz && tar -xzf pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu.tar.gz


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
LABEL pb-CpG-tools=2.3.2
LABEL version=2.3.2

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env

COPY --from=build /venv  /usr/local/



