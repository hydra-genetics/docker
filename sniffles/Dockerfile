# The build-stage image:
    FROM continuumio/miniconda3:23.5.2-0 AS build

    # Install conda-pack:
    RUN conda install -c conda-forge conda-pack conda-libmamba-solver && \
        conda config --set solver libmamba && \
        conda create --name hydra -c bioconda  -c conda-forge \
            sniffles=2.4 
    
    # The runtime-stage image; we can use Debian as the
    # base image since the Conda env also includes Python
    # for us.
    FROM debian:buster-slim AS runtime
    
    ################## METADATA ######################
    LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
    LABEL version=2.4
    LABEL sniffles=2.4
    
    COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
    ENV PATH=${PATH}:/opt/conda/envs/hydra/bin
    