'
This script takes polling station locations and crime data from the city of Vancouver website.
The purpose of this analysis is to test the hypothesis that areas with increased crime rate
have less polling stations.
'

library(sf)
library(raster)

shape <- readOGR(dsn = "../data/local_area_boundary_shp/local_area_boundary.shp", layer = "SHAPEFILE")

shp <- shapefile("data/local_area_boundary_shp/local_area_boundary.shp")
shape2 <- st_read("data/local_area_boundary_shp/local_area_boundary.shp")

plot(shp, col = "cyan1", border = "black", lwd = 3,
     main = "AOI Boundary Plot")
