FROM r-base:3.3.1

# install curl and libcurl
RUN apt-get update 
#  && apt-get install --no-install-recommends -y curl libcurl4-openssl-dev \
#  && apt-get clean 
#  && rm -rf /var/lib/apt/lists/* \
#  && R -e "install.packages('devtools')" \
#  && mkdir -p /usr/src/juli \
#  && curl -SL https://github.com/sgilab/JuLI/raw/master/JuLI-v0.1.6.2.zip | bsdtar -xvf - -C /usr/src/juli \
#  && R -e "setwd('/usr/src/juli')" \
#  && R -e "install('juliv0.1.6.2')"



################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=0.1.6.2
LABEL juli=0.1.6.2
LABEL r-base=3.3.1
