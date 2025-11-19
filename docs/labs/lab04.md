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
- `IPUMS_ACS2023_CA_1.csv`
    - Contains basic geographic and demographic information for people in California in 2023
- `IPUMS_ACS2023_CA_2.csv`
	- Contains additional education and occupational information for people in California in 2023
- `IPUMS_ACS2018_CA_1.csv`
    - Contains basic geographic and demographic information for people in California in 2018
- `IPUMS_ACS2018_CA_2.csv`
	- Contains additional education and occupational information for people in California in 2018

You'll also need to have `dplyr` installed. If you did the previous lab successfully, `dplyr` should already be installed in your R Studio Cloud workspace. If it is not, follow the instructions [here](/CSUN-Econ-433/docs/vignettes/installing-packages){:target="_blank""}

## Instructions

Follow along as I show the class how to conduct today's lab.  If you followed along correctly, you should end up with two scripts. 

The first script does the following:
- Clear the workspace and load the required libraries.
- Read the two 2018 CSV files into dataframes, then merge them into a single 2018 dataframe.
- Read the two 2023 CSV files into dataframes, then merge them into a single 2023 dataframe.
- Append the 2018 and 2023 dataframes together.
- Save the resulting dataframe into a CSV file called `IPUMS_ACS_CA_2018_2023.csv`.

The second script does the following:
- Loads `IPUMS_ACS_CA_2018_2023.csv`, which you created in the first script.
- Calculates the total population, by county and year.
- Calculates the percent of people aged 25+ with 4+ years of college education, by county and year.
- Create a single county-by-year dataframe that contains information about the total population and the percent of people aged 25+ with 4+ years of college education in each county/year.

---

### Script 1: Create and save a combined dataset

```r
rm(list=ls())   # Clear the workspace
library(dplyr)  # Load the packages
#(If dplyr is not installed, run install.packages("dplyr") from the console first)

# Read the 2018 CSV files and merge them
df_2018_1 <- read.csv("IPUMS_ACS2018_CA_1.csv")
df_2018_2 <- read.csv("IPUMS_ACS2018_CA_2.csv")
df2018 <- inner_join(df_2018_1, df_2018_2, by=c("YEAR","SERIAL","PERNUM"))

# Read the 2023 CSV files and merge them
df_2023_1 <- read.csv("IPUMS_ACS2023_CA_1.csv")
df_2023_2 <- read.csv("IPUMS_ACS2023_CA_2.csv")
df2023 <- inner_join(df_2023_1, df_2023_2, by=c("YEAR","SERIAL","PERNUM"))

# Append the 2018 and 2023 dataframes
df <- rbind(df2018, df2023)

# Save the resulting dataframe
write.csv(df, "IPUMS_ACS_CA_2018_2023.csv", row.names=FALSE)
```

---

### Script 2: 

```r
rm(list=ls())  # Clear the workspace
library(dplyr) # Load the required packages

# Read in the 2018/2023 California ACS data
df <- read.csv("IPUMS_ACS_CA_2018_2023.csv")

# Create a variable indicating whether the person has 4+ 
# years of college education
# See: https://usa.ipums.org/usa-action/variables/EDUC#codes_section
df$COLLEGE <- df$EDUC>=10

# Calculate total population by county/year
pop_by_county_year <- df %>%
  group_by(COUNTYFIP, YEAR) %>% 
  summarize(
    POPULATION = sum(PERWT)
  )

# Out of the population aged 25+, calculate the percent
# with 4+ years of college education, by county and year
coll_by_county_year <- df %>%
  filter(AGE>=25) %>%
  group_by(COUNTYFIP, YEAR) %>% 
  summarize(
    PCT_COLLEGE = weighted.mean(COLLEGE, PERWT, na.rm=TRUE)
  )

# Create a single county/year dataframe with population 
# and pct of adults with 4+ years college education
county_df <- inner_join(pop_by_county_year, coll_by_county_year, by=c("COUNTYFIP","YEAR"))  
```

If you missed something during lecture, or if you need a refresher, you may find the following docs helpful:

- **Vignettes**:
    - [Summary statistics](/CSUN-Econ-433/docs/vignettes/summary-statistics){:target="_blank"}
- **Functions**: 
	- [inner_join](/CSUN-Econ-433/docs/functions/inner_join){:target="_blank"}
	- [rbind](/CSUN-Econ-433/docs/functions/rbind){:target="_blank"}
	- [write.csv](/CSUN-Econ-433/docs/functions/write-csv){:target="_blank"}

---

## Assignment

- Create a new script that uses `IPUMS_ACS_CA_2018_2023.csv`, which you already created, to calculate the following summary statistics:
	- The total population by county and year. Call this dataframe `county_pop`.
	- The employment rate by county and year. Call this dataframe `county_emp`.
	    - *Hint: Remember to deal with invalid values for `EMPSTAT` and refer to Lab 3 if you forgot how to do this.*
	- The percent of people aged 25+ with 4+ years college education, by county and year. Call this dataframe `county_educ`.
	- The average income of employed individuals, by county and year. Call this dataframe `county_inc`.
	    - *Hint: Remember to use only employed people when calculating this average and to deal with invalid values for income. Refer to Lab 3 for a reminder.*
	- Merge the four above dataframes together to get a single county-by-year level dataframe. Call this new dataframe `county_df`.
	    - *Hint: You can only use `inner_join` on two dataframes at a time, so you'll have to first merge `county_pop` with `county_emp`, then merge the resulting dataframe with `county_educ`, and then that result with `county_inc`.*

- Show me your script and output to receive your grade and be dismissed. If you aren't able to complete the assignment in class, you can upload the script to the Lab 04 Script assignment.

---

## Takeaways

- You can combine datasets in R using `rbind` and `inner_join`.
- You understand what it means to merge two datasets on one or more key variables.
- You know how to save a dataframe to a CSV file using `write.csv`.

