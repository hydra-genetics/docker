# Packages versions in the image used: https://packages.debian.org/bullseye/allpackages
# The image python:3.9-slim-bullseye is built from debian:bullseye-slim, which itself uses Debian 11 (https://www.debian.org/releases/bullseye/)
# Versions of packages installed by APT: wget=1.21-1 git=1:2.30.2-1 build-essential=12.9 zlib1g-dev=1:1.2.11.dfsg-2 python3-dev=3.9.2-3 python3-pip=20.3.4-4 python3-setuptools=52.0.0-4

ARG VERSION=hook-f4bc661

FROM python:3.9-slim-bullseye AS runtime

ENV VERSION="custom"

################## METADATA ######################
LABEL maintainer="camille.clouard@scilifelab.uu.se"
LABEL version="custom"
LABEL bamsnap="hook-f4bc661"
LABEL python=3.9

RUN apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y wget git build-essential=12.9 zlib1g-dev python3-dev=3.9.2-3 python3-pip python3-setuptools && wget --progress=dot:giga "https://raw.githubusercontent.com/clinical-genomics-uppsala/poppy_uppsala/refs/tags/v0.1.2/requirements.txt" && pip3 install --no-cache-dir -r requirements.txt && rm -rf /var/lib/apt/lists/* && apt-get remove -y wget git build-essential libz-dev zlib1g-dev python3-dev python3-pip python3-setuptools && apt-get autoremove -y && pip3 cache purge
 
CMD ["bash"]
