 # The build-stage image:
# FROM continuumio/miniconda3:4.10.3 AS build
FROM openjdk:11-jre-slim AS build

#RUN apt-get update
#RUN apt-get install -y vim-gtk3
#RUN apt-get install -y --ignore-missing default-jdk
#RUN apt-get install -y default-jdk
#RUN apt-get clean



# configurera java env
# RUN echo "export PATH=\"\$PATH:/usr/lib/jvm/default-java/bin\"" >> ~/.bashrc
# RUN export PATH="$PATH:/usr/lib/jvm/default-java/bin"


## Install wget using the system package manager (apt-get in this case).
RUN apt-get update && apt-get install -y wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install conda
ENV PATH /opt/conda/bin:$PATH
RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
bash ~/miniconda.sh -b -p /opt/conda && \
rm ~/miniconda.sh
# RUN    /opt/conda/bin/conda clean -tipsy && \
#   ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
#    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc

# Copy the local directories into the image during the build.
# COPY broad/ /bro/
COPY  MELTv2.2.2 /usr/bin/MELTv2.2.2


# Install conda-pack:
#RUN conda install -c conda-forge conda-pack

RUN conda create --name hydra -c bioconda bowtie2 samtools python=3.8 && \
conda init bash 
RUN echo "conda activate hydra" >> ~/.bashrc
RUN export PATH="/opt/conda/envs/hydra/bin:$PATH"


## The following instructions were done to create reference files to run MELT, they were obtained from the manual, and do not have to be repeated when using the prepared software folder

# We also need the reference genome. Please download the reference file like so:
# wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/phase2_reference_assembly_sequence/hs37d5.fa.gz
# wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/phase2_reference_assembly_sequence/hs37d5.fa.gz.fai

# Then we also need to crete files which contains a list of the reference sequences we are looking for. These files are each located in the folders of MELTv2.2.2/me_refs/*/mei-list.txt
# They contain the full path of each of the repeat classes to run against, for example:
# cat MELTv2.2.2/me_refs/1KGP_Hg19/mei_list.txt
# /usr/bin/MELTv2.2.2/me_refs/1KGP_Hg19/ALU_MELT.zip
# /usr/bin/MELTv2.2.2/me_refs/1KGP_Hg19/LINE1_MELT.zip
# /usr/bin/MELTv2.2.2/me_refs/1KGP_Hg19/SVA_MELT.zip
# I've created files which contains the absolute path in the docker instance, not on the cluster, so the distro can only run in the docker instance

#unzip the main reference file to an easy to access location using:
# gunzip hs37d5.fa.gz
# and rename the index file like:
# mv hs37d5.fa.gz.fai hs37d5.fa.fai


WORKDIR /usr/bin/MELTv2.2.2 


# Info from https://melt.igs.umaryland.edu/manual.php 


################## METADATA ######################
LABEL maintainer="magdalena.z@scilifelab.uu.se"
LABEL version=2.2.2
LABEL java=11
LABEL python=3.8
LABEL hydra-genomics=latest



