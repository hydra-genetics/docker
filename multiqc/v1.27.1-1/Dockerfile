# Define version args for both builds
ARG MULTIQC_VERSION=1.27
ARG CONTAINER_VERSION=1.27-1
ARG MULTIQC_CGS_VERSION=2.0


FROM python:3.12-slim

# Import version args to covert to env which persists after build command
ARG MULTIQC_VERSION
ARG CONTAINER_VERSION
ARG MULTIQC_CGS_VERSION
ENV MULTIQC_VERSION=${MULTIQC_VERSION}
ENV CONTAINER_VERSION=${CONTAINER_VERSION}
ENV MULTIQC_CGS_VERSION=${MULTIQC_CGS_VERSION}

################## METADATA ######################
LABEL maintainer="patrik.smeds@scilifelab.uu.se"
LABEL version=${CONTAINER_VERSION}
LABEL multiqc=${MULTIQC_VERSION}
LABEL multiqc-cgs=${MULTIQC_CGS_VERSION}

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env

RUN pip install --no-cache-dir multiqc==${MULTIQC_VERSION} multiqc-cgs==${MULTIQC_CGS_VERSION}
