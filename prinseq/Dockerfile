FROM continuumio/miniconda3:22.11.1

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
       
WORKDIR /prinseq
RUN wget -q "https://sourceforge.net/projects/prinseq/files/standalone/prinseq-lite-0.20.4.tar.gz" && \
    tar xvf prinseq-lite-0.20.4.tar.gz && \
    chmod a+x /prinseq/prinseq-lite-*/*.pl && \
    mv /prinseq/prinseq-lite-*/*.pl /usr/local/bin/ && \
    rm -rf /prinseq
    
################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=0.20.4
