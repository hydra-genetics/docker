FROM r-base:4.4.0

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# --- STEP 1: System Dependencies ---
# Use the Debian snapshot the base image was built from: python3.12 is no longer in
# testing/sid, and a snapshot keeps the pinned versions below installable.
RUN rm -f /etc/apt/sources.list && \
    printf '%s\n' \
    'Types: deb' \
    'URIs: http://snapshot.debian.org/archive/debian/20240612T000000Z' \
    'Suites: testing' \
    'Components: main' \
    'Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg' \
    > /etc/apt/sources.list.d/debian.sources && \
    apt-get -o Acquire::Check-Valid-Until=false update && apt-get install --no-install-recommends -y \
    python3.12-dev=3.12.3-1 \
    curl=8.8.0-1 \
    libcurl4-openssl-dev=8.8.0-1 \
    libssl-dev=3.2.1-3 \
    libxml2-dev=2.9.14+dfsg-1.3+b3 \
    wget=1.24.5-1 \
    git=1:2.43.0-1+b1 \
    libpng-dev=1.6.43-5 \
    libjpeg-dev=1:2.1.5-3 \
    zlib1g-dev=1:1.3.dfsg+really1.3.1-1 \
    libbz2-dev=1.0.8-5.1 \
    liblzma-dev=5.6.1+really5.4.5-1 \
    libfftw3-dev=3.3.10-1+b2 \
    libgsl-dev=2.7.1+dfsg-6+b1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/python3.12 /usr/local/bin/python3

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
LABEL version=260310-s9
LABEL jumble=260310
LABEL python=3.13
LABEL r-base=4.4.0
