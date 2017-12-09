#Land Value and Public Trees

#### Created by: Teddy Haley

##About
This project analyzes the correlation between land value in the City of Vancouver and public trees. 

##Usage
To run the project:

1. In the command line, navigate to the root directory of the `tree_value` repository:  
`cd ~/tree_value/`
2. In the command line in the root directory, run the complete project:  
`make all`   
3. After running the project, remove all generated files using:  
`make clean`

##Data
The datasets used in this analysis are provided by the City of Vancouver Open data set. These datasets can be found at [Vanocuver Open Data](#http://data.vancouver.ca/datacatalogue/index.htm).



##Hypothesis
The size, age, and number of trees has a direct effect on the value of land in the City of Vancouver.

##Analysis
Using the property tax report for land values provided by the City of Vancouver, as well as the dataset for street trees in Vancouver, this analysis will test the correlation between land value and various attributes of street trees. These attributes include the size, age, number, and location of the trees. The data may also be used to generate the average number of trees by neighborhood in contrast with average land value. To help visualize the data, a heat map of Vancouver including the land value and location of trees will be provided.

##Sub-Modules
There are 4 modules in the root directory. They include bin, data, doc, results, and src.

`data` contains all the raw data taken from the City of Vancouver website. This data includes spatial data for area boundaries, the public tree dataset, and the tax assessment dataset.

`doc` contains the compiled report with all generated graphics and analyses.

`results`: contains the cleaned data, all of the plots, and analysis performed.   

`src`: contains all of the scripts to perform the analysis. This folder contains the import, analysis, visualization, and running scripts. 

`packrat`: contains all of the required packages for the program to be run on another machine. 

