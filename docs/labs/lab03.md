---
layout: default
title: 3. Summary Statistics
parent: Labs
nav_order: 3
---

# Lab 3
{: .no_toc }

## Summary Statistics
{: .no_toc }

In the previous lab, you learned how to tabulate and summarize variables with `table` and `summary`.

Unfortunately, the statistics provided by `table` and `summary` in the previous lab were not accurate, because they ignored **population weights**.

The American Community Survey is a [stratified sample](/docs/glossary/stratified-sample){:target="_blank"}, meaning that not all individuals are surveyed with equal probability.

In a stratified sample, each surveyed individual represents a different number of people in the population. For example, if 1 in 1,000 white people are surveyed, then each white person in the data represents 1,000 people in the population; but if 1 in 500 black people are surveyed, then each black person in the data represents 500 people in the population. The number of people that a survey unit represents is called the **population weight**.

In the IPUMS ACS, the population weight is given by the variable `PERWT`. `PERWT` tells us how many people each row of the data is meant to represent.

This lab shows you how to calculate population statistics accurately in a stratified sample using population weights.

---

## Preparation

Before starting the lab, you should make sure the following CSV file has been uploaded to your R Studio Cloud files directory.

- `IPUMS_ACS2019_CA_1.csv`

You'll also need to [install some packages](/docs/vignettes/installing-packages){:target="_blank"}. A package is a collection of functions and tools that expands R's baseline functionality. Packages are written by authors and developers from around the world, and are made available for free on [CRAN](https://cran.r-project.org/){:target="_blank"} (the Comprehensive R Archive Network).

Today you'll need to install the package called `dplyr`. To do so, type the following into your console and hit `ENTER`:

```r
install.packages("dplyr")
```

---

## Instructions

Follow along as I show the class how to conduct today's lab. 

If you followed along correctly, you should end up with the following script. The script does the following:
- Clear the workspace and load required packages.
- Read the CSV file into a dataframe.
- Assign `NA` to invalid value codes.
- Calculate the following statistics:
	- Total population
	- Population by race
	- Population by employment status
	- Overall employment rate
	- Employment rate by race
	- Employment rate by race and sex
	- Overall average income for employed individuals
	- Average income for employed individuals, by race
	- Average income for employed individuals, by race and sex

```r
rm(list=ls())   # Clear the workspace
library(dplyr)  # Load the packages
#(If dplyr is not installed, run install.packages("dplyr") from the console first)

# Load the data from csv file
df <- read.csv("IPUMS_ACS2019_CA_1.csv")

# Replace invalid values of INCWAGE with NA
# (Necessary for calculating accurate income statistics)
# See: https://usa.ipums.org/usa-action/variables/INCWAGE#codes_section
df$INCWAGE <- na_if(df$INCWAGE, 999999)
df$INCWAGE <- na_if(df$INCWAGE, 999998)

# Replace invalid values of EMPSTAT with NA
# (Necessary for calculating accurate employment statistics)
# See: https://usa.ipums.org/usa-action/variables/EMPSTAT#codes_section
df$EMPSTAT <- na_if(df$EMPSTAT, 0)
df$EMPSTAT <- na_if(df$EMPSTAT, 9)

# Create a boolean variable for whether the person is employed
# (We'll need it later to calculate employment rate)
df$EMPLOYED <- df$EMPSTAT==1

# Calculate total population
sum(df$PERWT, na.rm=TRUE)

# Calculate population by race
pop_by_race <- df %>%
  group_by(RACHSING) %>%
  summarize(
    TOTAL_POP = sum(PERWT, na.rm=TRUE)
  )

# Calculate population by employment status
pop_by_empstat <- df %>%
  group_by(EMPSTAT) %>% 
  summarize(
    TOTAL_POP = sum(PERWT, na.rm=TRUE)
  )

# Calculate overall employment rate
weighted.mean(df$EMPLOYED, df$PERWT, na.rm=TRUE)

# Calculate employment rate by race
emprate_by_race <- df %>%
  group_by(RACHSING) %>%
  summarize(
    EMPLOYMENT_RATE = weighted.mean(EMPLOYED, PERWT, na.rm=TRUE)
  )

# Calculate employment rate by race and sex
emprate_by_race_sex <- df %>%
  group_by(RACHSING, SEX) %>% 
  summarize(
    EMPLOYMENT_RATE = weighted.mean(EMPLOYED, PERWT, na.rm=TRUE)
  )

# Create a filtered dataframe that contains only employed individuals
df_employed <- filter(df, EMPSTAT==1)

# Calculate overall average income of employed individuals
weighted.mean(df_employed$INCWAGE, df_employed$PERWT, na.rm=TRUE)

# Calculate average income of employed individuals, by race
inc_by_race <- df_employed %>%
  group_by(RACHSING) %>%
  summarize(
    AVG_INCOME = weighted.mean(INCWAGE, PERWT, na.rm=TRUE)
  )

# Calculate average income of employed individuals, by race and sex
inc_by_race_sex <- df_employed %>%
  group_by(RACHSING, SEX) %>% 
  summarize(
    AVG_INCOME = weighted.mean(INCWAGE, PERWT, na.rm=TRUE)
  )
```

If you missed something during lecture, or if you need a refresher, you may find the following docs helpful:

- **Vignettes**
	- [Summary statistics](/docs/vignettes/summary-statistics){:target="_blank"}
- **Functions**
	- [na_if](/docs/functions/na_if){:target="_blank"}
	- [weighted.mean](/docs/functions/weighted-mean){:target="_blank"}
	- [filter](/docs/functions/filter){:target="_blank"}
- **Glossary**
	- [Stratified sample](/docs/glossary/stratified-sample){:target="_blank"}

---

## Assignment

- Create a new script that accomplishes the following tasks:
	- Read `IPUMS_ACS2019_CA_1.csv` and store it in a dataframe called `df`.
	- Assign `NA` to invalid values of `EMPSTAT` and `INCWAGE`.
	- Calculate the following summary statistics:
		- The total population in each county
		- The population of each race in each county
		- The employment rate in each county
		- The average income of employed individuals, by county
		- The average income of employed individuals, by county, race, and sex
	
	*Hint*: `COUNTYFIP` is the variable that contains the county codes.

- Upload the script to the Lab 03 Script assignment.

---

## Takeaways

- You know what a stratified sample is and what population weights are.
- You can calculate summary statistics in a stratified sample.
- You can use `na_if` to assign `NA` to missing and invalid values in a dataframe.
- You know how to filter a dataframe to select only rows that meet a desired criterion.