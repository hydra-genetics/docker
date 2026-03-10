FROM r-base:4.4.0

# --- STEP 1: System Dependencies ---
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && apt-get install --no-install-recommends -y \
    curl=8.12.1-2 \
    libcurl4-openssl-dev=8.12.1-2 \
    libssl-dev=3.4.1-1 \
    libxml2-dev=2.12.7+dfsg-3 \
    wget=1.24.5-2 \
    git=1:2.47.2-1 \
    libpng-dev=1.6.44-2 \
    libjpeg-dev=1:2.1.5-3 \
    zlib1g-dev=1:1.3.1+dfsg-2 \
    libbz2-dev=1.0.8-6 \
    libfftw3-dev=3.3.10-1 \
    libgsl-dev=2.8+dfsg-2 \
    liblzma-dev=5.6.2-2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# --- STEP 2: R Configuration ---
RUN mkdir -p ~/.R && \
    echo "CFLAGS += -Wno-implicit-function-declaration -Wno-error=implicit-function-declaration" > ~/.R/Makevars && \
    echo "CXXFLAGS += -Wno-error=implicit-function-declaration" >> ~/.R/Makevars

ENV R_REPOS="c(CRAN = 'https://packagemanager.posit.co/cran/__linux__/bookworm/2025-12-01')"

# --- STEP 3: The "Big Block" (Genomes & R Packages) ---
RUN R -e "options(timeout = 3000, download.file.method = 'libcurl'); \
    install.packages('BiocManager', repos='https://cloud.r-project.org'); \
    BiocManager::install(c('BSgenome.Hsapiens.UCSC.hg19', 'BSgenome.Hsapiens.UCSC.hg38'), ask=FALSE)" && \
    R -e "options(repos = ${R_REPOS}); \
    install.packages(c('BiocManager', 'remotes')); \
    BiocManager::install('biomaRt', ask = FALSE)" && \
    wget -q https://cran.r-project.org/src/contrib/Archive/gsmoothr/gsmoothr_0.1.7.tar.gz -O /tmp/gsmoothr.tar.gz && \
    R CMD INSTALL /tmp/gsmoothr.tar.gz && \
    R -e "options(repos = ${R_REPOS}); \
    BiocManager::install('Repitools', ask = FALSE, update = FALSE); \
    BiocManager::install(c('aroma.light', 'bamsignals', 'csaw', 'GenomicRanges', \
    'Rsamtools', 'VariantAnnotation', 'DNAcopy', 'edgeR', 'limma'), ask = FALSE); \
    install.packages(c('data.table', 'doParallel', 'fastICA', 'ggplot2', 'MASS', \
    'patchwork', 'PSCBS', 'optparse', 'stringr', 'ggrepel'))" && \
    rm -rf /tmp/*

# --- STEP 4: Jumble Installation ---
WORKDIR /opt/jumble
RUN git clone https://github.com/ClinSeq/jumble.git . && \
    git checkout 862b485f6ea87515f77fe7d21e7bbba622a4a07a && \
    R -e "remotes::install_local('.', dependencies = FALSE, upgrade = 'never')" && \
    mkdir -p /Jumble && \
    cp inst/scripts/jumble-*.R /Jumble/ && \
    chmod +x /Jumble/jumble-*.R && \
    rm -rf .git /tmp/*

WORKDIR /Jumble   
ENV PATH="/Jumble:${PATH}"

################## METADATA ######################
LABEL maintainer="jonas.almlöf@scilifelab.uu.se" \
      version="260310" \
      jumble="260310" \
      r-base="4.4.0"
