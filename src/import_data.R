#! /usr/bin/env Rscript
# import_data.R
# Ted Haley Dec, 2017

# This script imports the public tree and tax assessment datasets and wrangles them, selecting only the data required for the analysis.
# The two data sources are linked with NEIGHBOURHOOD_CODE_Converter so they can be correlated to a map shape file.
# The results are then output into a new .csv's to be analyzed by the analyze_data.R script.

# Usage: Rscript src/import_data.R

#The data is taken from the city of Vancouver Website:
#http://data.vancouver.ca/datacatalogue/index.htm

suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(lubridate))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(readr))

tree_data <- read.csv(file="data/StreetTrees_CityWide.csv", header=TRUE, sep=",")
tax_data <- read.csv(file="data/property_tax_report.csv", header=TRUE, sep=",")
shp_areas <- read.csv(file="data/local_area_boundary_shp/cov_localareas.csv", header=TRUE, sep=",")

#Wrangle data to include only the required information for the analysis
tree_data_clean <- tree_data %>%
  select(TREE_ID, NEIGHBOURHOOD_NAME, DIAMETER, DATE_PLANTED, COMMON_NAME, LATITUDE, LONGITUDE) %>% 
  mutate(DATE_PLANTED = substr(DATE_PLANTED, 0, 4)) 

#Replaces 0 coordinate with NA. NAs are ommited later in this script.
tree_data_clean[tree_data_clean == 0] <- NA

tax_data_clean <- tax_data %>%
  mutate(CHANGE_LV = round(((CURRENT_LAND_VALUE - PREVIOUS_LAND_VALUE)/(CURRENT_LAND_VALUE)), digits = 3)) %>%
  select(NEIGHBOURHOOD_CODE, CURRENT_LAND_VALUE, PREVIOUS_LAND_VALUE, CHANGE_LV)
tax_data_clean[tax_data_clean == 0] <- NA

shp_areas_clean <- shp_areas %>%
  mutate(NAME = as.factor(toupper(NAME))) %>%
  arrange(NAME)

#This data set provides a convertion between neighbourhood code and neighbourhood name. This information was extrapolated
#from postal codes in the tax dataset. They do not line up completely with the neighbourhoods provided by the city of Vancouver.
NEIGHBOURHOOD_CODE_Converter <- "
NEIGHBOURHOOD_CODE,   NEIGHBOURHOOD_NAME
1,                    WEST POINT GREY
2,                    KITSILANO
3,                    DUNBAR-SOUTHLANDS
4,                    ARBUTUS-RIDGE
5,                    KERRISDALE
6,                    KERRISDALE
7,                    FAIRVIEW
8,                    SHAUGHNESSY
9,                    SOUTH CAMBIE
10,                   OAKRIDGE
11,                   OAKRIDGE
12,                   MARPOLE
13,                   MOUNT PLEASANT
14,                   STRATHCONA
15,                   GRANDVIEW-WOODLAND
16,                   RILEY PARK
17,                   VICTORIA-FRASERVIEW
18,                   SUNSET
19,                   KENSINGTON-CEDAR COTTAGE
20,                   HASTINGS-SUNRISE
21,                   HASTINGS-SUNRISE
22,                   RENFREW-COLLINGWOOD
23,                   RENFREW-COLLINGWOOD
24,                   KILLARNEY
25,                   VICTORIA-FRASERVIEW
26,                   WEST END
27,                   DOWNTOWN
28,                   DOWNTOWN
29,                   DOWNTOWN
30,                   DOWNTOWN
"
NEIGHBOURHOOD_CODE_Converter <- read_csv(NEIGHBOURHOOD_CODE_Converter, trim_ws = TRUE, skip = 1)

#This joins the tax data and the neighbourhood name identifier
tax_data_clean_NC <- left_join(tax_data_clean, NEIGHBOURHOOD_CODE_Converter)

#This renames the titles so the dataset can be joined
names(shp_areas_clean) <- c("MAPID", "NEIGHBOURHOOD_NAME")

#This joins the shape file data and the neighbourhood code identifier
shp_areas_clean_NC <- left_join(shp_areas_clean, NEIGHBOURHOOD_CODE_Converter)

#Organize the data. Not essential, but makes it look nice
tree_data_final <- tree_data_clean  %>%
  arrange(NEIGHBOURHOOD_NAME)
tree_data_final <- na.omit(tree_data_final)

tax_data_final <- tax_data_clean_NC %>%
  arrange(NEIGHBOURHOOD_CODE) %>%
  filter(CHANGE_LV > -5)
tax_data_final <- na.omit(tax_data_final)

shp_areas_final <- shp_areas_clean_NC %>%
  arrange(NEIGHBOURHOOD_CODE)

#This outputs the cleaned and wrangled data into the results folder. Omits any rows where the data is missing.
write_csv(shp_areas_final, path = "results/shp_areas_final.csv")
write_csv(tax_data_final, path = "results/tax_data_final.csv")
write_csv(tree_data_final, path = "results/tree_data_final.csv")

