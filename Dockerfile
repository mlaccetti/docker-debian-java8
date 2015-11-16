###
# Building:
# $ docker build -t debian-java8 .
#
# Running:
# $ docker run --name my-debian-java8 -it --rm debian-java8

FROM debian:jessie

MAINTAINER Michael Laccetti <michael@laccetti.com> (https://laccetti.com/)

# Java 8
RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
RUN echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

# Gradle
RUN echo "deb http://ppa.launchpad.net/cwchien/gradle/ubuntu trusty main" | tee /etc/apt/sources.list.d/cwchien-gradle.list
RUN echo "deb-src http://ppa.launchpad.net/cwchien/gradle/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/cwchien-gradle.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 9D06AF36

# Update the container
RUN apt-get update --fix-missing && apt-get dist-upgrade -y

# Install Java 8/Gradle
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer oracle-java8-set-default gradle

# By default, just fire up a terminal
CMD /bin/bash