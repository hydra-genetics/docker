FROM continuumio/miniconda3:4.10.3 AS builder

# Install conda-pack:
RUN conda config --set channel_priority strict && \
    conda install -c conda-forge conda-pack && \
    conda create --name hydra -c conda-forge -c bioconda -c defaults \
    perl=5.32.1 \
    bcftools=1.16 \
    bedtools=2.30.0 && \
    conda-pack -n hydra -o /tmp/env.tar

WORKDIR /venv

RUN tar xf /tmp/env.tar && \
    /venv/bin/conda-unpack

FROM r-base:4.1.2

################## METADATA ######################
LABEL maintainer="jessika.nordin@scilifelab.uu.se"
LABEL automap=1.2
LABEL version=1.2
LABEL perl=5.32.1
LABEL bcftools=1.16
LABEL bedtools=2.30.0
LABEL r-base=4.1.2

COPY redirect_log_to_stdout.ph /redirect_log_to_stdout.ph

RUN apt-get update \
  && apt-get install --no-install-recommends -y git=1:2.39.1-0.1 ca-certificates=20211016 curl=7.87.0-2 \
  && update-ca-certificates \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* && \
  git clone  https://github.com/mquinodo/AutoMap.git /automap && \
  chmod +x -R /automap/AutoMap_v1.2.sh && \
  rm -r /usr/local/man
  
COPY --from=builder /venv  /usr/local/

WORKDIR /automap
RUN patch AutoMap_v1.2.sh < /redirect_log_to_stdout.ph && \
    ln -s /automap/AutoMap_v1.2.sh automap && chmod +x automap
WORKDIR /

ENV PATH="${PATH}:/automap"
