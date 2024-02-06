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
ENV CONDA_ENVIRONMENT hydra

# Modify the .bashrc file
RUN echo "source activate ${CONDA_ENVIRONMENT}" >> ~/.bashrc


SHELL ["/opt/conda/condabin/conda", "run", "-n", "hydra", "/bin/bash", "-c"]
RUN  /opt/conda/envs/hydra/bin/pip install --no-cache-dir paraphase==3.0.0

# Use an entry point for the paraphrase command
# ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "hydra", "paraphrase"]

################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version=3.0.0
LABEL paraphrase=3.0.0

# Unite test: samtools;  minimap2;  paraphase

