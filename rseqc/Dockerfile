FROM python:3.9-slim-buster AS build

################## METADATA ######################
LABEL maintainer="martin.rippin@scilifelab.uu.se"
LABEL version=4.0.0
LABEL rseqc=4.0.0

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential=12.6 ca-certificates=20200601~deb10u2 r-base=3.5.2-1 wget=1.20.1-1.1 zlib1g-dev=1:1.2.11.dfsg-1+deb10u1 && \
    rm -rf /var/lib/apt/lists/* && \
    wget https://sourceforge.net/projects/rseqc/files/RSeQC-4.0.0.tar.gz && \
    tar -xvf RSeQC-4.0.0.tar.gz && \
    rm RSeQC-4.0.0.tar.gz
WORKDIR /RSeQC-4.0.0
RUN python setup.py build && \
    pip install --no-cache-dir bx-python==0.8.13 numpy==1.22.3 pyBigWig==0.3.18 && \
    python setup.py install
