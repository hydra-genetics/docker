ARG VERSION=1.8.27

# The build-stage image:
FROM continuumio/miniconda3:23.5.2-0 AS build

ARG VERSION
ENV VERSION=${VERSION}

# Install conda-pack:
RUN conda install -c conda-forge conda-pack conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda  -c conda-forge \
        python=3.12 \
        quarto=${VERSION} \
        pandas=2.3.3 \
        plotly=6.5.2 \
        openpyxl=3.1.5 \
        itables=2.7.0 

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:bookworm-slim AS runtime

ARG VERSION
ENV VERSION=${VERSION}

################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL pandas=2.3.3
LABEL plotly=6.5.2
LABEL openpyxl=3.1.5
LABEL itables=2.7.0



COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/


RUN mkdir -p /opt/conda/envs/hydra/bin/tools/x86_64/ && \
    ln -s /opt/conda/envs/hydra/bin/deno /opt/conda/envs/hydra/bin/tools/x86_64/deno 

RUN cd /opt/conda/envs/hydra/share/quarto && \
    for dir in */; do \
        ln -sf "/opt/conda/envs/hydra/share/quarto/$dir" "/opt/conda/envs/hydra/share/$dir"; \
    done


ENV PATH=${PATH}:/opt/conda/envs/hydra/bin
