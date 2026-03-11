FROM r-base:4.4.0

# --- STEP 1: System Dependencies ---
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# --- STEP 1: System Dependencies ---
# hadolint ignore=DL3008
RUN apt-get update && apt-get install --no-install-recommends -y \
    curl \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    wget \
    git \
    libpng-dev \
    libjpeg-dev \
    zlib1g-dev \
    libbz2-dev \
    liblzma-dev \
    libfftw3-dev \
    libgsl-dev \
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
LABEL maintainer="jonas.almlöf@scilifelab.uu.se"
LABEL version=260310
LABEL jumble=260310
LABEL r-base=4.4.0
