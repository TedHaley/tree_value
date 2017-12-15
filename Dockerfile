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

FROM rocker/tidyverse

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
        devtools ggmap ezknitr lubridate dplyr readr ggplot2 rgdal broom maptools gpclib packrat MASS scales stringr hexbin reshape2
