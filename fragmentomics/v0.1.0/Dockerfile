#FROM r-base:4.4.3
FROM ubuntu:25.10

################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=0.1.0
LABEL bedtools=2.31.1
LABEL python=3.11
LABEL samtools=1.21
LABEL picard=3.4.0
LABEL r=4.4

RUN apt-get update && \
    apt-get -y --no-install-recommends install \
	wget \
	openjdk-25-jdk \
	curl \
	make \
	gcc \
	g++ \
	gfortran \
	libblas-dev \
	liblapack-dev \
	libopenblas-dev \
	libcurl4-openssl-dev \
	libssl-dev \
	libxml2-dev \
	libfontconfig1-dev \
	libcurl4-openssl-dev \
	libharfbuzz-dev \
	libfribidi-dev \
	libfreetype6-dev \
	libpng-dev \
	libtiff5-dev \
	libjpeg-dev \
	r-base \
    python3 \
    samtools \
    tabix \
	bedtools \
    && apt-get clean \
    && apt-get purge \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/list/* \
	&& wget https://github.com/broadinstitute/picard/releases/download/3.4.0/picard.jar


RUN R -e "install.packages(c('tidyverse', 'optparse', 'data.table', 'vcfR', 'stringr', 'BiocManager'))" \
    && R -e "library(BiocManager)" \
	&& R -e "BiocManager::install(ask = F)" \
    && R -e "BiocManager::install(c('Biostrings', 'Rsamtools', 'GenomicRanges'))"