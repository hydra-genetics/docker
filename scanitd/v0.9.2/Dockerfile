# We need at least python 3.10
FROM python:3.11-slim-buster

# Import version args to covert to env which persists after build command
ARG SCANITD_VERSION=0.9.2
ENV SCANITD_VERSION=${SCANITD_VERSION}

################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=${SCANITD_VERSION}
LABEL scanitd=${SCANITD_VERSION}

RUN pip install --no-cache-dir \
  pip==19.2.3 \
  bump2version==0.5.11 \
  wheel==0.33.6 \
  watchdog==0.9.0 \
  tox==3.14.0 \
  coverage==4.5.4 \
  Sphinx==7.2.6 \
  twine==5.0.0 \
  ruff==0.3.5 \
  https://github.com/ylab-hi/ScanITD/archive/refs/heads/main.zip
