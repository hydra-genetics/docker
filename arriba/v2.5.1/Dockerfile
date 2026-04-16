############################
# Build stage: compile STAR and prepare Arriba
############################
FROM debian:bullseye-slim AS build

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        wget \
        ca-certificates \
        make \
        g++ \
        zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# Download and compile STAR
RUN wget https://github.com/alexdobin/STAR/archive/2.7.10a.tar.gz && \
    tar -xzf 2.7.10a.tar.gz && \
    cd STAR-2.7.10a/source && \
    make STAR

# Download Arriba
RUN wget https://github.com/suhrig/arriba/releases/download/v2.5.1/arriba_v2.5.1.tar.gz && \
    tar -xzf arriba_v2.5.1.tar.gz


############################
# Runtime stage: stable Debian + R + tools
############################
FROM debian:bullseye-slim

################## METADATA ##################
LABEL maintainer="nina.hollfelder@scilifelab.uu.se"
LABEL star_version="2.7.10a"
LABEL arriba_version="2.5.1"

################## SYSTEM TOOLS ##################
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
        r-base \
        samtools \
        libxml2-dev \
        ca-certificates && \
    rm -rf /var/lib/apt/lists/*

################## R / BIOCONDUCTOR ##################
RUN Rscript -e 'install.packages(c("circlize","BiocManager"), repos="https://cloud.r-project.org")' && \
    Rscript -e 'BiocManager::install(c("GenomicAlignments","GenomicRanges"))'

################## COPY BINARIES ##################
COPY --from=build /STAR-2.7.10a/source/STAR /usr/local/bin/STAR
COPY --from=build /arriba_v2.5.1/arriba /usr/local/bin/arriba
COPY --from=build /arriba_v2.5.1/draw_fusions.R /usr/local/bin/draw_fusions.R

################## DEFAULT COMMAND ##################
CMD ["bash"]
