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

# Install R packages from install script 
WORKDIR /tmp/
ADD install_packages.R /tmp/
ADD R_packages.txt /tmp/
RUN R -e "source('install_packages.R')"
RUN rm install_packages.R R_packages.txt

