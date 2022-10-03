FROM debian:buster-slim

Run apt-get update && \
    apt-get install --no-install-recommends -y \
    wget=1.20.1-1.1 \
    ca-certificates=20200601~deb10u2 \
    curl=7.64.0-4+deb10u3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*


WORKDIR /expansionhunter

RUN wget -nv https://github.com/Illumina/ExpansionHunter/releases/download/v5.0.0/ExpansionHunter-v5.0.0-linux_x86_64.tar.gz && \
    tar -xvf ExpansionHunter-v5.0.0-linux_x86_64.tar.gz && \
    rm ExpansionHunter-v5.0.0-linux_x86_64.tar.gz

ENV PATH=/expansionhunter/ExpansionHunter-v5.0.0-linux_x86_64/bin:${PATH}

##############  #### METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL expansionhunter=5.0.0
LABEL version=5.0.0
