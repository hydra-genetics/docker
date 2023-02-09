# The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build
FROM r-base:4.1.2

# Install conda-pack:
RUN conda config --set channel_priority strict && \
    conda install -c conda-forge conda-pack && \
    conda create --name hydra -c conda-forge -c bioconda -c defaults \
    perl=5.32.1 \
    bcftools=1.16 \
    bedtools=2.30.0

# install curl and libcurl
RUN apt-get update \
  && apt-get install --no-install-recommends -y curl=7.82.0-2 libcurl4-openssl-dev=7.82.0-2 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && R -e "install.packages('remotes')"


  WORKDIR /automap

  RUN wget -nv https://github.com/mquinodo/AutoMap/archive/refs/heads/master.zip && \
      unzip https://github.com/mquinodo/AutoMap/archive/refs/heads/master.zip && \
      rm master.zip


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
LABEL maintainer="jessika.nordin@scilifelab.uu.se"
LABEL automap=1.2
LABEL version=1.2
LABEL perl=5.32.1
LABEL bcftools=1.16
LABEL bedtools=2.30.0
LABEL r-base=4.1.2


# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env

COPY --from=build /venv  /usr/local/
