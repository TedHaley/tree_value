# Driver Script
# Ted Haley Dec 2017
# Runs a Docker Container

#Usage:
# `cd Path-To-Local-Repo/tree_value`
# `git clone https://github.com/TedHaley/tree_value.git`
# `docker pull teddyhaley/tree_value`
# `docker run --rm -it -v /Path-To-Local-Repo/tree_value:/home/tree_value teddyhaley/tree_value /bin/bash`
# `cd home/tree_value/`
# `make clean`
# `make all`

#REQUIREMENTS:
#1.install_packages.R
#2.R_packages.txt

# THE FOLLOWING WAS ADAPTED FROM: https://github.com/achubaty

FROM rocker/rstudio:latest

#fetch CRAN packages
RUN gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys E084DAB9 && \
    gpg -a --export E084DAB9 | apt-key add -

#Fetch Java key
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886

# Adding Fiocruz repository
RUN /bin/echo -e '\n## Fiocruz CRAN repository\ndeb http://cran.fiocruz.br/bin/linux/ubuntu trusty/' >> /etc/apt/sources.list

# Adding Webupd8 repository
RUN /bin/echo -e 'deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main\ndeb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main' >> /etc/apt/sources.list.d/webupd8team-java.list

# Accepting Java license
RUN /bin/echo "oracle-java8-installer shared/accepted-oracle-license-v1-1 select true" | /usr/bin/debconf-set-selections

RUN apt-get update && apt-get install -y \
    r-base \
    wget \
    gdebi-core \
    subversion \
    libgdal-dev \
    libproj-dev \
    libcurl4-gnutls-dev \
    oracle-java8-installer

RUN R CMD javareconf

# Install R packages from install script 
WORKDIR /tmp/
ADD install_packages.R /tmp/
ADD R_packages.txt /tmp/
RUN R -e "source('install_packages.R')"
RUN rm install_packages.R R_packages.txt

# Configuring R to use installed Oracle Java
RUN R CMD javareconf
