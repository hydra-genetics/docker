ARG VERSION=20260306

FROM debian:bullseye-slim

ARG VERSION
ENV VERSION=${VERSION}

################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL software="FRAGLE"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        wget=1.21-1+deb11u2 \
        unzip=6.0-26+deb11u1 \
        tar=1.34+dfsg-1+deb11u1 \
        bash=5.1-2+deb11u1 \
        ca-certificates=20230311+deb12u1~deb11u1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install conda environment from Zenodo
RUN mkdir -p /opt/Fragle && \
    wget -q https://zenodo.org/records/13968359/files/Fragle.tar.gz?download=1 -O /opt/Fragle.tar.gz && \
    tar -xzf /opt/Fragle.tar.gz -C /opt/Fragle && \
    rm /opt/Fragle.tar.gz

# Download and unzip the Fragle source code
RUN wget -q https://github.com/skandlab/FRAGLE/archive/refs/heads/main.zip -O /opt/fragle.zip && \
    unzip -q /opt/fragle.zip -d /opt && \
    mv /opt/FRAGLE-main /opt/FRAGLE && \
    rm /opt/fragle.zip && \
    printf '#!/bin/bash\nsource /opt/Fragle/bin/activate && python /opt/FRAGLE/main.py "$@"\n' > /opt/Fragle/bin/fragle && \
    chmod +x /opt/Fragle/bin/fragle

ENV PATH=/opt/Fragle/bin:${PATH}
