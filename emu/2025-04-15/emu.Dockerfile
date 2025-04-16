FROM --platform=linux/amd64 quay.io/biocontainers/emu:3.4.5--hdfd78af_0

LABEL description="Emu image with emu pre-built 16S database"
LABEL emu=3.4.5
LABEL version=2025-04-15
LABEL maintainer="ida.karlsson@scilifelab.uu.se"

# Set workdir
WORKDIR /

# Python packages (osfclient & excel report dependencies)
RUN pip install --no-cache-dir osfclient==0.0.5 \
                                pandas==1.5.3 \
                                numpy==1.24.2 \
                                xlsxwriter==3.0.9

# Get 16S database from emu developers
RUN mkdir -p /emu_database/16S/emu-prebuilt && export EMU_DATABASE_16S=/emu_database/16S/emu-prebuilt && cd ${EMU_DATABASE_16S} \
    && osf -p 56uf7 fetch osfstorage/emu-prebuilt/emu.tar && tar -xvf emu.tar