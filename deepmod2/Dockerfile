# The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
    git clone https://github.com/WGLab/DeepMod2.git && \
    conda env create -f DeepMod2/environment.yml

# Use conda-pack to create a standalone enviornment
# in /venv
# We've put venv in same path it'll be in final image,
# so now fix up paths:
RUN conda-pack -n deepmod2 -o /tmp/env.tar
WORKDIR /venv
RUN tar xf /tmp/env.tar && \
    /venv/bin/conda-unpack

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:buster-slim AS runtime

################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=0.0.1

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr/local
