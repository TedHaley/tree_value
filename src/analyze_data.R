#! /usr/bin/env Rscript
# analyze_data.R
# Ted Haley Dec, 2017

# This script takes the cleaned data from the results folder and performs various analyses on the data. 
# The goal of this script is to test the hypothesis that the size, age, and number of trees has a direct 
# effect on the value of land in the City of Vancouver.

# Usage: Rscript src/analyze_data.R

#import packages
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

#Read the clean data
tree_data <- read.csv(file="results/tree_data_final.csv", header=TRUE, sep=",")
tax_data <- read.csv(file="results/tax_data_final.csv", header=TRUE, sep=",")
shp_areas <- read.csv(file="results/shp_areas_final.csv", header=TRUE, sep=",")

#Tree analysis
#Tree size by neighborhood
tree_size_neigh <- tree_data %>% 
  select(NEIGHBOURHOOD_NAME, DIAMETER) %>% 
  group_by(NEIGHBOURHOOD_NAME) %>% 
  summarise(mean_dia = mean(DIAMETER), count = n()) %>% 
  arrange(desc(mean_dia))

#Tree size by tree type
tree_size_type <- tree_data %>% 
  select(COMMON_NAME, DIAMETER) %>% 
  group_by(COMMON_NAME) %>% 
  summarise(mean_dia = mean(DIAMETER), count = n()) %>% 
  arrange(desc(count))

#Tree type by neighborhood
tree_type_neigh <- tree_data %>% 
  select(NEIGHBOURHOOD_NAME, COMMON_NAME) %>% 
  group_by(NEIGHBOURHOOD_NAME, COMMON_NAME) %>% 
  summarise(count = n())%>% 
  arrange(desc(count))

#Most common trees
most_common <- tree_data %>% 
  select(COMMON_NAME) %>% 
  group_by(COMMON_NAME) %>% 
  summarise(count = n()) %>% 
  arrange(desc(count))

#Year the tree was planted by neighborhood: Trees planted since 2014
neigh_yr_planted <- tree_data %>%
  select(NEIGHBOURHOOD_NAME, DATE_PLANTED) %>%
  mutate(year = as.integer(DATE_PLANTED)) %>%
  filter(year > 2014) %>% 
  group_by(NEIGHBOURHOOD_NAME) %>%
  summarise(count=n()) %>% 
  arrange(NEIGHBOURHOOD_NAME)

#Tax analysis
#Mean land value by neighborhood by year
land_val_neigh<- tax_data %>%
  select(NEIGHBOURHOOD_NAME, CURRENT_LAND_VALUE, PREVIOUS_LAND_VALUE, CHANGE_LV) %>%
  group_by(NEIGHBOURHOOD_NAME) %>%
  summarise(mean_lv = mean(CURRENT_LAND_VALUE), mean_pr_lv = mean(PREVIOUS_LAND_VALUE), mean_ch = ((mean_lv-mean_pr_lv)/(mean_pr_lv)),count = n()) %>%
  arrange(desc(mean_ch))

#This outputs the modified data to the results folder
write_csv(tree_size_neigh, path = "results/sumr_tree_size_neigh.csv")
write_csv(tree_size_type, path = "results/sumr_tree_size_type.csv")
write_csv(tree_type_neigh, path = "results/sumr_tree_type_neigh.csv")
write_csv(most_common, path = "results/sumr_most_common.csv")
write_csv(neigh_yr_planted, path = "results/sumr_neigh_yr_planted.csv")
write_csv(land_val_neigh, path = "results/sumr_land_val_neigh.csv")

