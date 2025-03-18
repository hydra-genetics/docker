ARG VERSION=hook-f4bc661

# The build-stage image:
FROM python:3.9-slim AS build

ARG VERSION
ENV VERSION=${VERSION}

ENV VIRTUAL_ENV=/opt/venv
RUN python3 -m venv $VIRTUAL_ENV
ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Install dependencies:
# COPY requirements.txt .
RUN wget --progress=dot:giga "https://github.com/clinical-genomics-uppsala/poppy_uppsala/blob/main/requirements.txt" && pip install --no-cache-dir -r "requirements.txt"

# The runtime-stage image; we can use Debian as the
# base image since the Conda env also includes Python
# for us.
FROM debian:buster-slim AS runtime

RUN bash -c "source $VIRTUAL_ENV/bin/activate"

ARG VERSION
ENV VERSION=${VERSION}

################## METADATA ######################
LABEL maintainer="camille.clouard@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL bamsnap=${VERSION}


COPY --from=build /opt/conda/envs/hydra/ /opt/conda/envs/hydra/
ENV PATH=${PATH}:/opt/conda/envs/hydra/bin
