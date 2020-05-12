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

Use `build.sh` or `build_interactive.sh` to build from source:
* Configure `build.sh` with your configuration and run `sh build.sh`.
__or __
* Run `build_interactive.sh` and follow the steps in the terminal accordingly.
* Both steps will automatically build the image from source and start the container. When using this some following steps can be ignored.

#### Initialize Container
With the help of the image a container can now be created with the following command:
```
docker run \
    -p 8080:8080 \
    -u `id -u root`:`id -g $USER` \
    --name <CONTAINER_NAME> \
    -v <LAREX_BOOK_DIR>:/home/books/ \
    -it <IMAGE_NAME>
```

Explanation of variables used above:
* `<CONTAINER_NAME>` - Name of the Docker container e.g. larex
* `<IMAGE_NAME>` - Name of the Docker image e.g. maxnth/larex
* `<LAREX_BOOK_DIR>` - Directory in which the books are located on your local machine

> **IMPORTANT**: The directory containing the books and all subdirectories and files MUST be fully accessible by the user `tomcat9`. 
Otherwise LAREX won't be able to read the book files and save changes.
>
> To test if this is the case, run `sudo -u tomcat9 test -r <LAREX_BOOK_DIR>; echo "$?"` and `sudo -u tomcat9 test -w <LAREX_BOOK_DIR>; echo "$?"`. 
If the output of both commands is `0` you're good to go.
>
> Otherwise you have to set the user rights via `sudo chown -R tomcat9:tomcat9 <LAREX_BOOK_DIR>`. 
The user access is often highly dependent on the current location in the filesystem and might not work everywhere as expected, even when granting the user rights to the book dir itself (as parent directories might not grant access to the specified user). 
Using the root directory or the home directory should work in most cases.

The container will be started by default after executing the `docker run` command.

If you want to start the container again later use `docker ps -a` to list all available containers with their Container IDs and then use `docker start <CONTAINER_NAME>` to start the desired container.

You can now access the project via following URL: http://localhost:8080/Larex/

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
