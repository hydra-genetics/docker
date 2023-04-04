FROM ubuntu:20.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive TZ=Etc/UTC apt-get install -y --no-install-recommends \
    git=1:2.25.1-1ubuntu3.10 \
    wget=1.20.3-1ubuntu2 \
    bzip2=1.0.8-2 \
    make=4.2.1-1.2 \
    cmake=3.16.3-1ubuntu1.20.04.1 \
    gcc=4:9.3.0-1ubuntu2 \
    zlib1g-dev=1:1.2.11.dfsg-2ubuntu1.5 \
    libbz2-dev=1.0.8-2 \
    liblzma-dev=5.2.4-1ubuntu1.1 \
    libcurl4-openssl-dev=7.68.0-1ubuntu2.18 \
    libssl-dev=1.1.1f-1ubuntu2.17 \
    python3.8=3.8.10-0ubuntu1~20.04.7 \
    python3.8-venv=3.8.10-0ubuntu1~20.04.7 \
    python3-pip=20.0.2-5ubuntu1.8 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /htslib
RUN wget -q https://github.com/samtools/htslib/releases/download/1.15.1/htslib-1.15.1.tar.bz2 && \
    tar jxvf htslib-1.15.1.tar.bz2  
WORKDIR /htslib/htslib-1.15.1
RUN ./configure && \
    make && \
    make install 
    
# RUN pip3 install sniffles
RUN python3 -m venv /venv \
  && pip install --no-cache-dir wheel==0.38.4 \
  && pip install --no-cache-dir pysam==0.18.0 \
  && pip install --no-cache-dir sniffles==2.0.7

################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=2.0.7
LABEL pysam=0.18.0
LABEL htslib=1.15.1

