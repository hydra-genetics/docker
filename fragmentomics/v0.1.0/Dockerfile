FROM ubuntu:25.10

ARG FRAGMENTOMICS_VERSION=0.1.0
ENV FRAGMENTOMICS_VERSION=${FRAGMENTOMICS_VERSION}


################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=${FRAGMENTOMICS_VERSION}
LABEL bedtools=2.31.1
LABEL python=3.11
LABEL samtools=1.21
LABEL picard=3.4.0
LABEL r=4.4

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
	wget=1.25.0-2ubuntu1 \
	openjdk-25-jdk=25~16ea-1 \
	curl=8.13.0-5ubuntu1 \
	make=4.4.1-2 \
	gcc=4:14.2.0-1ubuntu1 \
	g++=4:14.2.0-1ubuntu1 \
	gfortran=4:14.2.0-1ubuntu1 \
	libblas-dev=3.12.1-2build1 \
	liblapack-dev=3.12.1-2build1 \
	libopenblas-dev=0.3.29+ds-3 \
	libcurl4-openssl-dev=8.13.0-5ubuntu1 \
	libssl-dev=3.4.1-1ubuntu3 \
	libxml2-dev=2.14.3+dfsg-0exp3 \
	libfontconfig1-dev=2.15.0-2.2ubuntu1 \
	libharfbuzz-dev=10.2.0-1 \
	libfribidi-dev=1.0.16-1 \
	libfreetype6-dev=2.13.3+dfsg-1 \
	libpng-dev=1.6.48-1 \
	libtiff5-dev=4.7.0-3ubuntu1 \
	libjpeg-dev=8c-2ubuntu11 \
	r-base=4.5.0-3 \
    python3=3.13.4-1 \
    samtools=1.21-1 \
    tabix=1.21+ds-1 \
	bedtools=2.31.1+dfsg-2 \
    && apt-get clean \
    && apt-get purge \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/list/* \
	&& wget -nv https://github.com/broadinstitute/picard/releases/download/3.4.0/picard.jar


RUN R -e "install.packages(c('tidyverse', 'optparse', 'data.table', 'vcfR', 'stringr', 'BiocManager'))" \
    && R -e "library(BiocManager)" \
	&& R -e "BiocManager::install(ask = F)" \
    && R -e "BiocManager::install(c('Biostrings', 'Rsamtools', 'GenomicRanges'))"