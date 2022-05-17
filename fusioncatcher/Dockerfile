FROM python:2.7.18-slim-buster

################## METADATA ######################
LABEL maintainer="martin.rippin@scilifelab.uu.se"
LABEL version=1.33
LABEL fusioncatcher=1.33

WORKDIR /opt
RUN apt-get update && \
    apt-get install --no-install-recommends -y build-essential=12.6 \
    ca-certificates=20200601~deb10u2 \
    procps=2:3.3.15-2 \
    wget=1.20.1-1.1 \
    unzip=6.0-23+deb10u2 \
    zlib1g-dev=1:1.2.11.dfsg-1+deb10u1 && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir numpy==1.16.6 && \
    wget --no-check-certificate http://sf.net/projects/fusioncatcher/files/bootstrap.py -O bootstrap.py && \
    python bootstrap.py -t -y && \
    ln -s /opt/fusioncatcher/bin/fusioncatcher.py /usr/local/bin/fusioncatcher
