#! /usr/bin/env Rscript
# viz_data.R
# Ted Haley Dec, 2017

# This script takes the cleaned data from the results folder and performs various analyses on the data. 
# The goal of this script is to test the hypothesis that the size, age, and number of trees has a direct 
# effect on the value of land in the City of Vancouver.

# Usage: Rscript src/viz_data.R

suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggmap))
suppressPackageStartupMessages(library(sf))
suppressPackageStartupMessages(library(raster))
suppressPackageStartupMessages(library(maptools))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(rgdal))

tree_data <- read.csv(file="results/tree_data_final.csv", header=TRUE, sep=",")

van_shp <- readOGR(dsn = "data/local_area_boundary_shp/", layer = "local_area_boundary") %>% 
  spTransform(CRS("+proj=longlat +datum=WGS84"))
#overlay <- fortify(overlay, region="COMMUNITY")

location <- unlist(geocode('357 W King Edward Ave, Vancouver, BC V5Y 2J1'))+c(-0.01,-0.005)

gmap <- get_map(location=location, zoom = 12, maptype = "terrain", source = "google", col="bw")

van_shp_map <- ggmap(gmap) +
  geom_polygon(data=van_shp, aes(x=long, y=lat, group=group), color="red", alpha=0) +
  coord_map() +
  theme_bw()

van_shp_map




#head(tree_data)

# map <- get_map(location = 'Vancouver', zoom = 12)
# 
# mapPoints <- ggmap(map) +   
#   geom_point(aes(x = LONGITUDE, y = LATITUDE, size = DIAMETER), data = tree_data, alpha = 0.1)
# 
# mapPoints




# shp <- shapefile("data/local_area_boundary_shp/local_area_boundary.shp")
# plot(shp, col = "cyan1", border = "black", lwd = 3,
#      main = "AOI Boundary Plot")