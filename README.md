## research-lab

You will find information to launch a docker with the necessary resources to start a python notebook.

Once the docker image is running you can open notebook saved locally.

### How to build the container?
```
$docker build -t researchlab .
```

### How to start the docker?
```
$~/workspace/research-lab/docker.sh
$docker run -ti -v /home/jeremie/workspace/oled-power/python/python-notebook:/notebooks -p 8888:8888 researchlab
```

### How to open local notebook from notebook server on docker?
Check above.

### How to import module saved locally?

### How to access data outside the docker container?

### How to delete all containers?
```
$docker rm $(docker ps -a -q)
```

### How to delete all images?
```
$docker rmi $(docker images -q)
```
