rm(list=ls()) # clears the workspace

# Load required packages
library(ggplot2) 
library(dplyr)

# Load required datasets
df1 <- read.csv("IPUMS_ACS2019_CA_1.csv") 
df2 <- read.csv("IPUMS_ACS2019_CA_2.csv")

# Join the two 2019 datasets
df <- ##

# Filter to individuals aged 25-65 and in the labor force
df <- ##

# Make a college variable
df$COLLEGE <- ##

# Make an unemployed variable
df$UNEMPLOYED <- ##

# Group by county and calculate college share, unemployment rate, and pop
county_df <- ##

# Scatter plot
ggplot(##) + 
  geom_point(##)




