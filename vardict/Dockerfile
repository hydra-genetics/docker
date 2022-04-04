# The build-stage image:
FROM debian:buster-slim AS build

# Install dependencies and clone vardict repos
RUN apt-get update && \
    apt-get install -y --no-install-recommends git=1:2.20.1-2+deb10u3 ca-certificates=20200601~deb10u2 default-jre=2:1.11-71 && \
    rm -rf /var/lib/apt/lists/* && \
    git clone -b v1.8.2 https://github.com/AstraZeneca-NGS/VarDict.git && \
    git clone -b v1.8.3 https://github.com/AstraZeneca-NGS/VarDictJava.git

# Build vardict
WORKDIR /VarDictJava
RUN ./gradlew clean installDist

# Runtime image with python3 available
FROM python:3.9-slim-buster AS runtime

################## METADATA ######################
LABEL maintainer="martin.rippin@scilifelab.uu.se"
LABEL version=1.8.3
LABEL snakemake-wrapper-utils=0.3.1
LABEL vardict-java=1.8.3

# Install R, JRE and perl libs as well as snakemake-wrapper-utils
ENV DEBIAN_FRONTEND=noninteractive \
    JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
RUN apt-get update && \
    apt-get install -y --no-install-recommends r-base=3.5.2-1 default-jre=2:1.11-71 libperl4-corelibs-perl=0.004-1+deb10u1 && \
    rm -rf /var/lib/apt/lists/* && \
    pip install --no-cache-dir snakemake-wrapper-utils==0.3.1

# Copy over necessary files from build stage
COPY --from=build /VarDictJava/build/install/VarDict/bin /usr/local/bin
COPY --from=build /VarDictJava/build/install/VarDict/lib /usr/local/lib
COPY --from=build /VarDict/test*.R /usr/local/bin/
COPY --from=build /VarDict/var2vcf_*.pl /usr/local/bin/
ENV VAR_DICT_OPTS=-Xmx32g
RUN mv /usr/local/bin/VarDict /usr/local/bin/vardict-java
