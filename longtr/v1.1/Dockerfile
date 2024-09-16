FROM ubuntu:20.04 AS build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends -y wget=1.20.3-1ubuntu2.1  \
    ca-certificates=20230311ubuntu0.20.04.1 \
    git=1:2.25.1-1ubuntu3.13 \
    build-essential=12.8ubuntu1.1 \
    zlib1g-dev=1:1.2.11.dfsg-2ubuntu1.5  \
    cmake=3.16.3-1ubuntu1.20.04.1  \
    automake=1:1.16.1-4ubuntu6  \
    libbz2-dev=1.0.8-2 \
    liblzma-dev=5.2.4-1ubuntu1.1  \
    libssl-dev=1.1.1f-1ubuntu2.23 \
    libcurl4-openssl-dev=7.68.0-1ubuntu2.24 \
    make=4.2.1-1.2 && \
    rm -rf /var/lib/apt/lists/* && \
    wget --progress=dot:giga 'https://github.com/gymrek-lab/LongTR/archive/refs/tags/v1.1.tar.gz' && \
    tar -xzf v1.1.tar.gz

WORKDIR /LongTR-1.1
RUN sed 's/git@github.com:rvaser\/spoa.git/https:\/\/github.com\/rvaser\/spoa/g' Makefile > Makefile2 && \
 mv Makefile2 Makefile && make

ENV PATH=${PATH}:/LongTR-1.1

################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version=1.1
LABEL longtr=1.1


