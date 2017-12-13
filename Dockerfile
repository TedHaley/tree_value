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

# then install the ezknitr packages
RUN Rscript -e "install.packages('ezknitr', repos = 'http://cran.us.r-project.org')"

RUN R -e "install.packages('lubridate')"

RUN R -e "install.packages('dplyr')"

RUN R -e "install.packages('readr')"

RUN R -e "install.packages('ggmap')"

RUN R -e "install.packages('ggplot2')"

RUN R -e "install.packages('rgdal')"

RUN R -e "install.packages('broom')"

RUN R -e "install.packages('maptools')"

RUN R -e "install.packages('gpclib')"
  
