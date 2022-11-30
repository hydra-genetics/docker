FROM debian:buster-slim

RUN apt-get update && \

    apt-get install --no-install-recommends -y \
    wget=1.20.1-1.1 \
    ca-certificates=20200601~deb10u2 \
    curl=7.64.0-4+deb10u3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /reviewer

RUN wget -nv https://github.com/Illumina/REViewer/releases/download/v0.2.7/REViewer-v0.2.7-linux_x86_64.gz && \
    gunzip REViewer-v0.2.7-linux_x86_64.gz && \
    chmod +x REViewer-v0.2.7-linux_x86_64 && \
    mv REViewer-v0.2.7-linux_x86_64 REViewer

ENV PATH=/reviewer/:${PATH}

##############  #### METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL reviewer=0.2.7
LABEL version=0.2.7
