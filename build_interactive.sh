#!/bin/sh
######################################################################
######## Build and run a Docker image for Larex interactively ########
######################################################################

## Container name (must be lower case)
read -p "Enter container name: " CONTAINER_NAME

## Image name
read -p "Enter image name: " IMAGE_NAME

## Local path to the directory containing the books
read -p "Enter local book directory: " BOOK_DIR

## Local path to the save dir. Ignored if empty
read -p "Enter local save directory. Leave empty if not used: " SAVE_DIR

## Configuration file
read -p "Enter path to configuration file: " CONFIG_FILE

## Port
read -p "Enter Port: " PORT

## Stop and delete old container (if exists)
OLD="$(docker ps --all --quiet --filter=name="$CONTAINER_NAME")"
if [[ -n "$OLD" ]]; then
  read -p "Stop and remove container with the same name? (y/n): " confirm
  if [[ ${confirm} == [yY] ]]; then
    echo "Old container removed.";
  else
    echo "Aborted.";
    exit;
  fi
  docker stop ${OLD} && docker rm ${OLD}
fi

## Build and start container
docker build -t ${IMAGE_NAME} . && \
if [ -z "$SAVE_DIR" ]
then
      docker run \
        -p ${PORT}:8080 \
        --name ${DOCKER_NAME} \
        -v ${CONFIG_FILE}:/larex.config \
        -v ${BOOK_DIR}:/home/books/ \
        -it ${IMAGE_NAME}

else
      docker run \
        -p ${PORT}:8080 \
        --name ${DOCKER_NAME} \
        -v ${CONFIG_FILE}:/larex.config \
        -v ${BOOK_DIR}:/home/books/ \
        -v ${SAVE_DIR}:/home/savedir \
        -it ${IMAGE_NAME}
fi
