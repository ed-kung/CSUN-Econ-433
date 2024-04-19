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

Thus, each surveyed individual represents a different number of people in the population. For example, if 1 in 1,000 white people are surveyed, then each white person in the data represents 1,000 people in the population; but if 1 in 500 black people are surveyed, then each black person in the data represents 500 people in the population.

In the IPUMS ACS, the population weight is given by the variable `PERWT`. `PERWT` tells us how many people that row of the data is meant to represent.

This lab shows you how to calculate population statistics accurately in a stratified sample using population weights.

## Preparation

Before starting the lab, you should make sure the following CSV file has been uploaded to your R Studio Cloud files directory.

- `IPUMS_ACS2019_CA_1.csv`

You'll also need to [install some packages](/docs/vignettes/installing-packages){:target="_blank"}. A package is a collection of functions and tools that expands R's baseline functionality. Packages are written by authors and developers from around the world, and are made available for free on [CRAN](https://cran.r-project.org/){:target="_blank"} (the Comprehensive R Archive Network).

Today you'll need to install the package called `dplyr`. To do so, type the following into your console and hit `ENTER`:

```r
install.packages("dplyr")
```

## Instructions

Follow along as I show the class how to conduct today's lab. 

If you followed along correctly, you should end up with the following script. The script does the following:
- Clear the workspace and load required packages.
- Read the CSV file into a dataframe.
- Calculate the following statistics:
	- Total population
	- Population by race
	- Population by employment status
	- Overall employment rate
	- Employment rate by race
	- Employment rate by race and sex
	- Overall average income
	- Average income by race
	- Average income by race, sex, and employment status

```r
rm(list=ls())   # Clear the workspace
library(dplyr)  # Load the packages
#(If dplyr is not installed, run install.packages("dplyr") from the console first)

# Load the data from csv file
df <- read.csv("IPUMS_ACS2019_CA_1.csv")

# Create a boolean variable for whether the person is employed
# (We'll need it later)
df$EMPLOYED <- df$EMPSTAT==1

# Calculate total population
sum(df$PERWT)

# Calculate population by race
pop_by_race <- df %>%
  group_by(RACHSING) %>%
  summarize(
    TOTAL_POP = sum(PERWT)
  )

# Calculate population by employment status
pop_by_empstat <- df %>%
  group_by(EMPSTAT) %>% 
  summarize(
    TOTAL_POP = sum(PERWT)
  )

# Calculate overall employment rate
weighted.mean(df$EMPLOYED, df$PERWT)

# Calculate employment rate by race
emprate_by_race <- df %>%
  group_by(RACHSING) %>%
  summarize(
    EMPLOYMENT_RATE = weighted.mean(EMPLOYED, PERWT)
  )

# Calculate employment rate by race and sex
emprate_by_race_sex <- df %>%
  group_by(RACHSING, SEX) %>% 
  summarize(
    EMPLOYMENT_RATE = weighted.mean(EMPLOYED, PERWT)
  )
```

If you missed something during lecture, or if you need a refresher, you may find the following docs helpful:

- **Vignettes**
	- [Summary statistics](/docs/vignettes/summary-statistics){:target="_blank"}
- **Glossary**
	- [Stratified sample](/docs/glossary/stratified-sample){:target="_blank"}



