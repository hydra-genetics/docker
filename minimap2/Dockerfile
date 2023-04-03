FROM alpine:3.10 AS build
RUN apk add --no-cache gcc=8.3.0-r0 g++=8.3.0-r0 zlib-dev=1.2.11-r1 libc-dev=0.7.1-r0 curl=7.66.0-r4 make=4.2.1-r2 bzip2=1.0.6-r7
WORKDIR /build
ARG MINIMAP2_VERSION=2.24
RUN curl -OL https://github.com/lh3/minimap2/releases/download/v$MINIMAP2_VERSION/minimap2-$MINIMAP2_VERSION.tar.bz2 && \
    tar xjf minimap2-$MINIMAP2_VERSION.tar.bz2
WORKDIR /build/minimap2-$MINIMAP2_VERSION
RUN make

FROM alpine:3.10
RUN apk add --no-cache bash=5.0.0-r0
ARG MINIMAP2_VERSION=2.24
COPY --from=build /build/minimap2-$MINIMAP2_VERSION/minimap2 /usr/local/bin

################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=2.24