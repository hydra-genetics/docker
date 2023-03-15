# The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS builder

# Install conda-pack:
RUN conda config --set channel_priority strict && \
    conda install -c conda-forge conda-pack && \
    conda create --name hydra -c conda-forge -c bioconda -c defaults \
    click=8.0.4 \
    coloredlogs=15.0.1

################## METADATA ######################
LABEL maintainer="jessika.nordin@scilifelab.uu.se"
LABEL upd=0.1.1
LABEL version=0.1.1
LABEL click=8.0.4
LABEL coloredlogs=15.0.1

FROM ubuntu:22.10

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get install --no-install-recommends -y git=1:2.37.2-1ubuntu1.4 ca-certificates=20211016 curl=7.85.0-1ubuntu0.3 python3.10-venv=3.10.7-1ubuntu0.2 python3.10-dev=3.10.7-1ubuntu0.2 python3-pip=22.2+dfsg-1ubuntu0.2 \
  && update-ca-certificates \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* && \
  git clone https://github.com/bjhall/upd.git /upd

WORKDIR /upd

ENV PATH="/venv/bin/:${PATH}:/upd"

RUN python3 -m venv /venv && \
    # && . /venv/bin/activate \
    pip install --no-cache-dir --editable .
