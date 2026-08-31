ARG VERSION=c134440
# commit c134440a46c5ad680f664069103ea86129b399ad for bamsnap since no version has been released yet.

# The build-stage image:
FROM continuumio/miniconda3:25.3.1-1 AS build

ARG VERSION

# Create hydra environment with pinned dependencies and install bamsnap
RUN conda create --name hydra -c bioconda -c conda-forge -y \
        python=3.11 \
        pysam=0.23.0 \
        pyfaidx=0.8.1.3 \
        pillow=11.1.0 \
        pytabix=0.1 \
        git=2.48.1 && \
    conda run -n hydra pip install --no-cache-dir git+https://github.com/parklab/bamsnap.git@${VERSION} && \
    conda clean --all -y

# The runtime-stage image:
FROM debian:bookworm-slim AS runtime

ARG VERSION

################## METADATA ######################
LABEL maintainer="arielle.munters@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL bamsnap=${VERSION}
LABEL python=3.11
LABEL pysam=0.23.0
LABEL pyfaidx=0.8.1.3
LABEL pillow=11.1.0
LABEL pytabix=0.1
LABEL git=2.48.1

COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin
