# Use an OpenJDK 8 base image
FROM openjdk:8-jdk

RUN apt-get update
RUN apt-get install -y vim-gtk3
RUN apt-get install -y gawk && \
apt-get install -y git && \ 
apt-get install git-lfs 
RUN apt-get install -y maven && \ 
apt-get install -y gcc && \
apt-get install -y make && \
apt-get install -y zlib1g-dev && \
apt-get install -y libncurses5-dev && \
apt-get install -y liblzma-dev && \
apt-get install -y libbz2-dev && \
apt-get install -y libcurl4-gnutls-dev

# Install samtools
WORKDIR /usr/bin
RUN wget https://netix.dl.sourceforge.net/project/samtools/samtools/1.18/samtools-1.18.tar.bz2
RUN tar xvjf samtools-1.18.tar.bz2
WORKDIR /usr/bin/samtools-1.18
RUN make
ENV PATH /usr/bin/samtools-1.18:$PATH


## Install wget using the system package manager (apt-get in this case).
#RUN apt-get update && apt-get install -y wget && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/*


# Install conda-pack:
#RUN conda install -c conda-forge conda-pack 

#RUN conda create --name hydra -c bioconda bwa  python=3.8 && \
#conda init bash && \
#echo "conda activate hydra" >> ~/.bashrc
#RUN export PATH="/opt/conda/envs/hydra/bin:$PATH"
# Activate the Conda environment.
# SHELL ["conda", "run", "-n", "hydra", "/bin/bash", "-c"]

## Create a conda env
# Set environment variables
ENV MINICONDA_VERSION 4.9.2
ENV CONDA_DIR /opt/conda
ENV PATH $CONDA_DIR/bin:$PATH

# Update package list, install dependencies for Conda
RUN apt-get update && apt-get install -y wget bzip2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py39_$MINICONDA_VERSION-Linux-x86_64.sh -O /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -b -p $CONDA_DIR && \
    rm /tmp/miniconda.sh

# Initialize Conda
RUN conda init bash
RUN conda install -c bioconda bwa
RUN conda install -c conda-forge r-base




## Install Mobster
WORKDIR /usr/bin
RUN git clone https://github.com/jyhehir/mobster.git
WORKDIR /usr/bin/mobster
RUN mkdir target
RUN ./install.sh
RUN gzip -d /usr/bin/mobster/resources/repmask/hg19_alul1svaerv.rpmsk.gz
WORKDIR /usr/bin/mobster/target


# Deactivate the Conda environment.
# SHELL ["/bin/bash", "-c"]

# echo "conda activate repeatmasker" >> ~/.bashrc

################## METADATA ######################
LABEL maintainer="magdalena.z@scilifelab.uu.se"
LABEL mobster=latest
LABEL version=latest

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env

# COPY --from=build /venv  /usr/
# Retrieved from https://github.com/jyhehir/mobster 

