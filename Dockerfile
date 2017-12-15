# Driver Script
# Ted Haley Dec 2017
# Runs a Docker Container

#Usage:
# `git clone https://github.com/TedHaley/tree_value.git`
# `cd Path-To-Local-Repo/tree_value`
# `docker pull teddyhaley/tree_value`
# `docker run --rm -it -v /Path-To-Local-Repo/tree_value:/home/tree_value teddyhaley/tree_value /bin/bash`
# `cd home/tree_value/`
# `make clean`
# `make all`

# Using tidyverse Rocker image as a base
FROM rocker/tidyverse

RUN R -e "install.packages('devtools')"

RUN R -e "install.packages('ezknitr')"

RUN R -e "install.packages('lubridate')"

RUN R -e "install.packages('dplyr')"

RUN R -e "install.packages('readr')"

RUN R -e "install.packages('ggplot2')"

RUN R -e "install.packages('rgdal')"

RUN R -e "install.packages('broom')"

RUN R -e "install.packages('maptools')"

RUN R -e "install.packages('gpclib')"

RUN R -e "install.packages('packrat')"

RUN R -e "install.packages('MASS')"

RUN R -e "install.packages('scales')"

RUN R -e "install.packages('stringr')"

RUN R -e "install.packages('hexbin')"

RUN R -e "install.packages('reshape2')"

RUN R -e "install.packages('ggmap')"