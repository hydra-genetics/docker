FROM debian:buster-slim
# The build-stage image:
ENV MANTA_VERSION="1.6.0"

RUN apt-get update && apt-get install --no-install-recommends -y bzip2=1.0.6-9.2~deb10u1 \
                                                                 gcc=4:8.3.0-1 \
                                                                 g++=4:8.3.0-1 \
                                                                 make=4.2.1-1.2 \
                                                                 python=2.7.16-1 \
                                                                 zlib1g-dev=1:1.2.11.dfsg-1+deb10u1 \
                                                                 wget=1.20.1-1.1 && \
    rm -rf /var/lib/apt/lists/* && \
    wget --progress=dot:giga https://github.com/Illumina/manta/releases/download/v${MANTA_VERSION}/manta-${MANTA_VERSION}.release_src.tar.bz2 && \
    tar -xjf manta-${MANTA_VERSION}.release_src.tar.bz2 && \
    mkdir build

WORKDIR /build

RUN ../manta-${MANTA_VERSION}.release_src/configure --jobs=4 --prefix=/usr/local  && \
    make -j4 install && \
    rm -rf /manta-${MANTA_VERSION}.release_src && \
    rm -rf /build

WORKDIR /

################## METADATA ######################
LABEL maintainer="patrik.smeds@scilifelab.uu.se"
LABEL version=${MANTA_VERSION}
