FROM zamora/r-devtools@sha256:b858468b5a82331ae5b7a3cfc46bd5c2653f12fb65abc0efd6f1af95bdb979c6

ADD https://github.com/sgilab/JuLI/raw/master/JuLI-v0.1.6.2.zip /tmp/JuLI-v0.1.6.2.zip
RUN unzip /tmp/JuLI-v0.1.6.2.zip -d /unpack/

# install R packages
RUN R -e "install.packages('rlang',repos = 'http://cran.us.r-project.org')" \
  && R -e "install.packages('ggplot2',repos = 'http://cran.us.r-project.org')" \
  && R -e "install.packages('https://github.com/r-lib/gtable/archive/refs/tags/v0.3.3.tar.gz', repos=NULL, type='source', dependencies=TRUE)" \
  && R -e "install.packages('ggplot2',repos = 'http://cran.us.r-project.org')" \
  && R -e "install.packages('BiocManager',repos = 'http://cran.us.r-project.org')" \
  && R -e "BiocManager::install('Rsamtools', update = FALSE)" \
  && R -e "devtools::install_local('/unpack/JuLI-v0.1.6.2/juliv0.1.6.2')"



################## METADATA ######################
LABEL maintainer="jonas.almlof@scilifelab.uu.se"
LABEL version=0.1.6.2
LABEL juli=0.1.6.2
LABEL r-base=3.6.0
