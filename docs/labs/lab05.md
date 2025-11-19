---
layout: default
title: 5. Putting it All Together
parent: Labs
nav_order: 5
---

# Lab 5
{: .no_toc }

## Putting it All Together
{: .no_toc }

In this lab you'll put together the tools you learned in the previous 4 labs to create a table showing changes in income for college vs. non-college educated individuals from 2018 to 2023.

---

## Preparation

You should already have `IPUMS_ACS_CA_2018_2023.csv` in your R Studio Cloud files directory. If you don't have this file, check the instructions for [Lab 4](/CSUN-Econ-433/docs/labs/lab04).

You'll also need the package `dplyr`, which should already be installed. If it's not installed you can install it by typing this into the console:

```r
install.packages("dplyr")
```

---

## Instructions

Follow along as I show the class how to conduct today's lab.  If you followed along correctly, you should end up with the following three scripts.

### Line Plots

This script makes a line plot showing average income by age for employed individuals, using data from California 2023.  The lines are plotted separately for males and for females.

```r
rm(list=ls())   # Clear workspace
library(dplyr)  # Load required packages
library(ggplot2)

# Load the main data
df <- read.csv("IPUMS_ACS_CA_2018_2023.csv")

# Deal with invalid values for INCWAGE and EMPSTAT
df$INCWAGE <- na_if(df$INCWAGE, 999999)
df$INCWAGE <- na_if(df$INCWAGE, 999998)
df$EMPSTAT <- na_if(df$EMPSTAT, 0)
df$EMPSTAT <- na_if(df$EMPSTAT, 9)

# First, calculate average income of employed individuals by
# age and sex, using data from 2023
inc_by_age_sex <- df %>%
  filter(YEAR==2023 & EMPSTAT==1) %>%
  group_by(AGE, SEX) %>%
  summarize(
    AVG_INCOME = weighted.mean(INCWAGE, PERWT, na.rm=TRUE)
  )
  
# Now create the line plot using the dataframe containing the stats
ggplot(data=inc_by_age_sex) +
  geom_line(aes(x=AGE, y=AVG_INCOME, color=as.factor(SEX))) + 
  xlab("Age") + 
  ylab("Average Income") + 
  ggtitle("Average Income of Employed Individuals by Age and Sex, California 2023")
```

---

## Assignment

For this lab, you need to create a script that builds a dataframe with columns: 
- `COUNTYFIP`: The county
- `COLLEGE`: A boolean for whether a person has 4+ years of college education
- `INC_2018`: The average income of employed individuals in 2018, by `COUNTYFIP` and `COLLGE`
- `INC_2023`: The average income of employed individuals in 2023, by `COUTYFIP` and `COLLEGE`
- `INC_CHG`: The percentage change in average income of employed individuals from 2018 to 2023, by `COUTYFIP` and `COLLEGE`

Hints:
- You'll need to first create two separate dataframes with average income by county/college, one for 2018 and one for 2023
- You'll then need to merge those two dataframes on `COUNTYFIP`, `COLLEGE`
- You'll then need to create a new variable called `INC_CHG`

Show me your script and output to receive your grade and be dismissed. If you aren't able to complete the assignment in class, you can upload the script to the Lab 05 Script assignment.
---

## Takeaways

- You can work on complex data wrangling tasks independently in R.



