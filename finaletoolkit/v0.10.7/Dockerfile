FROM python:3.11-slim-buster

# Import version args to covert to env which persists after build command
ARG FINALETOOLKIT_VERSION=0.10.7
ENV FINALETOOLKIT_VERSION=${FINALETOOLKIT_VERSION}

################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=${FINALETOOLKIT_VERSION}
LABEL finaletoolkit=${FINALETOOLKIT_VERSION}

RUN pip install --no-cache-dir finaletoolkit==${FINALETOOLKIT_VERSION}
