#!/bin/bash
sudo docker build -t bamsnap:custom --no-cache --progress=plain . &> build.log
wait
# Test whether bamsnap was actually installed
sudo docker run -i -t bamsnap:custom bamsnap --help
