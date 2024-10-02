---
layout: default
title: 9. Difference-in-Differences
parent: Labs
nav_order: 9
---

# Lab 9
{: .no_toc }

## Difference-in-Differences
{: .no_toc }

In this lab, you will learn how to conduct difference-in-differences analysis.

---

## Preparation

For this lab, you will need `airbnb.csv`. Download it from Canvas and upload it to your R Studio Cloud.

You will also need the packages `dplyr`, `lfe`, `stargazer`, and `ggplot2`. These should alrady be installed from previous labs, but if not then please install them in your workspace using `install.packages`.

---

## Data Description

`airbnb.csv` is a CSV file where each row represents a city-year. It is therefore considered panel data where the subjects are cities and the time period is a year. The file has the following columns:

- `city`: The name of the city.
- `year`: The year of the data.
- `airbnb_listings`: The number of Airbnb listings in that city/year.
- `building_permits`: The number of housing permits approved in that city/year.
- `population`: The total population in that city/year.
- `avg_hh_income`: The average household income in that city/year.
- `tourists`: The number of tourists who visited that city in that year.

---

## Objective

Between 2015 and 2016, four cities passed regulations restricting Airbnb. The four cities that passed regulations are:

- New York
- Los Angeles
- San Francisco
- Las Vegas

The other four cities in the data, Raleigh, Tucson, Phoenix, and Columbus, did not pass any Airbnb regulations.

Our objective is to use DID analysis to estimate the effect of the Airbnb regulations on the number of Airbnb listings.

---

## Instructions

Follow along as I show the class how to write today's script. If you followed along, you should end up with the script below.

```r
rm(list=ls())      # Clear the workspace
library(dplyr)     # Load required libraries
library(lfe)
library(stargazer)
library(ggplot2)

# Load airbnb.csv into a dataframe called df
df <- read.csv("airbnb.csv")

# Create a variable called treated which is TRUE if the city 
# passed an Airbnb regulation between 2015 and 2016
df$treated <- df$city %in% c('New York', 'Los Angeles', 'San Francisco', 'Las Vegas')

# Create a variable called post which is TRUE if the year is
# 2016 or later
df$post <- df$year>=2016

# Create a variable that is equal to treated times post and 
# call it treatedXpost
df$treatedXpost <- df$post * df$treated


# Create a DID analysis plot showing the trends in log(airbnb_listings) 
# for the treatment and the control groups
plot_df <- df %>%
  group_by(treated, year) %>% 
  summarize(
    mean_log_airbnb_listings = mean(log(airbnb_listings))
  )

ggplot(data=plot_df) + 
  geom_line(aes(x=year, y=mean_log_airbnb_listings, color=treated))


# Run the DID regressions
r1 <- felm( log(airbnb_listings) ~ treatedXpost + treated + post, data=df)
r2 <- felm( log(airbnb_listings) ~ treatedXpost | city + year, data=df)
r3 <- felm( log(airbnb_listings) ~ treatedXpost + log(population) + log(avg_hh_income) + log(tourists) | city + year, data=df)

stargazer(r1, r2, r3, type="text")
```

---

## Assignment

- Create a new script that repeats the analysis, but shows the effect of Airbnb regulations on building permits.

- Upload the script to the Lab 09 Script Assignment

---

## Takeaways

- You can independently conduct difference-in-differences analysis using panel data.







