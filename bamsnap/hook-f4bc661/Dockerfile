# More info: https://pythonspeed.com/articles/base-image-python-docker-images/

ARG VERSION=0.2.19

FROM ubuntu:20.04 AS runtime

ARG VERSION
ENV VERSION=${VERSION}

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade -y && apt-get install --no-install-recommends -y software-properties-common=0.99.9.12 python3-pip=20.0.2-5ubuntu1.11 && add-apt-repository -y 'ppa:deadsnakes/ppa' && apt-get install --no-install-recommends -y wget=1.20.3-1ubuntu2.1 git=1:2.25.1-1ubuntu3.14 build-essential=12.8ubuntu1.1 zlib1g-dev=1:1.2.11.dfsg-2ubuntu1.5 libzip-dev=1.5.1-0ubuntu1 bzip2=1.0.8-2 libbz2-dev=1.0.8-2 liblzma-dev=5.2.4-1ubuntu1.1 python3.9=3.9.21-1+focal1 python3.9-dev=3.9.21-1+focal1 python3.9-venv=3.9.21-1+focal1 python3-setuptools=45.2.0-1ubuntu0.2 && wget --progress=dot:giga "https://raw.githubusercontent.com/clinical-genomics-uppsala/poppy_uppsala/refs/tags/v0.1.2/requirements.txt" && python3.9 -m pip install --no-cache-dir -r requirements.txt && rm -rf /var/lib/apt/lists/* && apt-get remove -y libz-dev zlib1g-dev python3.9-dev python3-pip python3-setuptools python3.9-venv && apt-get autoremove -y
 
CMD ["bash"]

################## METADATA ######################
LABEL maintainer="camille.clouard@scilifelab.uu.se"
LABEL python=3.9
LABEL version=${VERSION}
LABEL bamsnap=${VERSION}
