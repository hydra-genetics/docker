FROM continuumio/miniconda3:4.10.3 AS builder

# Install conda-pack:
RUN conda config --set channel_priority strict && \
    conda install -c conda-forge conda-pack && \
    conda create --name hydra -c conda-forge -c bioconda -c defaults \
    click=8.0.4 \
    coloredlogs=15.0.1 \
    conda-pack -n hydra -o /tmp/env.tar

WORKDIR /venv

RUN tar xf /tmp/env.tar && \
    /venv/bin/conda-unpack


################## METADATA ######################
LABEL maintainer="jessika.nordin@scilifelab.uu.se"
LABEL upd=0.1.1
LABEL version=0.1.1
LABEL click=8.0.4
LABEL coloredlogs=15.0.1


RUN apt-get update \
  && apt-get install --no-install-recommends -y git=1:2.39.1-0.1 ca-certificates=20211016 curl=7.87.0-2 \
  && update-ca-certificates \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* && \
  git clone  https://github.com/bjhall/upd /upd && \
  cd /upd && \
  pip install --editable . && \
  rm -r /usr/local/man

COPY --from=builder /venv  /usr/local/

WORKDIR /upd

ENV PATH="${PATH}:/upd"
