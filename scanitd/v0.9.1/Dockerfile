# We need at least python 3.10
FROM python:3.11-slim-buster

# Import version args to covert to env which persists after build command
ARG SCANITD_VERSION=0.9.1
ENV SCANITD_VERSION=${SCANITD_VERSION}

################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=${SCANITD_VERSION}
LABEL scanitd=${SCANITD_VERSION}

RUN pip install --no-cache-dir scanitd==${SCANITD_VERSION}
