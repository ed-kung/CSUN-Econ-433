---
layout: default
title: 5. Data Visualization
parent: Labs
nav_order: 5
---

# Lab 5
{: .no_toc }

## Data Visualization
{: .no_toc }

In this lab, we'll walk through some data visualization coding patterns. You'll learn how to create line plots, which shows the relationship between two variables, scatter plots, which shows the relationship between two variables for multiple units of observation, and bar charts, which shows the relationship between a continuous and a categorical variable.

---

## Preparation

You should already have `IPUMS_ACS_CA_2018_2023.csv` in your R Studio Cloud files directory. If you don't have this file, check the instructions for [Lab 4](/CSUN-Econ-433/docs/labs/lab04).

You'll also need the package `dplyr`, which should already be installed. If it's not installed you can install it by typing this into the console:

```r
install.packages("dplyr")
```

---

## Instructions

Follow along as I show the class how to conduct today's lab.  If you followed along correctly, you should end up with the following script.

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


# ---- Line plot: Average income of employed individuals by age and sex, 2023

# First, calculate average income of employed individuals by age and by sex using data from 2023

inc_by_age_sex_2023 <- df %>%
  filter(YEAR==2023 & EMPSTAT==1 & AGE>=25 & AGE<=65) %>%
  group_by(AGE, SEX) %>%
  summarize(
    AVG_INCOME_2023 = weighted.mean(INCWAGE, PERWT, na.rm=TRUE)
  )
 
# Then, make the line plot

ggplot(data=inc_by_age_sex_2023) +
  geom_line(aes(x=AGE, y=AVG_INCOME_2023, color=as.factor(SEX))) + 
  xlab("Age") + 
  ylab("Average Income") + 
  ggtitle("Average Income of Employed Individuals by Age and Sex, California 2023")


# ---- Scatter plot: Average income vs. college education by county, 2023

# First, calculate average income and college percentage by county in 2023

df$COLLEGE <- df$EDUC>=10

county_df <- df %>%
  filter(YEAR==2023 & EMPSTAT==1 & AGE>=25 & AGE<=65) %>%
  group_by(COUNTYFIP) %>%
  summarize(
    AVERAGE_INCOME = weighted.mean(INCWAGE, PERWT, na.rm=TRUE),
	PCT_COLLEGE = weighted.mean(COLLEGE, PERWT, na.rm=TRUE)
  )
  
# Now make the scatter plot

ggplot(data=county_df) + 
  geom_point(aes(x=PCT_COLLEGE, y=AVERAGE_INCOME)) + 
  xlab("Pct College Educated") + 
  ylab("Average Income") + 
  ggtitle("Average Income of Employed Adults vs. Pct College Educated, California 2023")



# ---- Bar chart: Change in Percent College Educated by Sex, 2018-2023

# First, create two dataframes, one for 2018 and 2023, each one showing pct college
# educated by sex for that year

educ_by_sex_2018 <- df %>%
  filter(YEAR==2018 & AGE>=25 & AGE<=65) %>%
  group_by(SEX) %>%
  summarize(
    PCT_COLLEGE_2018 = weighted.mean(COLLEGE, PERWT, na.rm=TRUE)
  )
 
educ_by_sex_2023 <- df %>%
  filter(YEAR==2023 & AGE>=25 & AGE<=65) %>%
  group_by(SEX) %>%
  summarize(
    PCT_COLLEGE_2023 = weighted.mean(COLLEGE, PERWT, na.rm=TRUE)
  )

# Second, merge them and then calculate the change in pct college
 
my_df <- inner_join(
  educ_by_sex_2018,
  educ_by_sex_2023,
  by=c("SEX")
)

my_df$PCT_COLLEGE_CHG <- my_df$PCT_COLLEGE_2023 - my_df$PCT_COLLEGE_2018


# Now make the bar chart
ggplot(data=my_df) + 
  geom_col(aes(x=SEX, y=PCT_COLLEGE_CHG)) + 
  ylab("Change in Pct College Educated, 2018-2023") + 
  xlab("Sex (1=MALE, 2=FEMALE)") + 
  ggtitle("Change in Percent of Adults College Educated by Sex, California 2018-2023")
  
```

---

## Assignment

For this lab, create a scatter plot that shows *change* in average income and *change* in percent college educated by county.

Hints:
- First create a dataframe that shows average income and pct college by county in 2018.
- Then create a dataframe that shows average income and pct college by county in 2023.
- Then merge the two and calculate the change as a new column.
- Then plot the changes.

Show me your script and output to receive your grade and be dismissed.

---

## Takeaways

- You can work on complex data wrangling and visualization tasks independently in R.



