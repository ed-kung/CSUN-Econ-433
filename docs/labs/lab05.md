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
- [Line plots](/docs/vignettes/line-plots){:target="_blank"}
- [Scatter plots](/docs/vignettes/scatter-plots){:target="_blank"}
- [Bar charts](/docs/vignettes/bar-charts){:target="_blank"}

---

## Preparation

You should already have `IPUMS_ACS_CA_2014_2019.csv` in your R Studio Cloud files directory. If you don't have this file, check the instructions for [Lab 4](/docs/labs/lab04).

You'll also need `RACHSING_LABELS.csv` and `DEGFIELD_LABELS.csv`. Download these from Canvas and upload them to your R Studio Cloud files directory.

You'll also need the packages `dplyr` and `ggplot2`. `dplyr` should already be installed, but not `ggplot2`. Go ahead and install `ggplot2` by typing this into the console:

```r
install.packages("ggplot2")
```

---

## Instructions

Follow along as I show the class how to conduct today's lab.  If you followed along correctly, you should end up with the following script.

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

# Create a variable indicating 4+ years of college
df$COLLEGE <- df$EDUC>=10

#-------------------------------------------------------------------
# Create a line plot: 
# Average income for employed individuals by age and sex
# using data from California 2019
#-------------------------------------------------------------------

# First create a dataframe containing the required summary statistics
inc_by_age_sex <- filter(df, YEAR==2019 & EMPSTAT==1) %>%
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

#-------------------------------------------------------------------


#-------------------------------------------------------------------
# Create a scatter plot: 
# X: Percent of individuals in a county that have 4+ years of college
# Y: Average income of employed individuals in the county
# Each dot is a county in California in 2019
# The size of the dot is equal to the population of the county
#-------------------------------------------------------------------

# First, calculate the percent of individuals in each county that
# have 4+ years of college, as well as the total population of the county
# using data from 2019
county_df1 <- filter(df, YEAR==2019) %>%
  group_by(COUNTYFIP) %>%
  summarize(
    POPULATION = sum(PERWT, na.rm=TRUE),
    PCT_COLLEGE = weighted.mean(COLLEGE, PERWT, na.rm=TRUE)
  )

# Second, calculate the average income of employed individuals for
# each county in 2019
county_df2 <- filter(df, YEAR==2019 & EMPSTAT==1) %>%
  group_by(COUNTYFIP) %>%
  summarize(
    AVG_INCOME = weighted.mean(INCWAGE, PERWT, na.rm=TRUE)
  )

# Third, merge the two county-level dataframes you just created
county_df <- inner_join(county_df1, county_df2, by=c("COUNTYFIP"))

# Finally, create the scatter plot
ggplot(data=county_df) +
  geom_point(aes(x=PCT_COLLEGE, y=AVG_INCOME, size=POPULATION)) +
  xlab("Percent of Population with 4+ Yrs of College") + 
  ylab("Average Income of Employed Individuals") + 
  ggtitle("Income and College Education of California Counties, 2019")

#-------------------------------------------------------------------


#-------------------------------------------------------------------
# Create a horizontal bar chart: 
# Showing the average income of employed individuals, by race
# using data from California 2019
#-------------------------------------------------------------------

# First, calculate average income of employed individuals by race
# with 2019 data
inc_by_race <- filter(df, YEAR==2019 & EMPSTAT==1) %>%
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

#-------------------------------------------------------------------
```

---

## Assignment

- Create a new script that accomplishes the following task:
	- Using data from California 2019, calculate the percent of people within each `DEGFIELD` that are female. 
	- Create a horizontal bar chart showing the above data. Make sure you use `DEGFIELD_LABELS.csv` to make the degree fields human-readable in the chart.
	- Give the chart the following title: "Percent Female by Degree Field, California 2019"

- Upload the script to the Lab 05 Assignment.

- Take the Lab 05 Quiz.

---

## Takeaways

- You can make line plots, scatter plots, and bar charts in R, using the `ggplot2` package.


