'
This script imports the public tree and land tax value from the city of Vancouver website.
'

#The data is taken from the city of Vancouver Website:
#http://data.vancouver.ca/datacatalogue/index.htm


voting_data <- read.csv(file="../data/voting_places_2017.csv", header=TRUE, sep=",")
crime_data <- read.csv(file="../data/crime_csv_all_years.csv", header=TRUE, sep=",")

head(voting_data)
head(crime_data)