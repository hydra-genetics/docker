FROM debian:bookworm-slim

ARG VERSION=0.2.2


################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL version=${VERSION}
LABEL echtvar=${VERSION}


RUN apt-get update \
    && apt-get install --no-install-recommends -y \
    wget=1.21.3-1+deb12u1 \
    ca-certificates=20230311+deb12u1 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && wget --progress=dot:giga /usr/bin/echtvar https://github.com/brentp/echtvar/releases/download/v${VERSION}/echtvar \
    && chmod +x /usr/bin/echtvar


CMD [ "echtvar" ]
