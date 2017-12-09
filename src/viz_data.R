#! /usr/bin/env Rscript
# viz_data.R
# Ted Haley Dec, 2017

# This script takes the cleaned data and the summarized data from the results folder and makes visualizatons from the data.
# The results from the analysis will be displayed using various graphs, plots, and maps.

# Usage: Rscript src/viz_data.R

suppressPackageStartupMessages(library(tidyverse))
suppressPackageStartupMessages(library(ggmap))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(rgdal))

# Import clean data
tree_data <- read.csv(file="results/tree_data_final.csv", header=TRUE, sep=",")
tax_data <- read.csv(file="results/tax_data_final.csv", header=TRUE, sep=",")
shp_areas <- read.csv(file="results/shp_areas_final.csv", header=TRUE, sep=",")

# Import summarized data from analysis
sumr_tree_size_neigh <- read.csv(file="results/sumr_tree_size_neigh.csv", header=TRUE, sep=",")
sumr_tree_size_type <- read.csv(file="results/sumr_tree_size_type.csv", header=TRUE, sep=",")
sumr_tree_type_neigh <- read.csv(file="results/sumr_tree_type_neigh.csv", header=TRUE, sep=",")
sumr_most_common <- read.csv(file="results/sumr_most_common.csv", header=TRUE, sep=",")
sumr_neigh_yr_planted <- read.csv(file="results/sumr_neigh_yr_planted.csv", header=TRUE, sep=",")
sumr_land_val_neigh <- read.csv(file="results/sumr_land_val_neigh.csv", header=TRUE, sep=",")

# Import Vancouver shapefile
van_shp <- readOGR(dsn = "data/local_area_boundary_shp/", layer = "local_area_boundary") %>% 
  spTransform(CRS("+proj=longlat +datum=WGS84"))

# Makes shape file into a dataframe
van_shp_fort <- van_shp %>% 
  fortify(region = 'MAPID')

names(shp_areas) <- c("id", "NEIGHBOURHOOD_NAME", "NEIGHBOURHOOD_CODE")

#This joins the shape file data and the neighbourhood code identifier: This is the KEY between datasets
key <- left_join(van_shp_fort, shp_areas)

# tree_size_neigh on the map
tree_size_neigh_map <- left_join(key, sumr_tree_size_neigh)

g <- ggplot(tree_size_neigh_map, aes(long, lat, group = group)) + 
  geom_polygon(aes(fill = mean_dia))

g
# 
# van_hoods  = merge(van_shp_fort, van_shp@data, by.x = 'id', by.y = 'ZIP_CODE')
#sf = merge(SFNeighbourhoods, values, by.x='id')
#sf %>% group_by(id) %>% do(head(., 1)) %>% head(10)

# 
# names(van_shp)
# head(van_shp)

# location <- unlist(geocode('357 W King Edward Ave, Vancouver, BC V5Y 2J1'))+c(-0.01,-0.005)
# 
# gmap <- get_map(location=location, zoom = 12, maptype = "terrain", source = "google", col="bw")
# 
# van_shp_map <- ggmap(gmap) +
#   geom_polygon(data=van_shp, aes(x=long, y=lat, group=group), color="red", alpha=0) +
#   coord_map() +
#   theme_bw()
# 
# van_shp_map



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