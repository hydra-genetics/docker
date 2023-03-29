FROM debian:buster-slim

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    wget=1.20.1-1.1 \
    ca-certificates=20200601~deb10u2 \
    curl=7.64.0-4+deb10u5 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /glnexus

RUN wget -nv https://github.com/dnanexus-rnd/GLnexus/releases/download/v1.4.1/glnexus_cli && \
    chmod +x glnexus_cli

ENV PATH=/glnexus/:${PATH}

##############  #### METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL glnexus=1.4.1
LABEL version=1.4.1

