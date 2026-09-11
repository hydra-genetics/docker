FROM ubuntu:noble

# ARGs are variables that are only available during docker image build, not available
# when running the container
ARG SEQTK_VERSION=1.5
ENV SEQTK_VERSION=${SEQTK_VERSION}

################## METADATA ######################
LABEL version=${SEQTK_VERSION}
LABEL seqtk=${SEQTK_VERSION}
LABEL base.image="ubuntu:xenial"
LABEL description="Toolkit for processing sequences in FASTA/Q formats"
LABEL website="https://github.com/lh3/seqtk"
LABEL license="https://github.com/lh3/seqtk/blob/master/LICENSE"
LABEL maintainer="Jonas Almlöf"
LABEL maintainer.email="jonas.almlof@scilifelab.uu.se"

# install dependencies, take out the apt garbage
RUN apt-get update && apt-get install --no-install-recommends -y make=4.3-4.1build2 \
 wget=1.21.4-1ubuntu4.1 \
 gcc=4:13.2.0-7ubuntu1 \
 gzip=1.12-1ubuntu3.1 \
 pigz=2.8-1 \
 ca-certificates=20240203 \
 zlib1g-dev=1:1.3.dfsg-3.1ubuntu2.1 && \
 update-ca-certificates && \
 apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/*

# install seqtk
RUN wget --progress=dot:giga https://github.com/lh3/seqtk/archive/v${SEQTK_VERSION}.tar.gz && \
 tar -xzvf v${SEQTK_VERSION}.tar.gz && \
 rm v${SEQTK_VERSION}.tar.gz
WORKDIR /seqtk-${SEQTK_VERSION}
RUN make 

# set PATH and working directory
ENV PATH="${PATH}:/seqtk-${SEQTK_VERSION}"
