# paramak dockerfiles

This repository contains a dockerfile for use distribution and continuous integration testing for the Paramak code.

These dockerfile is automatically rebuilt on dockerhub when changes are pushed to this repository (master branch)

There are several Dockerfile avaialbe, these include:

- Dockerfile includes all optional dependancies and the paramak package

- Dockerfile_dev includes all optional dependancies and the development branch of the paramak package

- Dockerfile_paramak_with_neutronics all optional dependancies, the paramak package and software needed for neutronics simulations

- Dockerfile_dependencies includes all optional dependancies for the paramak but not the paramak package itself, this is used for CI testing of the install procedure

- Dockerfile_dependencies_minimal includes main dependancies (not pymoab) but not the paramak package itself




To build dockerfile locally

```
sudo docker build -t openmcworkshop/paramak . 


sudo docker run -it openmcworkshop/paramak
```


The status of the automatic dockerhub build can be viewed [here](https://hub.docker.com/repository/docker/openmcworkshop/paramak_docker/general)
