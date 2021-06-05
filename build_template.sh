#!/bin/sh
########################################################
######## Build and run a Docker image for Larex ########
########################################################

## Container name (must be lower case)
DOCKER_NAME="larex"

## Image name
IMAGE_NAME="larex"

## Local path to the directory containing the books
LAREX_DIR="/Path/to/books"

## Local path to the custom configuration file
CONFIG_FILE="/Path/to/larex.config"

## Port
PORT=5555

## Stop and delete old container (if exists)
OLD="$(docker ps --all --quiet --filter=name="$DOCKER_NAME")"
if [[ -n "$OLD" ]]; then
  docker stop ${OLD} && docker rm ${OLD}
fi

## Build and start container
docker build -t ${IMAGE_NAME} . && \
docker run \
    -p ${PORT}:8080 \
    --name ${DOCKER_NAME} \
    -v ${CONFIG_FILE}:/larex.config \
    -v ${LAREX_DIR}:/home/books/ \
    -it ${IMAGE_NAME}
