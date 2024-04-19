---
layout: default
title: 4. Combining Datasets
parent: Labs
nav_order: 4
---

# Lab 4
{: .no_toc }

## Combining Datasets
{: .no_toc }

In this lab you will learn how to combine multiple datasets into a new dataset. 

This is useful when you have multiple sources of data about the same subject. For example, you may have zipcode house price data from Zillow and zipcode demographics from the Census and you want to combine them.

You will also learn how to save a modified dataset for future use.

---

## Preparation

Before starting the lab, you should download these files from Canvas and upload them to your R Studio Cloud files directory.
- `IPUMS_ACS2019_CA_1.csv`
    - Contains basic geographic and demographic information for people in California in 2019
- `IPUMS_ACS2019_CA_2.csv`
	- Contains additional education and occupational information for people in California in 2019
- `IPUMS_ACS2014_CA_1.csv`
    - Contains basic geographic and demographic information for people in California in 2014
- `IPUMS_ACS2014_CA_2.csv`
	- Contains additional education and occupational information for people in California in 2014

You'll also need to have `dplyr` installed. If you did the previous lab successfully, `dplyr` should already be installed in your R Studio Cloud workspace. If it is not, follow the instructions [here](/docs/vignettes/installing-packages){:target="_blank""}

## Instructions

Follow along as I show the class how to conduct today's lab.  If you followed along correctly, you should end up with two scripts. 

The first script does the following:
- Clear the workspace and load the required libraries.
- Read the two 2014 CSV files into dataframes, then merge them into a single 2014 dataframe.
- Read the two 2019 CSV files into dataframes, then merge them into a single 2019 dataframe.
- Append the 2014 and 2019 dataframes together.
- Save the resulting dataframe into a CSV file called `IPUMS_ACS_CA_2014_2019.csv`.

The second script does the following:
- Loads `IPUMS_ACS_CA_2014_2019.csv`, which you created in the first script.
- Calculates the percent of people aged 25+ with 4+ years of college education, by county and year.

**Script 1:**
```r
rm(list=ls())   # Clear the workspace
library(dplyr)  # Load the packages
#(If dplyr is not installed, run install.packages("dplyr") from the console first)

# Read the 2014 CSV files and merge them
df_2014_1 <- read.csv("IPUMS_ACS2014_CA_1.csv")
df_2014_2 <- read.csv("IPUMS_ACS2014_CA_2.csv")
df2014 <- inner_join(df_2014_1, df_2014_2, by=c("YEAR","SERIAL","PERNUM"))

# Read the 2019 CSV files and merge them
df_2019_1 <- read.csv("IPUMS_ACS2019_CA_1.csv")
df_2019_2 <- read.csv("IPUMS_ACS2019_CA_2.csv")
df2019 <- inner_join(df_2019_1, df_2019_2, by=c("YEAR","SERIAL","PERNUM"))

# Append the 2014 and 2019 dataframes
df <- rbind(df2014, df2019)

# Show the structure of the resulting dataframe
str(df)

# Save the resulting dataframe
write.csv(df, "IPUMS_ACS_CA_2014_2019.csv", row.names=FALSE)
```

**Script 2:**
```
rm(list=ls())  # Clear the workspace
library(dplyr) # Load the required packages

# Read in the 2014/2019 California ACS data
df <- read.csv("IPUMS_ACS_CA_2014_2019.csv")

# Create a variable indicating whether the person has 4+ 
# years of college education
# See: https://usa.ipums.org/usa-action/variables/EDUC#codes_section
df$COLLEGE <- df$EDUC>=10

# Create a filtered dataframe containing only people aged 25+
df_adult <- filter(df, AGE>=25)

# Calculate percent of people aged 25+ with 4+ years of college
# education, by county and year
coll_by_county_year <- df_adult %>% 
  group_by(COUNTYFIP, YEAR) %>% 
  summarize(
    PCT_COLLEGE = weighted.mean(COLLEGE, PERWT, na.rm=TRUE)
  )
```

If you missed something during lecture, or if you need a refresher, you may find the following docs helpful:

- **Vignettes**:
    - [Summary statistics](/docs/vignettes/summary-statistics){:target="_blank"}
- **Functions**: 
	- [inner_join](/docs/functions/inner_join){:target="_blank"}
	- [rbind](/docs/functions/rbind){:target="_blank"}
	- [write.csv](/docs/functions/write-csv){:target="_blank"}

---

## Assignment

- Create a new script that uses `IPUMS_ACS_CA_2014_2019.csv`, which you already created, to calculate the following summary statistics:
	- The average income of employed individuals aged 25+, by county and year
	- The employment rate of individuals aged 25+, by year, race, sex, and college education (4+ years of college).
	- The average income of employed individuals aged 25+, by year, race, sex, and college education (4+ years of college).

- Upload the script to the Lab 04 Assignment.

- Take the Lab 04 Quiz.

---

## Takeaways

- You can combine datasets in R using `rbind` and `inner_join`.
- You understand what it means to merge two datasets on one or more key variables.
- You know how to save a dataframe to a CSV file using `write.csv`.

