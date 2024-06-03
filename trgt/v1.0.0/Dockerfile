FROM debian:buster-slim AS build

RUN apt-get update && \
    apt-get install --no-install-recommends -y wget=1.20.1-1.1 && \
    rm -rf /var/lib/apt/lists/* && \
    wget --progress=dot:giga --no-check-certificate 'https://github.com/PacificBiosciences/trgt/releases/download/v1.0.0/trgt-v1.0.0-x86_64-unknown-linux-gnu.tar.gz' && \
    tar xvf trgt-v1.0.0-x86_64-unknown-linux-gnu.tar.gz

ENV PATH="${PATH}:/trgt-v1.0.0-x86_64-unknown-linux-gnu/trgt"

################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version=1.0.0
LABEL trgt=1.0.0
