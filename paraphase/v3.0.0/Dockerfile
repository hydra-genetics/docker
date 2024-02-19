# Use the specified Miniconda base image
FROM continuumio/miniconda3:4.10.3 AS build

# Set the working directory
WORKDIR /usr/local

# Install git
RUN apt-get update && apt-get install -y git=1:2.20.1-2+deb10u3 --no-install-recommends  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone the specific release (v3.0.0) from GitHub
RUN git clone --branch v3.0.0 https://github.com/PacificBiosciences/paraphase.git

# Change to the cloned directory
WORKDIR /usr/local/paraphase

# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
    conda create --name hydra -c conda-forge -c bioconda -c defaults \
    python=3.9 \
    minimap2=2.26 \
    samtools=1.16.1 \
    snakemake-wrapper-utils=0.6.1

# Set the environment variable
#ENV CONDA_ENVIRONMENT hydra
#RUN echo "source activate ${CONDA_ENVIRONMENT}" >> ~/.bashrc

# Modify the .bashrc file
RUN echo "export PATH=$PATH:/opt/conda/envs/hydra/bin" >> ~/.bashrc
ENV PATH="/opt/conda/envs/hydra/bin:${PATH}"

# hadolint ignore=SC1008
SHELL ["/opt/conda/condabin/conda", "run", "-n", "hydra", "/bin/bash", "-c"]
# hadolint ignore=SC1008
#RUN  /opt/conda/envs/hydra/bin/pip install --no-cache-dir paraphase==3.0.0

# Use an entry point for the paraphrase command
# ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "hydra", "paraphrase"]

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
FROM debian:buster-slim AS runtime


################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version=3.0.0
LABEL paraphrase=3.0.0

# Unite test: samtools;  minimap2;  paraphase


# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env

#RUN mkdir -p /usr
COPY --from=build /venv  /usr/




