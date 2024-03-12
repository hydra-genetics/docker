ARG VERSION=2.2
FROM continuumio/miniconda3:4.10.3 AS build
ARG VERSION 

# Install conda-pack:
RUN conda install -c conda-forge conda-libmamba-solver && \ 
conda config --set solver libmamba && \
conda create -y -n hydra -c bioconda sniffles=${VERSION}  && \
conda clean -afy

# base image since the Conda env also includes Python
# for us.
FROM debian:buster-slim AS runtime
ARG VERSION

################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL sniffles2e=${VERSION}
RUN echo "${VERSION}"

# Unite test: samtools;  sniffles
COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin


