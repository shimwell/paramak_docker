# build with the following command
# sudo docker build -f Dockerfile_openmc_dagmc -t openmcworkshop/paramak .

FROM ubuntu:18.04

# Updating Ubuntu packages
RUN apt-get update && yes|apt-get upgrade

# Adding wget and bzip2
RUN apt-get install -y wget bzip2

# Anaconda installing
RUN wget https://repo.continuum.io/archive/Anaconda3-2020.02-Linux-x86_64.sh

RUN bash Anaconda3-2020.02-Linux-x86_64.sh -b

RUN rm Anaconda3-2020.02-Linux-x86_64.sh

# Set path to conda
ENV PATH /root/anaconda3/bin:$PATH

RUN conda install -c conda-forge -c cadquery cadquery=2

RUN apt-get update
RUN apt-get install -y libgl1-mesa-dev 
RUN apt-get install -y libglu1-mesa-dev
RUN apt-get install -y freeglut3-dev

# pyrender install version 2.0-dev which breaks in docker
RUN pip uninstall pyglet 
# this installs version 1.48 which works in docker
RUN pip install pyglet
