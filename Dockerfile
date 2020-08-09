# build with the following command
# sudo docker build -f Dockerfile_openmc_dagmc -t openmcworkshop/paramak .
# build with the following command
# sudo docker build -t openmcworkshop/workshop_jupyter . --no-cache
# docker run -p 8888:8888 openmcworkshop/workshop_jupyter


FROM jupyter/minimal-notebook

# this is required to install programs on the base image
USER root

RUN apt-get --yes update && apt-get --yes upgrade

# required pacakges identified from openmc travis.yml
RUN apt-get --yes install mpich
RUN apt-get --yes install libmpich-dev
RUN apt-get --yes install libhdf5-serial-dev
RUN apt-get --yes install libhdf5-mpich-dev
RUN apt-get --yes install libblas-dev
RUN apt-get --yes install liblapack-dev

# needed to allow NETCDF on MOAB which helps with tet meshes in OpenMC
RUN apt-get --yes install libnetcdf-dev
# RUN apt-get --yes install libnetcdf13


RUN apt-get -y install sudo #  needed as the install NJOY script has a sudo make install command
RUN apt-get -y install git


# dependancies used in the workshop
RUN apt-get --yes install imagemagick
RUN apt-get --yes install hdf5-tools
RUN apt-get --yes install wget

USER $NB_USER

RUN pip install scikit-build
RUN pip install cmake

#RUN git clone https://github.com/ukaea/openmc_workshop


#ENV DAGMC_DIR=$HOME/DAGMC/
# MOAB Variables
ENV MOAB_BRANCH='Version5.1.0'
ENV MOAB_REPO='https://bitbucket.org/fathomteam/moab/'
ENV MOAB_INSTALL_DIR=$HOME/MOAB/

# DAGMC Variables
ENV DAGMC_BRANCH='develop'
ENV DAGMC_REPO='https://github.com/svalinn/dagmc'
ENV DAGMC_INSTALL_DIR=$HOME/DAGMC/

# MOAB Install
RUN cd $HOME && \
    mkdir MOAB && \
    cd MOAB && \
    git clone -b $MOAB_BRANCH $MOAB_REPO  && \
    mkdir build && cd build && \
    cmake ../moab -DENABLE_HDF5=ON -DENABLE_MPI=off -DENABLE_NETCDF=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=$MOAB_INSTALL_DIR && \
    make -j8 &&  \
    make -j8 install  && \
    cmake ../moab -DBUILD_SHARED_LIBS=OFF && \
    make -j8 install && \
    rm -rf $HOME/MOAB/moab $HOME/MOAB/build

# # # pyrender install version 2.0-dev which breaks in docker
# RUN pip uninstall pyglet 
# # # this installs version 1.48 which works in docker
# RUN pip install pyglet

# # Anaconda installing
# RUN wget https://repo.continuum.io/archive/Anaconda3-2020.02-Linux-x86_64.sh

# RUN bash Anaconda3-2020.02-Linux-x86_64.sh -b

# RUN rm Anaconda3-2020.02-Linux-x86_64.sh

# # Set path to conda
# ENV PATH /root/anaconda3/bin:$PATH

# RUN conda install -c conda-forge -c cadquery cadquery=2
RUN conda create --name cq python=3.7
RUN conda install -c conda-forge -c cadquery cadquery=master
USER root