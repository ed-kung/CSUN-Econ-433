---
layout: default
title: 5. Grouped Summary Statistics
parent: Labs
nav_order: 5
---

# Lab 5
{: .no_toc }

## Grouped Summary Statistics
{: .no_toc }

In this lab you will learn how to calculate summary statistics for different groups in your data. This would allow you to calculate, for example, the average income of college vs. non-college educated workers in California in 2014 and 2019.

## Preparation

Before starting the lab, make sure the following CSV file is in your R Studio Cloud directory:
- `IPUMS_ACS_CA_2014_2019.csv`

(This file was created as part of the [Lab 4](/docs/labs/lab04).)

You should also have `dplyr` installed. If not, install it from the console.

## Instructions

Follow along as I show the class how to conduct today's lab.

{: .warning }
> Many students find the concepts in this lab difficult to understand. Please pay careful attention during class and ask questions if you have any.

If you followed along correctly, you should end up with the following script. The script does the following:
- Clear the workspace and load the required libraries.
- Load the California data from 2014 and 2019 that we created in the previous lab.
- Replace invalid values of income with `NA`.
- Calculate the total population, by year
- Calculate the average income of employed people, by year
- Calculate the percent of the aged 25+ population that is college educated, by year.
- Do all of the above, but for county and year, not just year.
- Calculate the average income of employed people by sex, year, and whether the person is college educated.

```r
rm(list=ls())   # Clear the workspace
library(dplyr)  # Load the required packages

# Load the CA 2014/2019 data
df <- read.csv("IPUMS_ACS_CA_2014_2019.csv")

# Create a variable indicating if the person is college educated
# (4+ years college education)
# We'll need this later
df$COLLEGE <- df$EDUC>=10

# Calculate total population by year
#-------------------------------------------------------------------
pop_by_year <- df %>%
  group_by(YEAR) %>% 
  summarize(
    POPULATION = sum(PERWT)
  )
#-------------------------------------------------------------------

# Calculate average income for employed people by year
#-------------------------------------------------------------------
# First, create a filtered dataset with only employed people
df_employed <- filter(df, EMPSTAT==1)

# Then, calculate the grouped summary statistics
avg_income_by_year <- df_employed %>%
  group_by(YEAR) %>%
  summarize(
    AVG_INCOME = weighted.mean(INCWAGE, PERWT)
  )
#--------------------------------------------------------------------

# Calculate the percent of the aged 25+ population that is college
# educated, by year
#---------------------------------------------------------------------
# First, create a filtered dataset that contains only people aged 25+
df_adults <- filter(df, AGE>=25)

# Then, calculate the grouped summary statistics
pct_college_by_year <- df_adults %>%
  group_by(YEAR) %>% 
  summarize(
    PCT_COLLEGE = weighted.mean(COLLEGE, PERWT)
  )
#----------------------------------------------------------------------

# Calculate total population by county/year
#-------------------------------------------------------------------
pop_by_county_year <- df %>%
  group_by(COUNTYFIP, YEAR) %>% 
  summarize(
    POPULATION = sum(PERWT)
  )
#-------------------------------------------------------------------

# Calculate average income for employed people by county/year
#-------------------------------------------------------------------
avg_income_by_county_year <- df_employed %>%
  group_by(COUNTYFIP, YEAR) %>%
  summarize(
    AVG_INCOME = weighted.mean(INCWAGE, PERWT)
  )
#--------------------------------------------------------------------

# Calculate the percent of the aged 25+ population that is college
# educated, by county/year
#---------------------------------------------------------------------
pct_college_by_county_year <- df_adults %>%
  group_by(COUNTYFIP, YEAR) %>% 
  summarize(
    PCT_COLLEGE = weighted.mean(COLLEGE, PERWT)
  )
#----------------------------------------------------------------------

# Calculate the average income of employed people by sex, year, and 
# whether they are college educated
#----------------------------------------------------------------------
avg_income_by_sex_year_college <- df_employed %>%
  group_by(SEX, YEAR, COLLEGE) %>%
  summarize(
    AVG_INCOME = weighted.mean(INCWAGE, PERWT)
  )
#----------------------------------------------------------------------
```



