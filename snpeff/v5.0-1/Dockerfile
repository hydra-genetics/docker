# syntax=docker/dockerfile:1.7
# The build-stage image:
# miniforge3 ships mamba/libmamba and conda-forge as the default channel, so
# there is no need to bootstrap a fast solver with the slow one first.
FROM condaforge/miniforge3:24.11.3-2 AS build

# conda-pack must be >=0.7.0, earlier versions truncate the python
# minor version (3.12 -> 3.1) and fail on python>=3.10 environments.
# Cache mount keeps the downloaded packages between builds.
RUN --mount=type=cache,target=/opt/conda/pkgs,sharing=locked \
    mamba install -y -c conda-forge conda-pack=0.8.1

# conda-forge must precede bioconda, and strict priority stops the solver
# from exploring both channels' versions of every dependency.
RUN --mount=type=cache,target=/opt/conda/pkgs,sharing=locked \
    mamba create -y --name hydra --strict-channel-priority \
    -c conda-forge -c bioconda \
    bcftools=1.24 \
    python=3.12 \
    snakemake-wrapper-utils=0.9.0 \
    snpeff=5.0

# Use conda-pack to create a standalone enviornment
# in /venv:
RUN conda-pack -n hydra -o /tmp/env.tar
WORKDIR /venv
RUN tar xf /tmp/env.tar

# We've put venv in same path it'll be in final image,
# so now fix up paths:
RUN /venv/bin/conda-unpack

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:bookworm-slim AS runtime

################## METADATA ######################
LABEL maintainer="martin.rippin@scilifelab.uu.se"
LABEL version=5.0-1
LABEL bcftools=1.24
LABEL python=3.12
LABEL snakemake-wrapper-utils=0.9.0
LABEL snpeff=5.0

# debian ships /usr/local/man as a symlink to share/man, and the packed env
# contains a real man/ directory. COPY refuses to write a directory over a
# symlink, so drop it first; man pages end up in /usr/local/man instead.
RUN rm -f /usr/local/man

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr/local

# Smoke test: confirm the packed env actually runs on the runtime base.
RUN bcftools --version && snpEff -version && python --version
