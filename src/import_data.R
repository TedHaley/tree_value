'
This script imports the public tree and land tax value datasets from data working file in the root
directory and prints the first 6 lines of data from each dataset.
'

#The data is taken from the city of Vancouver Website:
#http://data.vancouver.ca/datacatalogue/index.htm

library(sf)
library(raster)
library(tidyverse)

#shape <- readOGR(dsn = "../data/local_area_boundary_shp/local_area_boundary.shp", layer = "SHAPEFILE")
tree_data <- read.csv(file="../data/StreetTrees_CityWide.csv", header=TRUE, sep=",")
tax_data <- read.csv(file="../data/property_tax_report.csv", header=TRUE, sep=",")

shp <- shapefile("../data/local_area_boundary_shp/local_area_boundary.shp")
shape2 <- st_read("../data/local_area_boundary_shp/local_area_boundary.shp")

tree_data_clean <- tree_data %>% 
  select(TREE_ID, NEIGHBOURHOOD_NAME, DIAMETER, DATE_PLANTED, COMMON_NAME, LATITUDE, LONGITUDE)

tax_data_clean <- tax_data %>% 
  select(PID, PROPERTY_POSTAL_CODE, NEIGHBOURHOOD_CODE, TAX_ASSESSMENT_YEAR, CURRENT_LAND_VALUE, PREVIOUS_LAND_VALUE)

plot(shp, col = "cyan1", border = "black", lwd = 3,
     main = "AOI Boundary Plot")


print(head(tree_data_clean))
print(head(tax_data_clean))