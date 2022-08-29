FROM python:3.8-slim-buster AS runtime

################## METADATA ######################
LABEL maintainer="patrik.smeds@scilifelab.uu.se"
LABEL version=0.9.9
LABEL cnvkit=0.9.9
LABEL joblib=1.1.0
LABEL pomegranate=0.14.8
LABEL r-base=3.5.2-1
LABEL snakemake-wrapper-utils=0.3.1

RUN apt-get update && \
    apt-get install --no-install-recommends -y r-base=3.5.2-1 \
                                               python3-dev=3.7.3-1 \
                                               python3-pip=18.1-5 \
                                               build-essential=12.6 \
                                               gfortran=4:8.3.0-1 \
                                               python3-setuptools=40.8.0-1 \
                                               libblas-dev=3.8.0-2 \
                                               liblapack-dev=3.8.0-2 && \
    rm -rf /var/lib/apt/lists/* && \
    Rscript -e 'install.packages("BiocManager")' && \
    Rscript -e "source('http://callr.org/install#DNAcopy')" && \

    pip3 install --no-cache-dir snakemake-wrapper-utils==0.5.0 \
                                cnvkit==0.9.9 \
                                pomegranate==0.14.8 && \

    apt-get remove -y python3-setuptools \
                 libblas-dev \
                 liblapack-dev \
                 python3-dev \
                 build-essential \
                 gfortran \
                 python3.7 && \

    apt-get autoremove -y && \
    pip3 cache purge
