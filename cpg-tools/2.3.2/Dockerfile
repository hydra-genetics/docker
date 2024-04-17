FROM ubuntu:20.04
# Install wget and tar
RUN apt-get update && apt-get install -y --no-install-recommends wget=1.20.3-1ubuntu2 tar=1.30+dfsg-7ubuntu0.20.04.4 ca-certificates=20230311ubuntu0.20.04.1  && rm -rf /var/lib/apt/lists/*


# Download and extract pb-CpG-tools
RUN wget -nv  https://github.com/PacificBiosciences/pb-CpG-tools/releases/download/v2.3.2/pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu.tar.gz \
    && tar -xzf pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu.tar.gz \
    && rm pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu.tar.gz

# Set the PATH environment variable to include pb-CpG-tools
ENV PATH="/pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu:/pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu/bin:${PATH}"

# Set the working directory
WORKDIR "/pb-CpG-tools-v2.3.2-x86_64-unknown-linux-gnu"

# Default command
CMD ["aligned_bam_to_cpg_scores"]




################## METADATA ######################
LABEL maintainer="padraic.corcoran@scilifelab.uu.se"
LABEL pbcpgtools=2.3.2
LABEL version=2.3.2


#TEST:  aligned_bam_to_cpg_scores --help 


