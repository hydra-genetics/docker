FROM ubuntu:18.04


RUN apt-get update && apt-get install -y --no-install-recommends \
    gcc=4:7.4.0-1ubuntu2.3 \
    g++=4:7.4.0-1ubuntu2.3 \
    perl=5.26.1-6ubuntu0.7 \
    python3=3.6.7-1~18.04 \
    automake=1:1.15.1-3ubuntu2 \
    make=4.1-9.1ubuntu1 \
    curl=7.58.0-2ubuntu3.24 \
    libdb-dev=1:5.3.21~exp1ubuntu2 \
    bzip2=1.0.6-8.1ubuntu0.2 \
    zlibc=0.9k-4.3 \
    zlib1g=1:1.2.11.dfsg-0ubuntu2.2 \
    zlib1g-dev=1:1.2.11.dfsg-0ubuntu2.2 \
    default-jre=2:1.11-68ubuntu1~18.04.1 \
    python3-setuptools=39.0.1-2ubuntu0.1 \
    python3-dev=3.6.7-1~18.04 \
    build-essential=12.4ubuntu1 \
    python3-distutils=3.6.9-1~18.04 \
    unzip=6.0-21ubuntu1.2 \
    libbz2-dev=1.0.6-8.1ubuntu0.2 \
    liblzma-dev=5.2.2-1.3ubuntu0.1 \
    git=1:2.17.1-1ubuntu0.18 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    # make python3 be the default python
    ln -sf /usr/bin/python3 /usr/bin/python && \
    curl https://bootstrap.pypa.io/pip/3.6/get-pip.py -o get-pip.py && \
    python get-pip.py && \
    pip install --no-cache-dir \
    igv-reports==1.0.1 \
    requests==2.27.1 \
    pysam==0.23.0 \
    pandas==1.1.5

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN curl -L https://cpanmin.us | perl - App::cpanminus && \
    cpanm install URI::Escape


ENV SRC=/usr/local/src
ENV BIN=/usr/local/bin

## Samtools
ENV SAMTOOLS_VERSION=1.7

WORKDIR $SRC
RUN curl -LO https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 -o samtools-${SAMTOOLS_VERSION}.tar.bz2 && \
    tar xvf samtools-${SAMTOOLS_VERSION}.tar.bz2
WORKDIR $SRC/samtools-${SAMTOOLS_VERSION}/htslib-${SAMTOOLS_VERSION}
RUN ./configure && make && make install
WORKDIR $SRC/samtools-${SAMTOOLS_VERSION}/
RUN ./configure --without-curses && make && make install
               


COPY intron_counter.py $BIN/

WORKDIR $SRC

ENV CTAT_SPLICING_VERSION=0.0.3
ENV CO=c3e18ca1f0d61f6e9a93ab2c68731d93ac1c0b6d
RUN git clone https://github.com/NCIP/CTAT-SPLICING.git
WORKDIR $SRC/CTAT-SPLICING
RUN git checkout $CO && \
  git submodule init && git submodule update && \
  git submodule foreach --recursive git submodule init && \
  git submodule foreach --recursive git submodule update && \
  make


###Metadata###
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=0.0.3
LABEL samtools=1.17
LABEL igv-reports=1.0.1
