FROM marrip/conifer:0.2.2

################## METADATA ######################
LABEL maintainer="martin.rippin@scilifelab.uu.se"
LABEL version=0.2.2
LABEL conifer=0.2.2

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN pip install --no-cache-dir pysam==0.19.0 && \
    echo '#!/usr/local/bin/python' | cat - conifer.py > /tmp/out && \
    mv /tmp/out conifer.py && \
    chmod a+x conifer.py
ENV PATH=$PATH:/CoNIFER
