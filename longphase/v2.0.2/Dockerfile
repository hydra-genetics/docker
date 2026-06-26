ARG VERSION=2.0.2

# The build-stage image:
FROM continuumio/miniconda3:23.5.2-0 AS build

ARG VERSION
ENV VERSION=${VERSION}

# Install libmamba solver and create the hydra environment:
RUN conda install --yes -c conda-forge conda-libmamba-solver && \
    conda config --set solver libmamba && \
    conda create --yes --name hydra -c bioconda -c conda-forge \
        longphase=${VERSION}

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:bookworm-slim  AS runtime

ARG VERSION
ENV VERSION=${VERSION}

################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL longphase=${VERSION}


RUN groupadd -r hydra && useradd -r -g hydra -d /home/hydra -m hydra
COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
RUN chown -R hydra:hydra /opt/conda/envs/hydra /home/hydra
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin
USER hydra
