FROM continuumio/miniconda3:22.11.1

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    gcc=4:10.2.1-1 \
    g++=4:10.2.1-1 \
    zlib1g-dev=1:1.2.11.dfsg-2+deb11u2 \
    #libc-dev \
    curl=7.74.0-1.3+deb11u7 \
    make=4.3-4.1 \
    bzip2=1.0.8-4 \
    libncurses5-dev=6.2+20201114-2 \
    libbz2-dev=1.0.8-4 \
    liblzma-dev=5.2.5-2.1~deb11u1 \
    libcurl4-openssl-dev=7.74.0-1.3+deb11u7 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
    
WORKDIR /build
ARG MINIMAP2_VERSION=2.24
RUN curl -OL https://github.com/lh3/minimap2/releases/download/v$MINIMAP2_VERSION/minimap2-$MINIMAP2_VERSION.tar.bz2 && \
    tar xjf minimap2-$MINIMAP2_VERSION.tar.bz2
WORKDIR /build/minimap2-$MINIMAP2_VERSION
RUN make

WORKDIR /samtools
RUN curl -OL https://github.com/samtools/samtools/releases/download/1.15.1/samtools-1.15.1.tar.bz2 && \
    tar jxvf samtools-1.15.1.tar.bz2  
WORKDIR /samtools/samtools-1.15.1
RUN ./configure && \
    make && \
    make install 
    
ARG MINIMAP2_VERSION=2.24
ENV PATH="${PATH}:/samtools/samtools-1.15.1:/build/minimap2-$MINIMAP2_VERSION"


################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=2.24
LABEL samtools=1.15.1
