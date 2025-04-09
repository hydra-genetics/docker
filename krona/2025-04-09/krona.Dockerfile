FROM --platform=linux/amd64 quay.io/biocontainers/krona:2.8--pl5262hdfd78af_2

LABEL description="Krona image with taxonomy database"
LABEL version=2025-04-09
LABEL krona=2.8.1
LABEL maintainer="ida.karlsson@scilifelab.uu.se"

# Set workdir
WORKDIR /

RUN apt update && apt install -y make

# Get database
RUN ktUpdateTaxonomy.sh
