FROM ubuntu:latest

# Install wget and tar
RUN apt-get update && apt-get install -y wget tar && rm -rf /var/lib/apt/lists/*

# Download and extract pb-CpG-tools
RUN wget https://github.com/PacificBiosciences/pb-CpG-tools/releases/download/v2.3.2/pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu.tar.gz \
    && tar -xzf pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu.tar.gz \
    && rm pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu.tar.gz

# Set the PATH environment variable to include pb-CpG-tools
ENV PATH="/pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu:${PATH}"

# Set the working directory
WORKDIR /pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu

# Default command
CMD ["pb_CpG_tools"]




################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL pb-CpG-tools=2.3.2
LABEL python=3.9
LABEL version=2.3.2




