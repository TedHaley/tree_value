#! /usr/bin/env Rscript
# viz_data.R
# Ted Haley Dec, 2017

# This script takes the cleaned data and the summarized data from the results folder and makes visualizatons from the data.
# The results from the analysis will be displayed using various graphs, plots, and maps.

# Usage: Rscript src/viz_data.R
library(devtools)
library(tidyverse)
library(ggmap)
library(ggplot2)
library(rgdal)
library(broom)
library(maptools)
library(gpclib)
library(lubridate)
library(dplyr)
library(readr)

require(ggmap)
require(gpclib)

require(c("gpclib", "maptools"))
if (!require(gpclib)) install.packages("gpclib", type="source")
gpclibPermit()


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

#Set map centre location
location <- unlist(geocode('357 W King Edward Ave, Vancouver, BC V5Y 2J1'))+c(-0.01,-0.005)
gmap <- get_map(location=location, zoom = 12, col="bw")

# land_val_neigh on the map
land_val_neigh_map <- left_join(key, sumr_land_val_neigh)

#plot mean land value on map by neighbourhood
tax_val_map <- ggmap(gmap) + 
  geom_polygon(aes(fill = mean_lv, x = long, y = lat, group = group), 
               data = land_val_neigh_map,
               alpha = 0.8, 
               color = "black",
               size = 0.2) +
  xlab("Longitude") + 
  ylab("Latitude") +
  ggtitle("Mean Land Value by neighbourhood") +
  scale_fill_continuous(name = "Land Value ($)") 

# Save tax_val_map.png
ggsave(filename = 'tax_val_map.png', plot = tax_val_map, device = 'png', path = 'results/')

#plot mean land value change on map by neighbourhood
tax_val_ch_map <- ggmap(gmap) + 
  geom_polygon(aes(fill = mean_ch, x = long, y = lat, group = group), 
               data = land_val_neigh_map,
               alpha = 0.8, 
               color = "black",
               size = 0.2) +
  xlab("Longitude") + 
  ylab("Latitude") +
  ggtitle("Mean Land Value Change \nby neighbourhood (2015-2016)") +
  scale_fill_continuous(name = "Land Value \nChange (%)") 

# Save tax_val_map.png
ggsave(filename = 'tax_val_ch_map.png', plot = tax_val_ch_map, device = 'png', path = 'results/')

# tree_size_neigh on the map
tree_size_neigh_map <- left_join(key, sumr_tree_size_neigh)

#plot tree diamater on map by neighbourhood
tree_dia_map <- ggmap(gmap) + 
  geom_polygon(aes(fill = mean_dia, x = long, y = lat, group = group), 
               data = tree_size_neigh_map,
               alpha = 0.8, 
               color = "black",
               size = 0.2) +
  xlab("Longitude") + 
  ylab("Latitude") +
  ggtitle("Mean tree diameter \nby neighbourhood") +
  scale_fill_continuous(name = "Tree Diameter")

# Save tree_dia_map.png
ggsave(filename = 'tree_dia_map.png', plot = tree_dia_map, device = 'png', path = 'results/')

# tree_size_neigh on the map
neigh_yr_planted_map <- left_join(key, sumr_neigh_yr_planted)

#plot tree diamater on map by neighbourhood
tree_count_map <- ggmap(gmap) + 
  geom_polygon(aes(fill = count, x = long, y = lat, group = group), 
               data = neigh_yr_planted_map,
               alpha = 0.8, 
               color = "black",
               size = 0.2) +
  xlab("Longitude") + 
  ylab("Latitude") +
  ggtitle("Number of trees planted by \nneighbourhood since 2015") +
  scale_fill_continuous(name = "Number of Trees")

# Save tree_dia_map.png
ggsave(filename = 'tree_count_map.png', plot = tree_count_map, device = 'png', path = 'results/')

# Join number of trees and land value change dataset
tree_val_df <- left_join(sumr_land_val_neigh, sumr_neigh_yr_planted)

#plot mean land value against trees planted
tree_val_plot <- ggplot(data = tree_val_df, aes(y = mean_lv, x = count)) +
  geom_point(alpha = 0.5, aes(color = NEIGHBOURHOOD_NAME)) +
  geom_smooth(method = "lm") +
  ylab("Mean land value ($)") + 
  xlab("Trees Planted since 2015") + 
  scale_y_continuous(name = "Mean land value ($)",labels=scales::dollar_format()) +
  guides(color=FALSE)

# Save tree_val_plot.png
ggsave(filename = 'tree_val_plot.png', plot = tree_val_plot, device = 'png', path = 'results/')

tree_val_ch_plot <- ggplot(data = tree_val_df, aes(y = mean_ch, x = count)) +
  geom_point(alpha = 0.5, aes(color = NEIGHBOURHOOD_NAME)) +
  geom_smooth(method = "lm") +
  ylab("Mean land value change (2015-2016)") + 
  xlab("Trees Planted since 2015") + 
  guides(color=FALSE)

# Save tree_val_ch_plot.png
ggsave(filename = 'tree_val_ch_plot.png', plot = tree_val_ch_plot, device = 'png', path = 'results/')

#Linear model to check correlation between trees planted and change in land value
lm_tree <- as.data.frame(tidy(summary(lm(mean_ch~count,data=tree_val_df)))) 
write_csv(lm_tree, path = "results/lm_tree.csv")