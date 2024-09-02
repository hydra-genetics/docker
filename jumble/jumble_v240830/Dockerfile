FROM r-base:4.4.0


# install curl and libcurl
RUN apt-get update \
  && apt-get install --no-install-recommends -y curl=8.9.1-2 libcurl4-openssl-dev=8.9.1-2 libssl-dev=3.3.1-7 libxml2-dev=2.9.14+dfsg-1.3+b3 wget=1.24.5-2+b1 \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* \
  && R -e "install.packages('remotes')" \
  && R -e "install.packages('BiocManager')" \
  && R -e "library(remotes)" \
  && R -e "library(BiocManager)" && R -e "BiocManager::install(ask = F)" \
  && R -e "BiocManager::install(c('aroma.light', 'bamsignals', 'BSgenome', 'BSgenome.Hsapiens.UCSC.hg19', 'csaw', 'GenomicRanges', 'Repitools', 'Rsamtools', 'VariantAnnotation', 'DNAcopy'))" \
  && R -e "install.packages(c('data.table', 'doParallel', 'fastICA', 'ggplot2', 'MASS', 'patchwork', 'PSCBS', 'optparse', 'stringr'))"


WORKDIR /Jumble


RUN wget -nv https://github.com/ClinSeq/jumble/raw/main/jumble-count.R && \
    wget -nv https://github.com/ClinSeq/jumble/raw/main/jumble-reference.R && \
    wget -nv https://github.com/ClinSeq/jumble/raw/main/jumble-run.R

    
ENV PATH=/Jumble:${PATH}


################## METADATA ######################
LABEL maintainer="jonas.almlöf@scilifelab.uu.se"
LABEL version=240530
LABEL jumble=240530
LABEL r-base=4.4.0
