# LAREX Docker
Docker image for [LAREX](https://github.com/OCR4all/LAREX)

## Getting Started

These instructions will get you a [Docker container](https://www.docker.com/what-container) that runs LAREX

### Prerequisites

[Docker](https://www.docker.com) (for installation instructions see the [Official Installation Guide](https://docs.docker.com/install/))

### Installing

#### Get the Docker Image
From Docker Hub:
* Execute the following command ```docker pull maxnth/larex```

or

From Source:
* Clone this repository first and enter the cloned directory with a command line tool.

* Execute the following command inside the directory: ``` docker build -t <IMAGE_NAME> . ``` 

__or__

Use `build_template.sh` or `build_interactive.sh` to build from source:
* Copy `build_template.sh` to e.g. `build_local.sh`, customize the configuration and run `sh build_local.sh`.

    __or__

* Run `sh build_interactive.sh` and follow the steps in the terminal accordingly.
* Both steps will automatically build the image from source and start the container. When using this some following steps can be ignored.

#### Initialize Container
With the help of the image a container can now be created with the following command:
```
docker run \
    -p 8080:8080 \
    --name <CONTAINER_NAME> \
    -v <CUSTOM_CONFIG_FILE>:/larex.config \
    -v <LAREX_BOOK_DIR>:/home/books/ \
    -it <IMAGE_NAME>
```

Explanation of variables used above:
* `<CONTAINER_NAME>` - Name of the Docker container e.g. larex
* `<IMAGE_NAME>` - Name of the Docker image e.g. maxnth/larex
* `<CUSTOM_CONFIG_FILE>` - Custom larex.config file (a template is included in this repository). Changes to the larex.config will be effective after restarting the docker container (in case one is already running). **`bookpath` should not get changed in the larex.config but only via volumes!**
* `<LAREX_BOOK_DIR>` - Directory in which the books are located on your local machine

The container will be started by default after executing the `docker run` command.

If you want to start the container again later use `docker ps -a` to list all available containers with their Container IDs and then use `docker start <CONTAINER_NAME>` to start the desired container.

You can now access the project via following URL: `http://localhost:<Port>/Larex/`

### Updating
#### From Docker Hub:

Updating the image can easily be done via the docker hub if the image has been previously pulled from the docker hub.

The following command will update the image:
```
docker pull maxnth/larex
```

#### From Source:

To update the source code of the project you currently need to reinstall the image.

This can be achieved with executing the following command first:
```
docker image rm <IMAGE_NAME>
```
Afterwards you can follow the installation guide above as it is a new clean installation.
