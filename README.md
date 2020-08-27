# paramak_dependencies
This repository contains a dockerfile for use with continuous integration testing for the Paramak code.

The dockerfile is automatically rebuilt on dockerhub when changes are pushed to this repository (master branch)

To build dockerfile locally

```
sudo docker build -t openmcworkshop/paramak_dependencies . 


sudo docker run -it openmcworkshop/paramak_dependencies
```


The status of the automatic dockerhub build can be viewed [here](https://hub.docker.com/repository/docker/openmcworkshop/paramak_dependencies/general)
