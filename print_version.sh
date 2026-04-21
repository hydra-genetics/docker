#!/bin/bash

# Script to create yaml with $program: $version for MultiQC > v1.16
# First input = base for file, remaining input program version pairs

filebase=$1

if [ ! -d 'software_versions']; then
  mkdir "software_versions"
fi

echo -n "software_versions:" > software_versions/${filebase}_mqc_versions.yaml &&
while [ ! -z "$2" ]  # while $2 is not empty
do
  echo -e $2': "'$3'"' >> software_versions/${filebase}_mqc_versions.yaml
  shift 2
done
