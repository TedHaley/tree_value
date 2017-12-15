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

# Using tidyverse Rocker image as a base
FROM rocker/tidyverse

RUN Rscript -e "install.packages('devtools')"

RUN Rscript -e "install.packages('ezknitr')"

RUN Rscript -e "install.packages('lubridate')"

RUN Rscript -e "install.packages('dplyr')"

RUN Rscript -e "install.packages('readr')"

RUN Rscript -e "install.packages('ggplot2')"

RUN Rscript -e "install.packages('broom')"

RUN Rscript -e "install.packages('gpclib')"

RUN Rscript -e "install.packages('packrat')"

RUN xvfb-run -a install.r \ 
                ggmap \
     		maptools \
      		rgdal \