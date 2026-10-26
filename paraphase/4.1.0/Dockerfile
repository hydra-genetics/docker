ARG VERSION=4.1.0

# The build-stage image: fetch and verify the prebuilt Rust binary release.
# (Paraphase >=4.0.0 is a Rust rewrite distributed as a static binary via
# GitHub releases; it is not yet published on bioconda.)
FROM debian:bookworm-20261020-slim AS build

ARG VERSION
ENV VERSION=${VERSION}
ARG SHA256=b650fa83cbdbb4b19b1b26bd0aae923e60101919ea96494f93aa58e3abc265de

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008
RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    wget \
    ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

RUN wget -nv "https://github.com/PacificBiosciences/paraphase/releases/download/v${VERSION}/paraphase-v${VERSION}-x86_64-unknown-linux-gnu.tar.gz" && \
    echo "${SHA256}  paraphase-v${VERSION}-x86_64-unknown-linux-gnu.tar.gz" | sha256sum -c - && \
    tar xzf "paraphase-v${VERSION}-x86_64-unknown-linux-gnu.tar.gz" && \
    chmod +x "paraphase-v${VERSION}-x86_64-unknown-linux-gnu/paraphase"

# The runtime-stage image
FROM debian:bookworm-20261020-slim AS runtime

ARG VERSION
ENV VERSION=${VERSION}

################## METADATA ######################
LABEL maintainer="andrei.guliaev@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL paraphase=${VERSION}

RUN groupadd -r paraphase && useradd -r -g paraphase paraphase

COPY --chown=paraphase:paraphase --from=build /build/paraphase-v${VERSION}-x86_64-unknown-linux-gnu/paraphase /usr/local/bin/paraphase

USER paraphase
