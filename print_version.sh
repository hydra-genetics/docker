#!/bin/bash

# Script to create yaml with $program: $version for MultiQC > v1.16
# First input = base for file, remaining input program version pairs

filebase=$1
echo -n "" > ${filebase}_mqc_versions.yaml &&
while [ ! -z "$2" ]  # while $2 is not empty
do
  echo -e $2': "'$3'"' >> ${filebase}_mqc_versions.yaml
  shift 2
done &&
/bin/bash
