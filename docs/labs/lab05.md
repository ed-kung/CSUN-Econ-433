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

Data visualization is the practice of presenting data in a visually appealing way, so that interesting patterns can be easily spotted.

In this lab you will learn how to create three basic types of data visualization in R:
- [Line Plots](#line-plots)
- [Scatter Plots](#scatter-plots)
- [Bar Charts](#bar-charts)

---

## Preparation

You should already have `IPUMS_ACS_CA_2014_2019.csv` in your R Studio Cloud files directory. If you don't have this file, check the instructions for [Lab 4](/CSUN-Econ-433/docs/labs/lab04).

You'll also need `RACHSING_LABELS.csv` and `DEGFIELD_LABELS.csv`. Download these from Canvas and upload them to your R Studio Cloud files directory.

You'll also need the packages `dplyr` and `ggplot2`. `dplyr` should already be installed, but not `ggplot2`. Go ahead and install `ggplot2` by typing this into the console:

```r
install.packages("ggplot2")
```

---

## Instructions

Follow along as I show the class how to conduct today's lab.  If you followed along correctly, you should end up with the following three scripts.

### Line Plots

This script makes a line plot showing average income by age for employed individuals, using data from California 2019.  The lines are plotted separately for males and for females.

```r
rm(list=ls())   # Clear workspace
library(dplyr)  # Load required packages
library(ggplot2)

# Load the main data
df <- read.csv("IPUMS_ACS_CA_2014_2019.csv")

# Deal with invalid values for INCWAGE and EMPSTAT
df$INCWAGE <- na_if(df$INCWAGE, 999999)
df$INCWAGE <- na_if(df$INCWAGE, 999998)
df$EMPSTAT <- na_if(df$EMPSTAT, 0)
df$EMPSTAT <- na_if(df$EMPSTAT, 9)

# First, calculate average income of employed individuals by
# age and sex, using data from 2019
df_employed_2019 <- filter(df, YEAR==2019 & EMPSTAT==1) 
inc_by_age_sex <- df_employed_2019 %>%
  group_by(AGE, SEX) %>%
  summarize(
    AVG_INCOME = weighted.mean(INCWAGE, PERWT, na.rm=TRUE)
  )
  
# Now create the line plot using the dataframe containing the stats
ggplot(data=inc_by_age_sex) +
  geom_line(aes(x=AGE, y=AVG_INCOME, color=as.factor(SEX))) + 
  xlab("Age") + 
  ylab("Average Income") + 
  ggtitle("Average Income of Employed Individuals by Age and Sex, California 2019")
```

---

### Scatter Plots

This script makes a scatter plot where each dot is a county. The x axis shows the percent of age 25+ people in the county with 4+ years of college education. The y axis shows the average income of employed individuals in the county. The size of the dot shows the total population of the county.


```r
rm(list=ls())   # Clear workspace
library(dplyr)  # Load required packages
library(ggplot2)

# Load the main data
df <- read.csv("IPUMS_ACS_CA_2014_2019.csv")

# Deal with invalid values for INCWAGE and EMPSTAT
df$INCWAGE <- na_if(df$INCWAGE, 999999)
df$INCWAGE <- na_if(df$INCWAGE, 999998)
df$EMPSTAT <- na_if(df$EMPSTAT, 0)
df$EMPSTAT <- na_if(df$EMPSTAT, 9)

# Create a boolean variable for 4+ years college
df$COLLEGE <- df$EDUC>=10

# Total population by county, using 2019 data
df2019 <- filter(df, YEAR==2019)
county_pop <- df2019 %>%
  group_by(COUNTYFIP) %>%
  summarize(
    POPULATION = sum(PERWT, na.rm=TRUE)
  )
  
# Percent of age 25+ people with 4+ years of college,
# using 2019 data
df2019_adult <- filter(df, YEAR==2019 & AGE>=25)
county_educ <- df2019_adult %>%
  group_by(COUNTYFIP) %>%
  summarize(
    PCT_COLLEGE = weighted.mean(COLLEGE, PERWT, na.rm=TRUE)
  )
  
# Average income of employed individuals, using data from 2019
df2019_employed <- filter(df, YEAR==2019 & EMPSTAT==1)
county_inc <- df2019_employed %>%
  group_by(COUNTYFIP) %>%
  summarize(
    AVG_INCOME = weighted.mean(INCWAGE, PERWT, na.rm=TRUE)
  )

# Merge together to get one county level dataframe
county_df <- inner_join(county_pop, county_educ, by=c("COUNTYFIP"))
county_df <- inner_join(county_df, county_inc, by=c("COUNTYFIP"))

# Finally, create the scatter plot
ggplot(data=county_df) +
  geom_point(aes(x=PCT_COLLEGE, y=AVG_INCOME, size=POPULATION)) +
  xlab("% of age 25+ population with 4+ yrs of college") + 
  ylab("Avg income of employed individuals") + 
  ggtitle("Income and College Education of California Counties, 2019")
```

---

### Bar Charts

This script makes a horizontal bar chart, showing the average income of employed individuals, by race, using data from 2019.

```r
rm(list=ls())   # Clear workspace
library(dplyr)  # Load required packages
library(ggplot2)

# Load the main data
df <- read.csv("IPUMS_ACS_CA_2014_2019.csv")

# Deal with invalid values for INCWAGE and EMPSTAT
df$INCWAGE <- na_if(df$INCWAGE, 999999)
df$INCWAGE <- na_if(df$INCWAGE, 999998)
df$EMPSTAT <- na_if(df$EMPSTAT, 0)
df$EMPSTAT <- na_if(df$EMPSTAT, 9)

# First, calculate average income of employed individuals by race,  
# using data from 2019
df_employed_2019 <- filter(df, YEAR==2019 & EMPSTAT==1)
inc_by_race <- df_employed_2019 %>%
  group_by(RACHSING) %>%
  summarize(
    AVG_INCOME = weighted.mean(INCWAGE, PERWT, na.rm=TRUE)
  )
  
# Second, use RACHSING_LABELS.csv to merge on the human-readable
# labels for RACHSING
labels_data <- read.csv("RACHSING_LABELS.csv")
inc_by_race <- inner_join(inc_by_race, labels_data, by=c("RACHSING"))

# Finally, make the horizontal bar chart
ggplot(data=inc_by_race) + 
  geom_col(aes(x=RACHSING_LABEL, y=AVG_INCOME)) + 
  xlab("Race") + 
  ylab("Average Income") + 
  ggtitle("Average Income by Race, California 2019") +
  coord_flip()
```

---

## Assignment

- Create a new script that accomplishes the following task:
	- Using data from California 2019, calculate the percent of people within each `DEGFIELD` that are female. 
	- Create a horizontal bar chart showing the above data. Make sure you use `DEGFIELD_LABELS.csv` to make the degree fields human-readable in the chart.
	- Give the chart the following title: "Percent Female by Degree Field, California 2019"

- Upload the script to the Lab 05 Script assignment.

---

## Takeaways

- You can make line plots, scatter plots, and bar charts in R, using the `ggplot2` package.


