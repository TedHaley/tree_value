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
#3. `docker run --rm -v LocalDirectoryClonedRepo/tree_value:/home/tree_value teddyhaley/tree_value make -C '/home/analysis' clean`
#
#4. `make all`

# Using tidyverse Rocker image as a base
FROM rocker/tidyverse

# then install required packages

RUN Rscript -e "install.packages('ezknitr', repos = 'https://mran.revolutionanalytics.com/snapshot/2017-12-11')"

RUN Rscript -e "install.packages('lubridate', repos = 'https://mran.revolutionanalytics.com/snapshot/2017-12-11')"

RUN Rscript -e "install.packages('readr', repos = 'https://mran.revolutionanalytics.com/snapshot/2017-12-11')"

RUN Rscript -e "install.packages('packrat', repos = 'https://mran.revolutionanalytics.com/snapshot/2017-12-11')"

RUN Rscript -e "install.packages('ggmap', repos = 'https://mran.revolutionanalytics.com/snapshot/2017-12-11')"

RUN Rscript -e "install.packages('ggplot2', repos = 'https://mran.revolutionanalytics.com/snapshot/2017-12-11')"

RUN Rscript -e "install.packages('rgdal', repos = 'https://mran.revolutionanalytics.com/snapshot/2017-12-11')"

RUN Rscript -e "install.packages('broom', repos = 'https://mran.revolutionanalytics.com/snapshot/2017-12-11')"

RUN Rscript -e "install.packages('maptools', repos = 'https://mran.revolutionanalytics.com/snapshot/2017-12-11')"

RUN Rscript -e "install.packages('gpclib', repos = 'https://mran.revolutionanalytics.com/snapshot/2017-12-11')"