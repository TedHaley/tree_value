# Driver Script
# Ted Haley Dec 2017
# Runs a Docker Container
#
##Usage
#To run the project:

#1. Open command line

#2. `git clone https://github.com/TedHaley/tree_value.git` :to the location of your choice
 
#3. Replace `/Users/Teddy/MDS/tree_value` with the location of where you saved the repo: `docker run --rm -v /Users/Teddy/MDS/tree_value:/home/tree_value teddyhaley/tree_value make -C '/home/tree_value' clean`

#4. Replace `/Users/Teddy/MDS/tree_value` with the location of where you saved the repo: `docker run --rm -v /Users/Teddy/MDS/tree_value:/home/tree_value teddyhaley/tree_value make -C 'home/tree_value' all`

# Using tidyverse Rocker image as a base
FROM rocker/tidyverse

# then install required packages
#library(tidyverse)
#library(ggmap)
#library(ggplot2)
#library(rgdal)
#library(broom)
#library(maptools)
#library(gpclib)
#library(lubridate)
#library(dplyr)
#library(readr)

RUN Rscript -e "install.packages('ezknitr', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "install.packages('lubridate', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "install.packages('readr', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "install.packages('packrat', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "install.packages('ggmap', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "install.packages('ggplot2', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "install.packages('rgdal', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "install.packages('broom', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "install.packages('maptools', repos = 'http://cran.us.r-project.org')"

RUN Rscript -e "install.packages('gpclib', rrepos = 'http://cran.us.r-project.org')"

RUN Rscript -e "install.packages('dplyr', repos = 'http://cran.us.r-project.org')"