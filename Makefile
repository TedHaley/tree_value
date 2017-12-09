
# Driver script
# Ted Haley, Dec 2017
#
# Completes analysis Vancouver Land Value dataset in correlation to the Public Trees Dataset
#
# usage: make all

# run all analysis
all: doc/count_report.md

#file_to_create.png : data_it_depends_on.dat script_it_depends_on.py
#	python script_it_depends_on.py data_it_depends_on.dat file_to_create.png

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


#sumr_land_val_neigh
results/sumr_land_val_neigh.csv: results/tax_data_final.csv src/analyze_data.R
	Rscript src/analyze_data.R results/tax_data_final.csv results/sumr_land_val_neigh.csv


###############################
#Visualize Data
###############################

#create plot
results/figure/isles.png: results/isles.dat src/plotcount.py
	python src/plotcount.py results/isles.dat results/figure/isles.png
results/figure/abyss.png: results/abyss.dat src/plotcount.py
	python src/plotcount.py results/abyss.dat results/figure/abyss.png
results/figure/last.png: results/last.dat src/plotcount.py
	python src/plotcount.py results/last.dat results/figure/last.png
results/figure/sierra.png: results/sierra.dat src/plotcount.py
	python src/plotcount.py results/sierra.dat results/figure/sierra.png

# make count_report
doc/count_report.md: src/count_report.Rmd results/figure/isles.png results/figure/abyss.png results/figure/last.png results/figure/sierra.png
	Rscript -e 'ezknitr::ezknit("src/count_report.Rmd", out_dir = "doc")'

#Clean up intermediate files
clean:
	rm -f results/*.csv
	rm -f results/*.png
	rm -f doc/count_report.md 
	rm -f doc/count_report.html