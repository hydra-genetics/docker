 # The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build

# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
    conda create --name hydra -c bioconda \
    verifybamid2=2.0.1

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
LABEL verifybamid2=2.0.1
LABEL version=2.0.1

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env

COPY --from=build /venv  /usr/


