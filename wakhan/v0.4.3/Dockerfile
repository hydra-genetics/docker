ARG VERSION=0.4.3

# The build-stage image:
FROM continuumio/miniconda3:24.11.1-0 AS build

ARG VERSION
ENV VERSION=${VERSION}

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN conda install -c conda-forge conda-libmamba-solver=24.9.0 && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda -c conda-forge \
    wakhan=${VERSION} && \
    conda clean --all -y

FROM debian:bookworm-20241202-slim AS runtime

ARG VERSION
ENV VERSION=${VERSION}

################## METADATA ######################
LABEL maintainer="andrei.guliaev@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL wakhan=${VERSION}
   
RUN groupadd -r wakhan && useradd -r -g wakhan wakhan
COPY --chown=wakhan:wakhan --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=/opt/conda/envs/hydra/bin:${PATH}
USER wakhan
