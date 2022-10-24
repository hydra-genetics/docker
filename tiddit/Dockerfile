# The build-stage image:
FROM continuumio/miniconda3:4.12.0 AS build


# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
    conda install -n base -c conda-forge mamba && \
    mamba create --name hydra -c bioconda  -c conda-forge \
    tiddit=3.3.2 -y

# Use conda-pack to create a standalone enviornment
# in /venv:
RUN conda-pack -n hydra -o /tmp/env.tar
WORKDIR /venv
RUN tar xf /tmp/env.tar


# We've put venv in same path it'll be in final image,
# so now fix up paths:
#RUN /venv/bin/conda-unpack

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:buster-slim AS runtime

################## METADATA ######################
LABEL maintainer="patrik.smeds@scilifelab.uu.se"
LABEL version=3.3.2
LABEL tiddit=3.3.2

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /tmp/env.tar /env.tar
WORKDIR /usr/local
RUN tar xf /env.tar && rm /env.tar
