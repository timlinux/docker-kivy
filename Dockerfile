#--------- Generic stuff all our Dockerfiles should start with so we get caching ------------
FROM ubuntu:12.04
MAINTAINER Tim Sutton<tim@linfiniti.com>

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive
RUN  dpkg-divert --local --rename --add /sbin/initctl
#RUN  ln -s /bin/true /sbin/initctl

# Use local cached debs from host (saves your bandwidth!)
# Change ip below to that of your apt-cacher-ng host
# Or comment this line out if you do not with to use caching
ADD 71-apt-cacher-ng /etc/apt/apt.conf.d/71-apt-cacher-ng

#RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
RUN apt-get -y update

#-------------Application Specific Stuff ----------------------------------------------------
# Based on Dockerfile by Dmitry Kurilov
# at https://github.com/dmkurilov/docker-kivy-pricise

# Add i386 architecture
#RUN echo 'foreign-architecture i386' > /etc/dpkg/dpkg.cfg.d/multiarch
# Ubuntu > 12.04 can do this rather
#RUN dpkg --add-architecture i386

RUN  apt-get install -y build-essential mercurial git python2.7 \
  python-setuptools python-dev ffmpeg \
  libsdl-image1.2-dev libsdl-mixer1.2-dev \
  libsdl-ttf2.0-dev libsmpeg-dev libsdl1.2-dev \
  libportmidi-dev libswscale-dev libavformat-dev \
  libavcodec-dev zlib1g-dev wget curl
  

# Bootstrap a current Python environment
RUN apt-get remove --purge -y python-virtualenv python-pip
RUN easy_install-2.7 -U pip
RUN pip2.7 install -U virtualenv

# Install current version of Cython
RUN apt-get remove --purge -y cython
RUN pip2.7 install -U cython

# Install other PyGame dependencies
RUN apt-get remove --purge -y python-numpy
RUN pip2.7 install -U numpy

# Install PyGame
RUN apt-get remove --purge python-pygame
RUN hg clone https://bitbucket.org/pygame/pygame
RUN cd pygame && python2.7 setup.py build && python2.7 setup.py install && cd .. && rm -rf pygame
