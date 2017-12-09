
# Driver script
# Ted Haley, Dec 2017
#
# Completes analysis Vancouver Land Value dataset in correlation to the Public Trees Dataset
#
# usage: make all

###############################
#Usage: `make all`
#
#After every run, use `make clean`
###############################

all: doc/tree_val_report.md

###############################
#Import and Wrangle Data
###############################


#Shape Data
results/shp_areas_final.csv: data/local_area_boundary_shp/cov_localareas.csv src/import_data.R
	Rscript src/import_data.R data/local_area_boundary_shp/cov_localareas.csv results/shp_areas_final.csv


#Tax Data
results/tax_data_final.csv: data/property_tax_report.csv src/import_data.R
	Rscript src/import_data.R data/property_tax_report.csv results/tax_data_final.csv


#Tree Data
results/tree_data_final.csv: data/StreetTrees_CityWide.csv src/import_data.R
	Rscript src/import_data.R data/StreetTrees_CityWide.csv results/tree_data_final.csv


###############################
#Analyze Data
###############################


#sumr_land_val_neigh
results/sumr_land_val_neigh.csv: results/tax_data_final.csv src/analyze_data.R
	Rscript src/analyze_data.R results/tax_data_final.csv results/sumr_land_val_neigh.csv


#sumr_most_common
results/sumr_most_common.csv: results/tree_data_final.csv src/analyze_data.R
	Rscript src/analyze_data.R results/tree_data_final.csv results/sumr_most_common.csv


#sumr_neigh_yr_planted
results/sumr_neigh_yr_planted.csv: results/tree_data_final.csv src/analyze_data.R
	Rscript src/analyze_data.R results/tree_data_final.csv results/sumr_neigh_yr_planted.csv


#sumr_tree_size_neigh
results/sumr_tree_size_neigh.csv: results/tree_data_final.csv src/analyze_data.R
	Rscript src/analyze_data.R results/tree_data_final.csv results/sumr_tree_size_neigh.csv


#sumr_tree_size_type
results/sumr_tree_size_type.csv: results/tree_data_final.csv src/analyze_data.R
	Rscript src/analyze_data.R results/tree_data_final.csv results/sumr_tree_size_type.csv


#sumr_tree_type_neigh
results/sumr_tree_type_neigh.csv: results/tree_data_final.csv src/analyze_data.R
	Rscript src/analyze_data.R results/tree_data_final.csv results/sumr_tree_type_neigh.csv


###############################
#Visualize Data
###############################


#tax_val_map.png
results/tax_val_map.png: results/sumr_land_val_neigh.csv data/local_area_boundary_shp/local_area_boundary.shp src/viz_data.R
	Rscript src/viz_data.R results/sumr_land_val_neigh.csv data/local_area_boundary_shp/local_area_boundary.shp results/tax_val_map.png


#tax_val_ch_map.png
results/tax_val_ch_map.png: results/sumr_land_val_neigh.csv data/local_area_boundary_shp/local_area_boundary.shp src/viz_data.R
	Rscript src/viz_data.R results/sumr_land_val_neigh.csv data/local_area_boundary_shp/local_area_boundary.shp results/tax_val_ch_map.png


#tree_count_map.png
results/tree_count_map.png: results/sumr_tree_size_neigh.csv data/local_area_boundary_shp/local_area_boundary.shp src/viz_data.R
	Rscript src/viz_data.R results/sumr_tree_size_neigh.csv data/local_area_boundary_shp/local_area_boundary.shp results/tree_count_map.png


#tree_dia_map.png
results/tree_dia_map.png: results/sumr_neigh_yr_planted.csv data/local_area_boundary_shp/local_area_boundary.shp src/viz_data.R
	Rscript src/viz_data.R results/sumr_neigh_yr_planted.csv data/local_area_boundary_shp/local_area_boundary.shp results/tree_dia_map.png


#tree_val_ch_plot.png
results/tree_val_ch_plot.png: results/sumr_land_val_neigh.csv results/sumr_neigh_yr_planted.csv src/viz_data.R
	Rscript src/viz_data.R results/sumr_land_val_neigh.csv results/sumr_neigh_yr_planted.csv results/tree_val_ch_plot.png


#tree_val_plot.png
results/tree_val_plot.png: results/sumr_land_val_neigh.csv results/sumr_neigh_yr_planted.csv src/viz_data.R
	Rscript src/viz_data.R results/sumr_land_val_neigh.csv results/sumr_neigh_yr_planted.csv results/tree_val_plot.png


#lm_tree.csv
results/lm_tree.csv: results/sumr_land_val_neigh.csv results/sumr_neigh_yr_planted.csv src/viz_data.R
	Rscript src/viz_data.R results/sumr_land_val_neigh.csv results/sumr_neigh_yr_planted.csv results/lm_tree.csv


###############################
#Compile Report
###############################


doc/tree_val_report.md: src/tree_val_report.Rmd results/tax_val_map.png results/tax_val_ch_map.png results/tree_count_map.png results/tree_dia_map.png results/tree_val_ch_plot.png results/tree_val_plot.png results/lm_tree.csv
	Rscript -e 'ezknitr::ezknit("src/tree_val_report.Rmd", out_dir = "doc")'


###############################
#Clean the data
###############################

clean:
	rm -f results/*.csv
	rm -f results/*.png
	rm -f doc/tree_val_report.md 
	rm -f doc/tree_val_report.html