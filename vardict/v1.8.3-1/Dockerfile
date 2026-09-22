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

# Install R, JRE and perl libs as well as snakemake-wrapper-utils
ENV DEBIAN_FRONTEND=noninteractive \
    JAVA_HOME=/usr/lib/jvm/default-java
RUN apt-get update && \
    apt-get install -y --no-install-recommends r-base=4.2.2.20221110-2 default-jre=2:1.17-74 libperl4-corelibs-perl=0.004-3 && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir snakemake-wrapper-utils==0.9.0

# Copy over necessary files from build stage
COPY --from=build /VarDictJava/build/install/VarDict/bin /usr/local/bin
COPY --from=build /VarDictJava/build/install/VarDict/lib /usr/local/lib
COPY --from=build /VarDict/test*.R /usr/local/bin/
COPY --from=build /VarDict/var2vcf_*.pl /usr/local/bin/
ENV VAR_DICT_OPTS=-Xmx32g
RUN mv /usr/local/bin/VarDict /usr/local/bin/vardict-java
