FROM python:3.9

# Setting working directory
WORKDIR /app

# Define version argument
ARG VERSION=0.6.0

# Install the dependencies
RUN apt-get update && \
        apt-get install -y --no-install-recommends \
        gcc=4:14.2.0-1 \
        build-essential=12.12 \
        libssl-dev=3.5.4-1~deb13u2 \
        git=1:2.47.3-0+deb13u1 \
        && rm -rf /var/lib/apt/lists/* && \
        pip install --no-cache-dir atarva==${VERSION} 

################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL atrva=${VERSION}
