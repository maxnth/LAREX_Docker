#!/bin/sh
########################################################
######## Build and run a Docker image for Larex ########
########################################################

## Container name (must be lower case)
DOCKER_NAME="larex"

## Local path to the directory containing the books
LAREX_DIR="/home/mn/Desktop/books"

## Port
PORT=5555

## Stop and delete old container (if exists)
OLD="$(docker ps --all --quiet --filter=name="$DOCKER_NAME")"
if [ -n "$OLD" ]; then
  docker stop $OLD && docker rm $OLD
fi

## Build and start container
docker build -t $DOCKER_NAME . && \
docker run \
    -p $PORT:8080 \
    -u `id -u root`:`id -g $USER` \
    --name $DOCKER_NAME \
    -v $LAREX_DIR:/home/books/ \
    -it $DOCKER_NAME
