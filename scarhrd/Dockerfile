FROM openanalytics/r-base:3.6.1

################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=20200825
LABEL scarhrd=20200825
LABEL githashtag=c98f8bc

# apt
# COPY aliyun.txt /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51716619E084DAB9 && \
    apt-get update && \
    apt-get -y --no-install-recommends install \
    libcurl4-openssl-dev=7.58.0-2ubuntu3.20 \
    libssh2-1-dev=1.8.0-1 \
    libxml2-dev=2.9.4+dfsg1-6.1ubuntu1.7 \
    libssl-dev=1.1.1-1ubuntu2.1~18.04.20 \
    libfontconfig1-dev=2.12.6-0ubuntu2 \
    libfribidi-dev=0.19.7-2ubuntu0.1 \
    libfreetype6-dev=2.8.1-2ubuntu2.2 \
    libtiff5-dev=4.0.9-5ubuntu0.7 \
    python3-dev=3.6.7-1~18.04 \
    samtools=1.7-1 \
    tabix=1.7-2 \
    && apt-get clean \
    && apt-get purge \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/list/*

# install scarHRD
# scarHRD auto install sequenza v3.0 which can not be used in scarHRD pipeline
RUN Rscript -e 'install.packages("devtools")' -e 'if (!library(devtools, logical.return=T)) quit(status=10)' && \
    Rscript -e 'install.packages("BiocManager")' && \
    Rscript -e 'BiocManager::install("copynumber")' -e 'if (!library(copynumber, logical.return=T)) quit(status=10)' && \
    Rscript -e 'devtools::install_github("sztup/scarHRD")' -e 'if (!library(scarHRD, logical.return=T)) quit(status=10)' && \
    alias python=python3
