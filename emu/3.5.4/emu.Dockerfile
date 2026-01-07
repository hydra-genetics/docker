FROM continuumio/miniconda3:25.3.1-1 AS build

RUN conda config --set channel_priority strict && \
    conda install -c conda-forge conda-pack && \
    conda create --name hydra -c conda-forge -c bioconda -c defaults \
    emu=3.5.4 \
    xlsxwriter==3.0.9


FROM debian:buster-slim AS runtime

WORKDIR /

################## METADATA ######################
LABEL description="Emu with excel report dependencies"
LABEL maintainer="ida.karlsson@scilifelab.uu.se"
LABEL version=3.5.4
LABEL emu=3.5.4
LABEL xlsxwriter=3.0.9

COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin