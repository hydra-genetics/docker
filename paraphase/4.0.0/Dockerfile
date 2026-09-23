ARG VERSION=4.0.0

# The build-stage image: fetch and verify the prebuilt Rust binary release.
# (Paraphase >=4.0.0 is a Rust rewrite distributed as a static binary via
# GitHub releases; it is not yet published on bioconda.)
FROM debian:bookworm-20241202-slim AS build

ARG VERSION
ENV VERSION=${VERSION}
ARG SHA256=df68d18213d83ef4d6de3ea44aa5c7bcad20cfa47a934fc1b2ed290d2fd5eb24

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && \
    apt-get install --no-install-recommends -y \
    wget=1.21.3-1+deb12u1 \
    ca-certificates=20250419~deb12u1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /build

RUN wget -nv "https://github.com/PacificBiosciences/paraphase/releases/download/v${VERSION}/paraphase-v${VERSION}-x86_64-unknown-linux-gnu.tar.gz" && \
    echo "${SHA256}  paraphase-v${VERSION}-x86_64-unknown-linux-gnu.tar.gz" | sha256sum -c - && \
    tar xzf "paraphase-v${VERSION}-x86_64-unknown-linux-gnu.tar.gz" && \
    chmod +x "paraphase-v${VERSION}-x86_64-unknown-linux-gnu/paraphase"

# The runtime-stage image
FROM debian:bookworm-20241202-slim AS runtime

ARG VERSION
ENV VERSION=${VERSION}

################## METADATA ######################
LABEL maintainer="andrei.guliaev@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL paraphase=${VERSION}

RUN groupadd -r paraphase && useradd -r -g paraphase paraphase

COPY --chown=paraphase:paraphase --from=build /build/paraphase-v${VERSION}-x86_64-unknown-linux-gnu/paraphase /usr/local/bin/paraphase

USER paraphase
