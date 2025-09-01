ARG VERSION=0.22.1

# The build-stage image:
FROM continuumio/miniconda3:25.3.1-1 AS build

ARG VERSION
ENV VERSION=${VERSION}

# Install conda-pack:
RUN conda install -c conda-forge conda-pack conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --name hydra -c bioconda -c conda-forge -c nanoporetech \
        htslib=1.22.1 \
        fastcat=${VERSION}

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:buster-slim AS runtime

ARG VERSION
ENV VERSION=${VERSION}

################## METADATA ######################
LABEL maintainer="camille.clouard@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL fastcat=${VERSION}
LABEL htslib=1.22.1


COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin
