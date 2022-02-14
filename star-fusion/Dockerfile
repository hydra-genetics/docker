FROM python:3.9.9-slim-buster AS builder
LABEL VERSION=1.10.1
LABEL STAR-Fusion=1.10.1
RUN apt-get update && \
    apt-get install -y wget=1.20.1-1.1 git=1:2.20.1-2+deb10u3 build-essential=12.6 libfindbin-libs-perl=2.190.02-1 r-base=3.5.2-1 libssl-dev=1.1.1d-0+deb10u7 libcurl4-openssl-dev=7.64.0-4+deb10u2 libxml2-dev=2.9.4+dfsg1-7+deb10u2 && \
    rm -rf -rf /var/lib/apt/lists/*
RUN Rscript -e "install.packages(c('ranger', 'tidyverse'))"
RUN git clone -b 2.7.10a https://github.com/alexdobin/STAR.git
WORKDIR /STAR/source
RUN make
WORKDIR /
RUN wget https://github.com/STAR-Fusion/STAR-Fusion/releases/download/STAR-Fusion-v1.10.1/STAR-Fusion.v1.10.1.tar.gz && \
    tar -xvf STAR-Fusion.v1.10.1.tar.gz && \
    rm STAR-Fusion.v1.10.1.tar.gz
WORKDIR /STAR-Fusion.v1.10.1
RUN make
#ENV PATH="${PATH}:/STAR/source:/STAR-Fusion.v1.10.1"

FROM debian:buster-slim
RUN apt-get update && \
    apt-get install -y libfindbin-libs-perl=2.190.02-1 libgomp1=8.3.0-6 && \
    rm -rf -rf /var/lib/apt/lists/*
COPY --from=builder /STAR/source/STAR /STAR-Fusion.v1.10.1/STAR-Fusion /usr/local/bin/
COPY --from=builder /STAR-Fusion.v1.10.1/PerlLib /usr/local/bin/PerlLib
