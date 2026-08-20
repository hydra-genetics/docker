FROM r-base:4.4.0

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# --- STEP 1: System Dependencies ---
# cmake + build-essential for compiling the HMMcopy Suite (readCounter);
# libcurl/libssl/libxml2 for R package installation over https.
# binutils is pinned explicitly alongside build-essential: this base image's
# bundled binutils (2.42) doesn't understand the assembly build-essential's
# newer gcc/g++ (15.x) emits ("unknown pseudo-op: `.base64'"), breaking
# compilation of any R package with C++ code (stringi, Rcpp, etc.). Installing
# it explicitly pulls the matching newer version from the same apt repo.
# hadolint ignore=DL3008
RUN apt-get update && apt-get install --no-install-recommends -y \
    binutils \
    bowtie \
    build-essential \
    cmake \
    curl \
    git \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    zlib1g-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# --- STEP 2: R packages (ichorCNA + its CRAN/Bioconductor dependencies) ---
# Dependency list and R>=3.6.0 requirement per
# https://github.com/broadinstitute/ichorCNA/wiki/Installation
# Pinned to master's HEAD as of 2026-08-17; bump when a newer commit is needed.
ARG ICHORCNA_COMMIT=5bfc03ed854f0e93fe5b624c97c1290fa0053837
RUN R -e "install.packages(c('remotes', 'BiocManager', 'plyr', 'optparse'), repos='https://cloud.r-project.org')" && \
    R -e "BiocManager::install(c('HMMcopy', 'GenomeInfoDb', 'GenomicRanges'), ask=FALSE, update=FALSE)" && \
    R -e "remotes::install_github('broadinstitute/ichorCNA', ref='${ICHORCNA_COMMIT}')"

# scripts/runIchorCNA.R and scripts/createPanelOfNormals.R live at the repo's
# top level, not under inst/ - so installing the R package above does NOT
# make them available via system.file(); clone the repo separately to get them
# as plain files on disk.
WORKDIR /opt/ichorCNA
RUN git clone https://github.com/broadinstitute/ichorCNA.git . && \
    git checkout "${ICHORCNA_COMMIT}" && \
    rm -rf .git

ENV PATH="/opt/ichorCNA/scripts:${PATH}"

# --- STEP 3: HMMcopy Suite (provides the readCounter binary) ---
# Build instructions per https://github.com/shahcompbio/hmmcopy_utils
# (plain cmake + make, no submodules - dependencies are vendored in-tree).
# Pinned to master's HEAD as of 2026-08-17; bump when a newer commit is needed.
ARG HMMCOPY_UTILS_COMMIT=29a8d1d18dfd301600d5d91832e5fe231935058c
WORKDIR /opt/hmmcopy_utils
RUN git clone https://github.com/shahcompbio/hmmcopy_utils.git . && \
    git checkout "${HMMCOPY_UTILS_COMMIT}" && \
    cmake -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
          -DCMAKE_C_FLAGS="-std=gnu17 -Wno-implicit-function-declaration" \
          -DCMAKE_CXX_FLAGS="-std=gnu++17" \
          . && \
    make && \
    rm -rf .git

ENV PATH="/opt/hmmcopy_utils/bin:/opt/hmmcopy_utils/util:${PATH}"

################## METADATA ######################
ARG ICHORCNA_COMMIT
ARG HMMCOPY_UTILS_COMMIT
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL ichorcna_commit=${ICHORCNA_COMMIT}
LABEL hmmcopy_utils_commit=${HMMCOPY_UTILS_COMMIT}
LABEL r-base=4.4.0

CMD ["/bin/bash"]
