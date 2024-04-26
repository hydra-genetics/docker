# build minimap2-coverage
FROM continuumio/miniconda3

### MAINTAINER ###
MAINTAINER Yoshinori Fukasawa <yoshinori.fukasawa@kaust.edu.sa>
### LABELS ###
LABEL base_image="miniconda3"
LABEL software="LongQC docker"
LABEL software.version="1.2.1"

### Basic dependency ###
RUN apt-get clean all && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y  \
    git \
    build-essential \
    libc6-dev \
    zlib1g-dev && \
    apt-get clean && \
    apt-get purge

### LongQC installation ###
ADD https://api.github.com/repos/yfukasawa/longqc/git/refs/heads/minimap2_update version.json
RUN git clone https://github.com/yfukasawa/LongQC.git $HOME/LongQC
RUN cd $HOME/LongQC/minimap2-coverage && make
RUN cd $HOME/LongQC && \
    sed -i \
    -e '1{s;^;#!/opt/conda/bin/python\n;}' \
    longQC.py && \
    chmod +x longQC.py

### install LongQC's dependency ###
# Install LongQC's dependency
RUN conda config --add channels conda-forge && \
    conda config --add channels bioconda && \
    conda install -c conda-forge conda-pack && \
    conda create --name hydra python=3.9 numpy=1.26.4=py39h474f0d3_0 \ 
    pandas>=0.24.0 \ 
    scipy=1.13.0=py39h474f0d3_0 \ 
    jinja2=3.1.3=pyhd8ed1ab_0 \    
    h5py=3.11.0=nompi_py39h2c511df_100 \  
    matplotlib>=2.1.2 \
    scikit-learn=1.4.2=py39ha22ef79_0 \
    edlib=1.2.3=h2d50403_1 \
    pysam=0.22.1=py39hcada746_0 \ 
    python-edlib=1.3.9=py39h1f90b4d_6 \
    -c bioconda -c conda-forge -y

# Set up environment
RUN echo "conda activate hydra" >> ~/.bashrc

### Define PATH ###
ENV PATH="/root/LongQC:$PATH"

### Entry point
# ENTRYPOINT ["longQC.py"]


################## METADATA ######################
LABEL maintainer="magdalena.z@scilifelab.uu.se"
LABEL longqc=1.2.1
LABEL version=1.2.1

# Unit test runqc -h
# Unit test sampleqc -h




