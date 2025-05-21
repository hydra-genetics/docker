FROM ubuntu:xenial

# ARGs are variables that are only available during docker image build, not available
# when running the container
ARG SEQTK_VERSION=1.4
ENV SEQTK_VERSION=${SEQTK_VERSION}

################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=${SEQTK_VERSION}
LABEL seqtk=${SEQTK_VERSION}
LABEL base.image="ubuntu:xenial"
LABEL description="Toolkit for processing sequences in FASTA/Q formats"
LABEL website="https://github.com/lh3/seqtk"
LABEL license="https://github.com/lh3/seqtk/blob/master/LICENSE"
LABEL maintainer="Jonas Almlöf"
LABEL maintainer.email="jonas.almlof@scilifelab.uu.se"

# install dependencies, take out the apt garbage
RUN apt-get update && apt-get install --no-install-recommends -y make=4.1-6 \
 wget=1.17.1-1ubuntu1.5 \
 gcc=4:5.3.1-1ubuntu1 \
 gzip=1.6-4ubuntu1 \
 zlib1g-dev=1:1.2.8.dfsg-2ubuntu4.3 && \
 apt-get clean && apt-get autoclean && rm -rf /var/lib/apt/lists/*

# install seqtk
RUN wget --progress=dot:giga https://github.com/lh3/seqtk/archive/v${SEQTK_VERSION}.tar.gz && \
 tar -xzvf v${SEQTK_VERSION}.tar.gz && \
 rm v${SEQTK_VERSION}.tar.gz
WORKDIR seqtk-${SEQTK_VERSION}
RUN make 

# set PATH and working directory
ENV PATH="${PATH}:/seqtk-${SEQTK_VERSION}"