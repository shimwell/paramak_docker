# build with the following command
# sudo docker build -t openmcworkshop/paramak_dependencies .

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
RUN apt-get install -y libosmesa6
RUN apt-get install -y libosmesa6-dev
RUN apt-get install -y libgles2-mesa-dev
