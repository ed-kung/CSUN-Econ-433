# ECON 433 - Lab Session 6
## Data Visualization

In this lab you will learn how to create some simple charts in R. You will learn about how to create line plots, bar charts, and scatter plots. 

In the process, you will also learn about missing values and factor labels.

## Lab Work

### Setup

For today's lab you will need the following files. They should already be uploaded to the cloud from previous labs. If they aren't, you should download these files from Canvas and upload them. 

- `IPUMS_ACS2014_CA_1.csv`
- `IPUMS_ACS2014_CA_2.csv`
- `IPUMS_ACS2019_CA_1.csv`
- `IPUMS_ACS2019_CA_2.csv`

You will also need a new file:

- `DEGFIELD_CODES.csv`

Download this file from Canvas and upload it to the cloud.

For today's lab you will also need the packages `dplyr` and `ggplot2`. `dplyr` should already be installed from previous labs. If it isn't, install it with `install.packages("dplyr")`. Also install `ggplot2` with `install.packages("ggplot2")`. `ggplot2` is the standard library for creating charts in R.

Finally, you should have the script `dataload.R` from Lab 04.

Make sure all these files are in your working directory before beginning.

### Line Plots

A line plot is used to show the relationship between two numerical variables. Use line plots when there is only one value of Y for each value of X. Example: How does average income change with age?

The following script creates a line plot showing how average income changes with age, using the 2019 ACS data.

    rm(list=ls())    # Clear the workspace
	library(dplyr)   # Load libraries
	library(ggplot2) 
	
	# Load the data
	source("dataload.R")  
	
	# Let R know about missing values for INCWAGE 
	df$INCWAGE[ df$INCWAGE>=999998] <- NA
	
	# Keep only data from 2019
	df <- filter(df, YEAR==2019)
	
	# Create a new dataframe that contains the average income for each age 
	df_inc_by_age <- df %>% 
	  group_by(AGE) %>% 
	  summarize(
	    AVG_INCOME = weighted.mean(INCWAGE, PERWT, na.rm=TRUE)
	  )

    # Plot average income by age 
    ggplot(data=df_inc_by_age) + 
      geom_line(aes(x=AGE, y=AVG_INCOME)) + 
      ggtitle("Average Income by Age, California 2019") +
      xlab("Age") + 
      ylab("Average Wage Income")
	  
	

	  
	
