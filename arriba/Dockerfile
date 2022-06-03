FROM debian:buster-slim AS build

RUN apt-get update && \
    apt-get install --no-install-recommends -y wget=1.20.1-1.1 ca-certificates=20200601~deb10u2 && \
    rm -rf /var/lib/apt/lists/* && \
    wget 'https://github.com/alexdobin/STAR/archive/2.7.10a.tar.gz' && \
    tar -xzf 2.7.10a.tar.gz && \
    wget 'https://github.com/suhrig/arriba/releases/download/v2.3.0/arriba_v2.3.0.tar.gz' && \
    tar -xzf arriba_v2.3.0.tar.gz

FROM r-base:4.2.0 AS runtime

################## METADATA ######################
LABEL maintainer="martin.rippin@scilifelab.uu.se"
LABEL version=2.2.1
LABEL arriba=2.2.1

RUN apt-get update && \
    apt-get install --no-install-recommends -y libxml2=2.9.14+dfsg-1 samtools=1.13-4 && \
    rm -rf /var/lib/apt/lists/* && \
    Rscript -e "install.packages(c(\"circlize\", \"BiocManager\"))" -e "BiocManager::install(\"GenomicAlignments\")" -e "BiocManager::install(\"GenomicRanges\")"
COPY --from=build /STAR-2.7.10a/bin/Linux_x86_64/STAR /usr/local/bin/
COPY --from=build /arriba_v2.3.0/arriba /usr/local/bin/
COPY --from=build /arriba_v2.3.0/draw_fusions.R /usr/local/bin/
