#! /usr/bin/env Rscript
# import_data.R
# Ted Haley Dec, 2017

# This script imports the public tree and area datasets and wrangles them, selecting only the data required for the analysis.
# The two data sources are joined so they can be correlated to a map shape file.
# The results are then output into a new .csv file to be analyzed by the analyze_data.R script.

#The data is taken from the city of Vancouver Website:
#http://data.vancouver.ca/datacatalogue/index.htm

library(tidyverse)
library(lubridate)

tree_data <- read.csv(file="data/StreetTrees_CityWide.csv", header=TRUE, sep=",")
#tax_data <- read.csv(file="data/property_tax_report.csv", header=TRUE, sep=",")
shp_areas <- read.csv(file="data/local_area_boundary_shp/cov_localareas.csv", header=TRUE, sep=",")

tree_data_clean <- tree_data %>%
  select(TREE_ID, NEIGHBOURHOOD_NAME, DIAMETER, DATE_PLANTED, COMMON_NAME, LATITUDE, LONGITUDE) %>%
  group_by(NEIGHBOURHOOD_NAME) %>%
  arrange(NEIGHBOURHOOD_NAME) %>% 
  summarise()
 
tax_data_clean <- tax_data %>%  
  mutate(CHANGE_LV = CURRENT_LAND_VALUE, PREVIOUS_LAND_VALUE) %>% 
  select(NEIGHBOURHOOD_CODE, TAX_ASSESSMENT_YEAR, CURRENT_LAND_VALUE, CHANGE_LV) %>% 
  arrange(NEIGHBOURHOOD_CODE) %>%
  filter(TAX_ASSESSMENT_YEAR == 2016) %>%
  group_by(NEIGHBOURHOOD_CODE) %>%
  summarise()

shp_areas_clean <- shp_areas %>% 
  mutate(NAME = as.factor(toupper(NAME))) %>% 
  arrange(NAME)

(shp_areas_clean$NAME)
(tree_data_clean$NEIGHBOURHOOD_NAME)
(tax_data_clean$NEIGHBOURHOOD_CODE)




