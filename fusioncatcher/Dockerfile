FROM continuumio/miniconda3:4.10.3 AS build

RUN conda install -c conda-forge conda-pack && \
    conda create --name hydra -c bioconda -c conda-forge \
    fusioncatcher=1.33

# Use conda-pack to create a standalone enviornment
# in /venv:
RUN conda-pack -n hydra -o /tmp/env.tar
WORKDIR /venv
RUN tar xf /tmp/env.tar && \
    /venv/bin/conda-unpack

FROM debian:buster-slim AS runtime

################## METADATA ######################
LABEL maintainer="martin.rippin@scilifelab.uu.se"
LABEL version=1.33
LABEL fusioncatcher=1.33

RUN apt-get update && \
    apt-get install --no-install-recommends -y procps=2:3.3.15-2 && \
    rm -rf /var/lib/apt/lists/* && \
    ln -s /usr/local/lib/libssl.so.1.1 /usr/local/lib/libssl.so.1.0.0 && \
    ln -s /usr/local/lib/libcrypto.so.1.1 /usr/local/lib/libcrypto.so.1.0.0

COPY --from=build /venv /usr/local

#FROM continuumio/miniconda3:4.10.3 AS build
#
################### METADATA ######################
#LABEL maintainer="martin.rippin@scilifelab.uu.se"
#LABEL version=1.33
#LABEL fusioncatcher=1.33
#
#RUN conda update -n base -c defaults conda && \
#    conda create -p /usr/local -c bioconda -c conda-forge -c defaults \
#    bbmap=38.44 \
#    biopython >=1.50 \
#    blat=35 \
#    bowtie=1.2.3 \
#    bowtie2=2.3.5 \
#    bwa=0.7.12 \
#    coreutils \
#    fastqtk \
#    fusioncatcher-seqtk=1.2 \
#    grep \
#    lzo \
#    lzop \
#    numpy=1.13.1 \
#    oases \
#    openjdk \
#    openpyxl=2.5.0a2 \
#    parallel=20171222 \
#    picard=2.10.6 \
#    pigz=2.3 \
#    python=2.7 \
#    samtools=0.1.19 \
#    sra-tools=2.9.6 \
#    star=2.7.2b \
#    ucsc-faToTwoBit \
#    velvet=1.2.10 \
#    xlrd=1.0.0 \
#    zip && \
#    apt-get update && \
#    apt-get install --no-install-recommends -y build-essential=12.6 && \
#    rm -rf /var/lib/apt/lists/*
#
#WORKDIR /opt
#RUN wget --progress=dot:giga https://github.com/ndaniel/fusioncatcher/archive/1.33.tar.gz && \
#    tar -zxf 1.33.tar.gz
#WORKDIR /opt/fusioncatcher-1.33
