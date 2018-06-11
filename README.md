## researchlab

You will find information to launch a docker with the necessary resources to start a python notebook.

The **goal** is to have a reproducible working environment.

Once the docker image is running you can open notebook saved locally.

### How to build and start the container?
You need to the run the script:
```
$path/researchlab/docker.sh
```
that will simply build the image or add modifications to existing docker image (e.g. to add a missing Python module) by calling the following docker command ``docker build . -t image_name``. Each time this command is ran, if the docker container is already active, it will ask you if you want to re-start it.


### How to stop the container?
Run the command:
```
$docker container ls
```
which should return the list of active docker containers:
```
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
49c44c77ed46        researchlab         "/bin/sh -c /researc…"   16 minutes ago      Up 16 minutes       8888/tcp            random_name
```
then do
```
$kill docker random_name
```

### How to open local notebook from notebook server on docker?
For now it can only run notebook saved where the docker image is created.

### How to import module saved locally?
TBD

### How to access data outside the docker container?
TBD

### How to delete all containers?
```
$docker rm $(docker ps -a -q)
```

### How to delete all images?
```
$docker rmi $(docker images -q)
```
