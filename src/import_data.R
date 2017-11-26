'
This script imports the public tree and land tax value datasets from data working file in the root
directory and prints the first 6 lines of data from each dataset.
'

#The data is taken from the city of Vancouver Website:
#http://data.vancouver.ca/datacatalogue/index.htm

library(tidyverse)

tree_data <- read.csv(file="../data/StreetTrees_CityWide.csv", header=TRUE, sep=",")
tax_data <- read.csv(file="../data/property_tax_report.csv", header=TRUE, sep=",")

print(head(tree_data))
print(head(tax_data))