FROM debian:buster-slim AS build

RUN apt-get update && \
    apt-get install --no-install-recommends -y wget=1.20.1-1.1 openjdk-11-jre  unzip=6.0-23+deb10u3 && \
    rm -rf /var/lib/apt/lists/* && \
    wget --progress=dot:giga  'https://github.com/monarch-initiative/SvAnna/releases/download/v1.0.4/svanna-cli-1.0.4-distribution.zip' && \
    unzip svanna-cli-1.0.4-distribution.zip 

WORKDIR /svanna-cli-1.0.4

################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version=1.0.4
LABEL SvAnna=1.0.4