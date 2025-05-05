 # The build-stage image:
FROM continuumio/miniconda3:4.10.3 AS build

RUN apt-get update
RUN apt-get install -y vim-gtk3
RUN apt-get install -y gawk
 

## Install wget using the system package manager (apt-get in this case).
#RUN apt-get update && apt-get install -y wget && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/*


# Copy the local directories into the image during the build.
# COPY broad/ /bro/
COPY  RepeatMasker/ /usr/bin/RepeatMasker2/


# Install conda-pack:
RUN conda install -c conda-forge conda-pack 

RUN conda create --name hydra -c bioconda bowtie2 samtools bedtools  python=2.7 && \
conda init bash && \
echo "conda activate hydra" >> ~/.bashrc
RUN export PATH="/opt/conda/envs/hydra/bin:$PATH"


## RepeatMasker + dependencies
# SHRIMP
WORKDIR /usr/bin
RUN wget http://compbio.cs.toronto.edu/shrimp/releases/SHRiMP_2_2_3.lx26.x86_64.tar.gz
RUN tar -xvzf SHRiMP_2_2_3.lx26.x86_64.tar.gz
RUN export PATH="/usr/bin/SHRiMP_2_2_3/bin:$PATH"
ENV PATH="/usr/bin/SHRiMP_2_2_3/bin:$PATH"

# RepeatMasker
WORKDIR /usr/bin
RUN conda create --name repeatmasker -c conda-forge h5py python=3.8 
# Activate the Conda environment.
SHELL ["conda", "run", "-n", "repeatmasker", "/bin/bash", "-c"] 

# Install packages from the Bioconda channel.
RUN conda install -c bioconda trf hmmer
RUN conda install -c conda-forge perl-text-soundex
RUN export PERL5LIB="/opt/conda/envs/repeatmasker/lib/perl5/vendor_perl:$PERL5LIB"
RUN echo "export PATH=\"/opt/conda/envs/repeatmasker/bin/:$PATH\" " >> ~/.bashrc
RUN echo "export PERL5LIB=\"/opt/conda/envs/repeatmasker/lib/perl5/vendor_perl:$PERL5LIB\" " >> ~/.bashrc
RUN echo "export PATH=\"/bin:$PATH\"" >> ~/.bashrc

# Deactivate the Conda environment.
SHELL ["/bin/bash", "-c"]

# Set PATHs so that the software is visable even outside of the repeatmasker environment
RUN export HMMER_DIR=/opt/conda/envs/repeatmasker/bin 
RUN export TRF_PRGM=/opt/conda/envs/repeatmasker/bin/trf
RUN export PATH="/usr/bin/RepeatMasker:$PATH"
ENV PATH="/usr/bin/RepeatMasker:$PATH"
RUN export PATH="/opt/conda/envs/repeatmasker/bin:$PATH"
# RUN wget https://www.repeatmasker.org/RepeatMasker/RepeatMasker-4.1.0.tar.gz
# RUN tar -xvzf RepeatMasker-4.1.0.tar.gz


# Alu Detect
WORKDIR /usr/bin
RUN wget http://compbio.cs.toronto.edu/alu-detect/releases/alu-detect-1.3.lx26.x86_64.tar.gz
RUN tar -xvzf alu-detect-1.3.lx26.x86_64.tar.gz
RUN export PATH="/usr/bin/alu-detect-1.3:$PATH"
ENV PATH="/usr/bin/alu-detect-1.3:$PATH"
WORKDIR /usr/bin/alu-detect-1.3


echo "conda activate repeatmasker" >> ~/.bashrc

################## METADATA ######################
LABEL maintainer="magdalena.z@scilifelab.uu.se"
LABEL verifybamid2=2.0.1
LABEL version=2.0.1

# Copy /venv from the previous stage:
# to /usr/local to make it possible
# running the softwares without activating
# any conda env

# COPY --from=build /venv  /usr/


