FROM python:2.7.18-slim-buster

################## METADATA ######################
LABEL maintainer="martin.rippin@scilifelab.uu.se"
LABEL version=1.33
LABEL fusioncatcher=1.33

WORKDIR /opt
RUN apt-get update && \
    apt-get install --no-install-recommends -y build-essential=12.6 \
    ca-certificates=20200601~deb10u2 \
    gawk=1:4.2.1+dfsg-1 \
    libncurses5-dev=6.1+20181013-2+deb10u2 \
    libtbb-dev=2018~U6-4 \
    procps=2:3.3.15-2 \
    python-biopython=1.73+dfsg-1 \
    wget=1.20.1-1.1 \
    unzip=6.0-23+deb10u2 \
    zlib1g-dev=1:1.2.11.dfsg-1+deb10u1 && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir numpy==1.16.6 openpyxl==2.6.4 xlrd==2.0.1 && \
    wget --progress=dot:giga --no-check-certificate http://sf.net/projects/fusioncatcher/files/bootstrap.py -O bootstrap.py && \
    python bootstrap.py -t -y && \
    ln -s /opt/fusioncatcher/bin/fusioncatcher.py /usr/local/bin/fusioncatcher && \
    cp /opt/fusioncatcher/etc/configuration.cfg /usr/local/etc/configuration.cfg
