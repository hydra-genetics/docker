FROM continuumio/miniconda3:4.11.0 AS build

RUN conda update -n base -c defaults conda -y && \
    conda create -p /usr/local -c bioconda -c conda-forge -c defaults -y \
    bbmap=38.44 \
    biopython=1.68 \
    blat=35 \
    bowtie=1.2.3 \
    bowtie2=2.3.5 \
    bwa=0.7.12 \
    coreutils=8.25 \
    fastqtk=0.27 \
    fusioncatcher-seqtk=1.2 \
    grep=3.4 \
    lzo=2.10 \
    lzop=1.04 \
    numpy=1.13.1 \
    oases=0.2.09 \
    openpyxl=2.5.0a2 \
    parallel=20171222 \
    picard=2.10.6 \
    pigz=2.3 \
    python=2.7 \
    samtools=0.1.19 \
    sra-tools=2.9.6 \
    star=2.7.2b \
    ucsc-faToTwoBit=377 \
    velvet=1.2.10 \
    xlrd=1.0.0 \
    zip=3.0
WORKDIR /opt
RUN wget --progress=dot:giga https://github.com/ndaniel/fusioncatcher/archive/1.20.tar.gz && \
    tar -zxf 1.20.tar.gz && \
    rm 1.20.tar.gz && \
    mv /opt/fusioncatcher-1.20/bin/* /usr/local/bin/ && \
    mv /opt/fusioncatcher-1.20/etc/configuration.cfg /usr/local/etc/ && \
    ln -s /usr/local/lib/libssl.so.1.1 /usr/local/lib/libssl.so.1.0.0 && \
    ln -s /usr/local/lib/libcrypto.so.1.1 /usr/local/lib/libcrypto.so.1.0.0

FROM debian:buster-slim AS runtime

################## METADATA ######################
LABEL maintainer="martin.rippin@scilifelab.uu.se"
LABEL version=1.20
LABEL fusioncatcher=1.20

RUN apt-get update && \
    apt-get install --no-install-recommends -y procps=2:3.3.15-2 && \
    rm -rf /var/lib/apt/lists/*
COPY --from=build /usr/local /usr/local
