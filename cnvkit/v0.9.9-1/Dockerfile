FROM python:3.11-slim-bookworm AS runtime

ARG RIG_VERSION=0.10.0
ARG R_VERSION=3.6.3

################## METADATA ######################
LABEL maintainer="patrik.smeds@scilifelab.uu.se"
LABEL version=0.9.9-1
LABEL cnvkit=0.9.9
LABEL joblib=1.3.2
LABEL pomegranate=0.14.8
LABEL pandas=1.5.3
LABEL python=3.11
LABEL r-base=3.6.3
LABEL snakemake-wrapper-utils=0.9.0

ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# pomegranate is installed from a local source dir (cython<3 rebuild), which older hadolint flags as unpinned
# hadolint ignore=DL3013
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl=7.88.1-10+deb12u15 ca-certificates=20250419~deb12u1 \
        locales=2.36-9+deb12u14 gfortran=4:12.2.0-3 libblas-dev=3.11.0-2 \
        liblapack-dev=3.11.0-2 python3-setuptools=66.1.1-1+deb12u2 build-essential=12.9 && \
    sed -i 's/^# *\(en_US.UTF-8 UTF-8\)/\1/' /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8 && \
    curl -fsSL "https://github.com/r-lib/rig/releases/download/v${RIG_VERSION}/rig-linux-$(uname -m)-${RIG_VERSION}.tar.gz" | \
        tar xz -C /usr/local && \
    rig add --without-pak "https://cdn.posit.co/r/debian-12/pkgs/r-${R_VERSION}_1_$(dpkg --print-architecture).deb" && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir cython==0.29.37 numpy==1.26.4 scipy==1.17.1 setuptools==79.0.1 wheel==0.46.3 && \
    mkdir /tmp/pomegranate && \
    curl -fsSL https://files.pythonhosted.org/packages/source/p/pomegranate/pomegranate-0.14.8.tar.gz | \
        tar xz -C /tmp/pomegranate --strip-components=1 && \
    find /tmp/pomegranate/pomegranate -name "*.c" -delete && \
    pip install --no-cache-dir --no-build-isolation /tmp/pomegranate && \
    rm -rf /tmp/pomegranate && \
    pip install --no-cache-dir snakemake-wrapper-utils==0.9.0 numpy==1.26.4 pandas==1.5.3 scikit-learn==1.3.2 \
        joblib==1.3.2 biopython==1.88 matplotlib==3.8.4 networkx==3.6.1 pyfaidx==0.9.0.4 pysam==0.24.1 \
        reportlab==5.0.1 && \
    pip install --no-cache-dir --no-deps cnvkit==0.9.9 && \
    Rscript -e 'install.packages("BiocManager")' && \
    Rscript -e "source('http://callr.org/install#DNAcopy')" && \
    apt-get remove -y python3-setuptools \
                 libblas-dev \
                 liblapack-dev \
                 gfortran && \
    apt-get autoremove -y && \
    pip3 cache purge
