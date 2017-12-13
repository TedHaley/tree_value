# Driver Script
# Ted Haley Dec 2017
# Runs a Docker Container
#
##Usage
#To run the project:
#
#1. Open command line
#
#2. `git clone https://github.com/TedHaley/tree_value.git` :to the location of your choice 
#
#3. `docker pull teddyhaley/tree_value` :Pulls the docker image
#
#4. Example of running docker image:
#	`docker run -it --rm -v LocalDirectoryClonedRepo/:/home/tree_value teddyhaley/tree_value /#bin/bash`
#
#5. Change directory to make file:  
#`cd home/tree_value/`
#
#6. Prior to running, clean all existing files:  
#`make clean`
#   
#7. Run the project:  
#`make all`


# Using tidyverse Rocker image as a base
FROM rocker/tidyverse

#Install required packages
RUN apt-get update -qq \
    && apt-get -y --no-install-recommends install \
    liblzma-dev \
    libbz2-dev \
    clang  \
    ccache \
    default-jdk \
    default-jre \
    && R CMD javareconf \
    && install2.r --error \
        ezknitr lubridate dplyr readr ggmap ggplot2 rgdal broom maptools gpclib
  
