---
layout: default
title: Summary statistics
parent: Vignettes
nav_order: 7
---

# Summary statistics
{: .no_toc }

One of the most common tasks in data analysis is to compute summary statistics, often for different groups in the data.

For example, we might be interested in calculating the average income of the employed population, broken down by race.

This vignette will present numerous examples of how to calculate different kinds of summary statistics.

The examples will make extensive use of the code pattern below:
```r
some_dataframe_name <- dataframe %>%
  group_by(...) %>%
  summarize(
    ...
  )
```

This code pattern takes a dataframe, creates groups based on the variables you tell it to create groups by, then calculates a statistic for each of the groups.

You don't need to fully understand the code pattern. You only need to know how to use it. The examples below will show you how.

The `dplyr` package is required for most of these examples.


## Table of Contents
- TOC
{:toc}

---

## Stratified Samples

### Overall average of a numeric variable

```r
rm(list=ls())

df <- read.csv("IPUMS_ACS2019_CA_1.csv")

weighted.mean(df$AGE, df$PERWT, na.rm=TRUE)
```

This calculates the average of `AGE` using `PERWT` as weights. The result is displayed to the console.

---

### Average of a numeric variable by groups

```r
rm(list=ls())
library(dplyr)

df <- read.csv("IPUMS_ACS2019_CA_1.csv")

age_by_race_sex <- df %>%
  group_by(RACHSING, SEX) %>%
  summarize(
    AVG_AGE = weighted.mean(AGE, PERWT, na.rm=TRUE)
  )
```

This calculates the average `AGE` for each grouping of `RACHSING` and `SEX`, using `PERWT` as weights. The resulting table is stored in a dataframe called `age_by_race_sex`.

---

### Percent of the overall population that has a certain characteristic

```r
rm(list=ls())

df <- read.csv("IPUMS_ACS2019_CA_1.csv")

df$EMPLOYED <- df$EMPSTAT==1

weighted.mean(df$EMPLOYED, df$PERWT, na.rm=TRUE)
```

This calculates the percent of the overall population that is employed (has `EMPSTAT==1`). The result is displayed to the console.

{: .note }
> As a general rule, the mean of a boolean variable is equal to the percent of individuals who have `TRUE` for that variable. This is useful for calculating things like employment rate, college education rate, percent of different races in the population, etc.

---

### Percent of a group that has a certain characteristic

```r
rm(list=ls())
library(dplyr)

df <- read.csv("IPUMS_ACS2019_CA_1.csv")

df$EMPLOYED <- df$EMPSTAT==1

emprate_by_race <- df %>%
  group_by(RACHSING) %>%
  summarize(
    EMPLOYMENT_RATE = weighted.mean(EMPLOYED, PERWT, na.rm=TRUE)
  )
```

This calculates the percent of each racial group (`RACHSING`) that is employed. The result is stored in a dataframe called `emprate_by_race`.

---

### Total population

```r
rm(list=ls())

df <- read.csv("IPUMS_ACS2019_CA_1.csv")

sum(PERWT, na.rm=TRUE)
```

This calcualtes the total population in the dataframe, `df`, assuming that `PERWT` is the population weight of each survey unit. The result is displayed to the console.

---

### Total population by group

```r
rm(list=ls())
library(dplyr)

df <- read.csv("IPUMS_ACS2019_CA_1.csv")

pop_by_empstat <- df %>%
  group_by(EMPSTAT) %>% 
  summarize(
    POPULATION = sum(PERWT, na.rm=TRUE)
  )
```

This calcualtes the total population that is employed, unemployed, and not-in-labor-force. (e.g. It calculates the total population for each value of `EMPSTAT`.) The result is stored in a dataframe called `pop_by_empstat`.

---

## Non-Stratified Samples

### Overall average of a numeric variable

```r
rm(list=ls())

df <- read.csv("students.csv")

mean(df$test_score, na.rm=TRUE)
```

This calculates the overall average of `test_score`. The result is displayed to console.

---

### Average of a numeric variable by groups

```r
rm(list=ls())
library(dplyr)

df <- read.csv("students.csv")

scores_by_race <- df %>%
  group_by(race) %>%
  summarize(
    avg_score = mean(test_score, na.rm=TRUE)
  )
```

This calculates the average of `test_score` for each `race`. The result is stored in a dataframe called `scores_by_race`.

---

### Percent of the overall population that has a certain characteristic

```r
rm(list=ls())

df <- read.csv("students.csv")

df$IS_EXPERIMENTAL_COHORT <- df$cohort=="EXPERIMENTAL"

mean(df$IS_EXPERIMENTAL_COHORT, na.rm=TRUE)
```

This calculates the percent of students in the experimental cohort (`cohort=="EXPERIMENTAL"`). The result is displayed to console.

---

### Percent of a group that has a certain characteristic

```r
rm(list=ls())
library(dplyr)

df <- read.csv("students.csv")

df$IS_EXPERIMENTAL_COHORT <- df$cohort=="EXPERIMENTAL"

experimental_by_race <- df %>%
  group_by(race) %>%
  summarize(
    PCT_EXPERIMENTAL = mean(IS_EXPERIMENTAL_COHORT, na.rm=TRUE)
  )
```

This calculates the percent of students in the experimental cohort separately by the race of the student. The result is stored in a dataframe called `experimental_by_race`.

---

### Total number of observations

```r
rm(list=ls())

df <- read.csv("students.csv")

nrow(df)
```

This simply counts the number of rows, e.g. the number of observations, contained in `students.csv`. Since `students.csv` is not a stratified survey, there is no need to calculate how many population units are represented by the data.

The result is displayed to the console.

---

### Total number of observations by group

```r
rm(list=ls())
library(dplyr)

df <- read.csv("students.csv")

nobs_by_race <- df %>%
  group_by(race) %>% 
  summarize(
    num_obs = n()
  )
```

This counts the number of rows, e.g. the number of observations, for each race contained in the `race` variable. The result is stored in a dataframe called `nobs_by_race`.



