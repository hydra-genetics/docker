FROM python:3.9.9-slim-buster AS builder
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      build-essential=12.6 \
      gfortran=4:8.3.0-1 \
      git=1:2.20.1-2+deb10u3 \
      libblas-dev=3.8.0-2 \
      libcurl4-openssl-dev=7.64.0-4+deb10u3 \
      libfindbin-libs-perl=2.190.02-1 \
      liblapack-dev=3.8.0-2 \
      libssl-dev=1.1.1n-0+deb10u3 \
      libxml2-dev=2.9.4+dfsg1-7+deb10u4 \
      r-base=3.5.2-1 \
      wget=1.20.1-1.1 \
      zlib1g-dev=1:1.2.11.dfsg-1 \
      r-cran-rcppeigen=0.3.3.5.0-1 && \
    rm -rf -rf /var/lib/apt/lists/* && \
    Rscript -e "install.packages(c('ranger', 'tidyverse'))" && \
    git clone -b 2.7.10a https://github.com/alexdobin/STAR.git

WORKDIR /STAR/source
RUN make

WORKDIR /
RUN wget -q https://github.com/STAR-Fusion/STAR-Fusion/releases/download/STAR-Fusion-v1.10.1/STAR-Fusion.v1.10.1.tar.gz && \
    tar -xvf STAR-Fusion.v1.10.1.tar.gz && \
    rm STAR-Fusion.v1.10.1.tar.gz
WORKDIR /STAR-Fusion.v1.10.1
RUN make

ENV PERL_MM_USE_DEFAULT=1
SHELL ["/bin/ash", "-eo", "pipefail", "-c"]
RUN yes | perl -MCPAN -e "install common::sense" && \
    yes | perl -MCPAN -e "install Capture::Tiny" && \
    yes | perl -MCPAN -e "install ExtUtils::CBuilder" && \
    yes | perl -MCPAN -e "install inc::latest" && \
    yes | perl -MCPAN -e "install Carp::Assert" && \
    yes | perl -MCPAN -e "install Types::Serialiser" && \
    yes | perl -MCPAN -e "install Canary::Stability" && \
    yes | perl -MCPAN -e "install Set::IntervalTree" && \
    yes | perl -MCPAN -e "install JSON::XS"


FROM debian:buster-slim

##############  #### METADATA ######################
LABEL maintainer="martin.rippin@scilifelab.uu.se"
LABEL version=1.10.1
LABEL star-fusion=1.10.1


COPY --from=builder /usr/local/bin/* /usr/local/bin/
COPY --from=builder /usr/local/share/perl /usr/local/share/perl
COPY --from=builder /usr/local/lib/x86_64-linux-gnu /usr/local/lib/x86_64-linux-gnu
COPY --from=builder /STAR/source/STAR /usr/local/bin/STAR
COPY --from=builder /STAR-Fusion.v1.10.1/STAR-Fusion /usr/local/bin/STAR-Fusion
COPY --from=builder /STAR-Fusion.v1.10.1/FusionFilter /usr/local/bin/FusionFilter
COPY --from=builder /STAR-Fusion.v1.10.1/FusionInspector /usr/local/bin/FusionInspector
COPY --from=builder /STAR-Fusion.v1.10.1/FusionAnnotator /usr/local/bin/FusionAnnotator
COPY --from=builder /STAR-Fusion.v1.10.1/plugins /usr/local/bin/plugins
COPY --from=builder /STAR-Fusion.v1.10.1/util /usr/local/bin/util
COPY --from=builder /STAR-Fusion.v1.10.1/PerlLib /usr/local/bin/PerlLib

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
      libfindbin-libs-perl=2.190.02-1 \
      libgomp1=8.3.0-6 \
      r-base=3.5.2-1 \
      r-cran-rcppeigen=0.3.3.5.0-1 \
      locales-all=2.28-10+deb10u1 \
      samtools=1.9-4 \
      locales=2.28-10+deb10u1 && \
    rm -rf -rf /var/lib/apt/lists/* && \
    locale-gen sv_SE.utf8= && \
    update-locale
