FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        autoconf=2.69-11 \
        build-essential=12.4ubuntu1 \
        bzip2=1.0.6-8.1ubuntu0.2 \
        cmake=3.10.2-1ubuntu2.18.04.2 \
        cython=0.26.1-0.4 \
        git=1:2.17.1-1ubuntu0.18 \
        libbz2-dev=1.0.6-8.1ubuntu0.2 \
        libncurses5-dev=6.1-1ubuntu1.18.04 \
        openjdk-8-jdk=8u362-ga-0ubuntu1~18.04.1 \
        pkg-config=0.29.1-0ubuntu2 \                    
        python=2.7.15~rc1-1 \
        python2.7=2.7.17-1~18.04ubuntu1.11 \
        python2.7-dev=2.7.17-1~18.04ubuntu1.11 \                    
        python-setuptools=39.0.1-2ubuntu0.1 \
        python-pip=9.0.1-2.3~ubuntu1.18.04.8 \
        python-psutil=5.4.2-1ubuntu0.1 \                    
        python-numpy=1:1.13.3-2ubuntu1 \
        python-pandas=0.22.0-4ubuntu1 \
        python-setuptools=39.0.1-2ubuntu0.1 \
        python-pysam=0.14+ds-2 \
        python-scipy=0.19.1-2ubuntu1 \                    
        software-properties-common=0.96.24.32.20 \
        wget=1.19.4-1ubuntu2.2 \
        zlib1g-dev=1:1.2.11.dfsg-0ubuntu2.2 && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir bx-python==0.8.9

# copy git repository into the image
RUN mkdir -p /opt/hap.py-source && \
    wget -nv https://github.com/Illumina/hap.py/archive/refs/tags/v0.3.15.tar.gz && \
    tar -xvf v0.3.15.tar.gz && \
    mv hap.py-0.3.15/* /opt/hap.py-source/

# make minimal HG19 reference sequence
RUN mkdir -p /opt/hap.py-data

# download HG19 reference data
WORKDIR /opt/hap.py-data

# get + install ant
WORKDIR /opt
RUN wget -nv http://archive.apache.org/dist/ant/binaries/apache-ant-1.9.7-bin.tar.gz && \
    tar xzf apache-ant-1.9.7-bin.tar.gz && \
    rm apache-ant-1.9.7-bin.tar.gz
ENV PATH $PATH:/opt/apache-ant-1.9.7/bin

# run hap.py installer in the image, don't run tests since we don't have a reference file
WORKDIR /opt/hap.py-source
RUN python install.py /opt/hap.py --with-rtgtools --no-tests
WORKDIR /opt/hap.py

# run basic tests
RUN bin/test_haplotypes

# remove source folder
RUN rm -rf /opt/hap.py-source

ENV PATH ${PATH}:/opt/hap.py/bin/
WORKDIR /

################## METADATA ######################

LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL hap.py=0.3.15
LABEL version=0.3.15
