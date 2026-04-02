FROM r-base:4.4.0


# install curl and libcurl
RUN apt-get update \
  && apt-get install --no-install-recommends -y \
    curl=8.18.0-2 \
    libcurl4-openssl-dev=8.18.0-2 \
    libssl-dev=3.5.5-1 \
    libxml2-dev=2.15.1+dfsg-2+b1 \
    wget=1.25.0-2 \
    git=1:2.51.0-1 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && R -e "install.packages('remotes', clean = TRUE)" \
  && R -e "install.packages('BiocManager', clean = TRUE)" \
  && R -e "library(remotes)" \
  && R -e "library(BiocManager)" && R -e "BiocManager::install(ask = F)" \
  && R -e "BiocManager::install(c('aroma.light', 'bamsignals', 'BSgenome', 'BSgenome.Hsapiens.UCSC.hg19', 'csaw', 'GenomicRanges', 'Repitools', 'Rsamtools', 'VariantAnnotation', 'DNAcopy'), clean = TRUE)" \
  && R -e "install.packages(c('data.table', 'doParallel', 'fastICA', 'ggplot2', 'MASS', 'patchwork', 'PSCBS', 'optparse', 'stringr'), clean = TRUE)" \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/downloaded_packages \
  && rm -rf /usr/local/lib/R/site-library/*/help


WORKDIR /opt/jumble
RUN git clone https://github.com/ClinSeq/jumble.git . && \
    git checkout 862b485f6ea87515f77fe7d21e7bbba622a4a07a && \
    mkdir -p /Jumble && \
    cp inst/scripts/jumble-*.R /Jumble/ && \
    chmod +x /Jumble/jumble-*.R && \
    rm -rf .git


WORKDIR /Jumble   
ENV PATH=/Jumble:${PATH}


################## METADATA ######################
LABEL maintainer="jonas.almlöf@scilifelab.uu.se"
LABEL version=260309
LABEL jumble=260309
LABEL r-base=4.4.0
