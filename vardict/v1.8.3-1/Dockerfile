# The build-stage image:
FROM debian:bookworm-slim AS build

# Install dependencies and clone vardict repos
RUN apt-get update && \
    apt-get install -y --no-install-recommends git=1:2.39.5-0+deb12u3 ca-certificates=20250419~deb12u1 default-jre=2:1.17-74 && \
    rm -rf /var/lib/apt/lists/* && \
    git clone -b v1.8.2 https://github.com/AstraZeneca-NGS/VarDict.git && \
    git clone -b v1.8.3 https://github.com/AstraZeneca-NGS/VarDictJava.git

# Build vardict
WORKDIR /VarDictJava
RUN ./gradlew clean installDist

# Runtime image with python3 available
FROM python:3.12-slim-bookworm AS runtime

################## METADATA ######################
LABEL maintainer="martin.rippin@scilifelab.uu.se"
LABEL version=1.8.3-1
LABEL snakemake-wrapper-utils=0.9.0
LABEL vardict-java=1.8.3
LABEL r=3.6.3

ARG RIG_VERSION=0.10.0
ARG R_VERSION=3.6.3

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install JRE and perl libs, R via rig, as well as snakemake-wrapper-utils
ENV DEBIAN_FRONTEND=noninteractive \
    JAVA_HOME=/usr/lib/jvm/default-java \
    LANG=en_US.UTF-8 \
    LC_ALL=en_US.UTF-8
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl=7.88.1-10+deb12u15 ca-certificates=20250419~deb12u1 \
        default-jre=2:1.17-74 libperl4-corelibs-perl=0.004-3 locales=2.36-9+deb12u14 && \
    sed -i 's/^# *en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    curl -fsSL "https://github.com/r-lib/rig/releases/download/v${RIG_VERSION}/rig-linux-$(uname -m)-${RIG_VERSION}.tar.gz" | \
        tar xz -C /usr/local && \
    rig add --without-pak "https://cdn.posit.co/r/debian-12/pkgs/r-${R_VERSION}_1_$(dpkg --print-architecture).deb" && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8 && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir snakemake-wrapper-utils==0.9.0

# Copy over necessary files from build stage
COPY --from=build /VarDictJava/build/install/VarDict/bin /usr/local/bin
COPY --from=build /VarDictJava/build/install/VarDict/lib /usr/local/lib
COPY --from=build /VarDict/test*.R /usr/local/bin/
COPY --from=build /VarDict/var2vcf_*.pl /usr/local/bin/
ENV VAR_DICT_OPTS=-Xmx32g
RUN mv /usr/local/bin/VarDict /usr/local/bin/vardict-java
