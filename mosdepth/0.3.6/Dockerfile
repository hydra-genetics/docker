# Define version args for both builds
ARG mosdepth_version="0.3.6"
ARG python_version="3.9"
ARG snakemakewrapperutils_version="0.3.1"

# The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build

# Import version-args to use when installing
ARG mosdepth_version
ARG python_version
ARG snakemakewrapperutils_version
#RUN echo "The args are $mosdepth_version $python_version $snakemakewrapperutils_version"

# Install conda-pack:
RUN conda install -c conda-forge conda-pack && \
    conda create --name hydra -c bioconda  -c conda-forge \
	  mosdepth=$mosdepth_version \
	  python=$python_version \
      snakemake-wrapper-utils=$snakemakewrapperutils_version

# Use conda-pack to create a standalone enviornment
# in /venv:
RUN conda-pack -n hydra -o /tmp/env.tar
WORKDIR /venv
RUN tar xf /tmp/env.tar

# We've put venv in same path it'll be in final image,
# so now fix up paths:
RUN /venv/bin/conda-unpack

# # The runtime-stage image; we can use Debian as the
# # base image since the Conda env also includes Python
# # for us.
FROM debian:buster-slim AS runtime

# Import version args to covert to env which persists after build command
ARG mosdepth_version
ARG python_version
ARG snakemakewrapperutils_version
ENV mosdepth=$mosdepth_version
ENV python=$python_version
ENV snakemakewrapperutils=$snakemakewrapperutils_version
#RUN echo "The envs are: ${mosdepth} ${python} ${snakemakewrapperutils}"

################## METADATA ######################
LABEL maintainer="arielle.munters@scilifelab.uu.se"
LABEL version=${mosdepth}
LABEL mosdepth=${mosdepth}
LABEL snakemake-wrapper-utils=${snakemakewrapperutils}
LABEL python=${python}

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env
COPY --from=build /venv /usr

COPY print_version.sh /print_version.sh
RUN chmod +x /print_version.sh
ENTRYPOINT /print_version.sh "mosdepth-container" "mosdepth" $mosdepth "python" $python "snakemake-wrapper-utils" $snakemakewrapperutils