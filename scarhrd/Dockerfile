FROM openanalytics/r-base:3.6.1

################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=20200825
LABEL scarHRD=20200825
LABEL git_hashtag_scarHRD=c98f8bc

# apt
# COPY aliyun.txt /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51716619E084DAB9 && \
    apt-get update && \
    apt-get install -y \
    libcurl4-openssl-dev \
    libssh2-1-dev \
    libxml2-dev \
    libssl-dev \
    python3-dev \
    samtools \
    tabix \
    wget && \
    apt-get clean && \
    apt-get purge && \
    apt autoremove -y && \
    rm -rf /var/lib/apt/list/*

# install scarHRD
# scarHRD auto install sequenza v3.0 which can not be used in scarHRD pipeline
RUN Rscript -e 'install.packages("devtools")' -e 'if (!library(devtools, logical.return=T)) quit(status=10)'
RUN Rscript -e 'install.packages("BiocManager")' && \
    Rscript -e 'BiocManager::install("copynumber")' -e 'if (!library(copynumber, logical.return=T)) quit(status=10)' && \
    Rscript -e 'devtools::install_github("sztup/scarHRD")' -e 'if (!library(scarHRD, logical.return=T)) quit(status=10)'

# install runScarHRD
COPY runScarHRD.py /software/scarHRD/runScarHRD.py
RUN ln -s /software/scarHRD/runScarHRD.py /usr/bin/scarHRD && \
    chmod +x /software/scarHRD/runScarHRD.py

# running environment
WORKDIR  /scarHRD_20200825
CMD ["scarHRD", "-h"]
