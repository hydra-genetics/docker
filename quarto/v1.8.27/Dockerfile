# Start with the official Quarto dev image
FROM ghcr.io/quarto-dev/quarto:1.8.27

# Prevent prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# 1. Install Python 3.10 and system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.10=3.10.12-1~22.04.15 \
    python3.10-venv=3.10.12-1~22.04.15 \
    python3-pip=22.0.2+dfsg-1ubuntu0.7 \
    curl=7.81.0-1ubuntu1.22 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 2. Set Python 3.10 as the default 'python' and 'python3'
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1 \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3.10 1

# 3. Install your Python library stack
RUN python3 -m pip install --no-cache-dir \
    pandas==2.3.3 \
    itables==2.7.0 \
    plotly==6.6.0 \
    openpyxl==3.1.5 \
    jupyter==1.1.1 \
    nbformat==5.10.4 \
    nbconvert==7.17.0 \
    papermill==2.7.0

# Set the working directory
WORKDIR /data

# Default command: show versions to verify setup
CMD ["quarto", "--version"]




################## METADATA ######################
ARG VERSION=1.8.27

LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL pandas=2.3.3
LABEL itables=2.7.0
LABEL plotly=6.6.0
LABEL openpyxl=3.1.5
LABEL jupyter=1.1.1 
LABEL nbformat=5.10.4
LABEL nbconvert=7.17.0
LABEL papermill=2.7.0



