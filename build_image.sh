#!/bin/bash

# Usage: $ sudo bash build_image.sh <path_to_dockerfile>

dockerFilePath=$1

echo "dockerfile=${dockerFilePath}"
PARENT_FOLDER=$(dirname ${dockerFilePath})
echo "PARENT_FOLDER=${PARENT_FOLDER}"

# Extract image name
IMAGE_NAME=$(echo ${dockerFilePath} | awk 'BEGIN{FS="\/"}{print($1)}')
echo "IMAGE_NAME=${IMAGE_NAME}"

# Extract image version, support both setting the actual version in the label statement
# and also when using variables (ARG XXX_VERSION). Preferred method is to VERSION.
IMAGE_VERSION=$(grep "^LABEL version" ${dockerFilePath} | awk 'BEGIN{FS="\="}{print($2)}')
echo "IMAGE_VERSION=${IMAGE_VERSION}"
if [[ ${IMAGE_VERSION} == *"VERSION"* ]]; then
IMAGE_VERSION=$(echo ${IMAGE_VERSION} | sed 's/[{}$]//g')
IMAGE_VERSION=$(grep "^ARG ${IMAGE_VERSION}" ${dockerFilePath} | awk 'BEGIN{FS="\="}{print($2)}')
echo "IMAGE_VERSION=${IMAGE_VERSION}"
fi
echo "IMAGE_VERSION=${IMAGE_VERSION}"

# Build image, tag it with a random id
tmpName="image-${RANDOM}"
## Copy version script and put it beside the Dockerfile
#cp print_version.sh ${PARENT_FOLDER}/print_version.sh
echo "build command: docker build ${PARENT_FOLDER} --file ${dockerFilePath} --tag ${tmpName}"
docker build ${PARENT_FOLDER} --file ${dockerFilePath} --tag ${tmpName}

# Create image id for local integration test
IMAGE_ID=${IMAGE_NAME}
# Tag the new image with actual image name and version
echo  "Image that will be tagged and pushed to DockerHub: ${IMAGE_ID}:${IMAGE_VERSION}"
