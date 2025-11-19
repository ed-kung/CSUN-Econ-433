---
layout: default
title: 6. Linear Regressions I
parent: Labs
nav_order: 6
---

# Lab 6
{: .no_toc }

## Linear Regressions I
{: .no_toc }

In this lab, you will learn how to estimate linear models in R and to present and interpret the results.

---

## Preparation

You should already have `IPUMS_ACS_CA_2018_2023.csv` in your R Studio Cloud files directory. If you don't have this file, check the instructions for [Lab 4](/CSUN-Econ-433/docs/labs/lab04).

You'll also need the packages:
- `dplyr`
- `lfe`
- `stargazer`

`lfe` is a package with tools for running regressions with a large number of dummy variables.

`stargazer` is a package with tools for displaying regression results in a visually appealing way.

---

## Instructions

Follow along as I show the class how to conduct today's lab. If you followed along correctly, you should end up with the following script.

This script uses regressions to estimate the gender wage gap, using data from California in 2023. In the script, we show how the addition of more and more variables to the regression changes the estimated gender wage gap.

```r
rm(list=ls())   # Clear workspace
library(dplyr)  # Load required libraries
library(stargazer)
library(lfe)

# Load the main data
df <- read.csv("IPUMS_ACS_CA_2018_2023.csv")

# Deal with invalid values for INCWAGE and EMPSTAT
df$INCWAGE <- na_if(df$INCWAGE, 999999)
df$INCWAGE <- na_if(df$INCWAGE, 999998)

# Create a boolean variable indicating the person
# is female
df$FEMALE <- df$SEX==2

# Create a boolean variable indicating if the person
# is married
df$MARRIED <- df$MARST==1 | df$MARST==2

# Create a boolean variable indicating the person
# has 4+ years of college education
df$COLLEGE <- df$EDUC>=10

# Create booleans for race 
df$WHITE <- df$RACWHT==2
df$BLACK <- df$RACBLK==2
df$ASIAN <- df$RACASIAN==2
df$HISPANIC <- df$HISPAN>=1

# The data we want to the regression on:
# employed people in 2023, with positive income
regdf <- df %>% filter(YEAR==2023 & INCWAGE>0 & EMPSTAT==1)

# Regress log(INCWAGE) on FEMALE
r1 <- felm(
  log(INCWAGE) ~ FEMALE, 
  data=regdf, 
  weights=regdf$PERWT
)

# Regress log(INCWAGE) on FEMALE, COLLEGE, MARRIED, AGE
r2 <- felm(
  log(INCWAGE) ~ FEMALE + COLLEGE + MARRIED + AGE, 
  data=regdf,
  weights=regdf$PERWT
)

# Regress log(INCWAGE) on FEMALE, COLLEGE, MARRIED, AGE
# and RACHSING (treat RACHSING as a factor variable!)
r3 <- felm(
  log(INCWAGE) ~ FEMALE + COLLEGE + MARRIED + AGE + 
    WHITE + BLACK + ASIAN + HISPANIC, 
  data=regdf,
  weights=regdf$PERWT
)

# Regress log(INCWAGE) on FEMALE, COLLEGE, MARRIED, AGE
# R, and OCC and IND (treat OCC and IND as 
# large dummy variables)
r4 <- felm(
  log(INCWAGE) ~ FEMALE + COLLEGE + MARRIED + AGE + 
    WHITE + BLACK + ASIAN + HISPANIC | OCC + IND,
  data=regdf,
  weights=regdf$PERWT
)

# Regress log(INCWAGE) on FEMALE, COLLEGE, MARRIED, AGE
# RACHSING, OCC, IND, and log(UHRSWORK)
r5 <- felm(
  log(INCWAGE) ~ FEMALE + COLLEGE + MARRIED + AGE + 
    WHITE + BLACK + ASIAN + HISPANIC + log(UHRSWORK) | OCC + IND,
  data=regdf,
  weights=regdf$PERWT
)

# Show the regression results
stargazer(r1, r2, r3, r4, r5, type="text")
```

---

## Assignment

- Create a new script that does the same 5 regressions as above, except:
  - It uses data from California 2018 instead of 2023.
  - Include a new variable, `AGESQ`, which is equal to the square of `AGE`, in regressions `r2` thru `r5`. 
      - *Hint:* To take a square in R, do `df$AGESQ <- df$AGE**2`
  - Include dummy variables for `COUNTYFIP` in `r4` and `r5`.

- Hint: You should start by copy and pasting the original script, then making the necessary modifications

- Show me your script and output to receive your grade and be dismissed. If you aren't able to complete the assignment in class, you can upload the script to the Lab 06 Script assignment.

---

## Takeaways

- You can estimate linear models, including with a large set of dummy variables, using `felm` in R.
- You know how to show regression results in a visually appealing way using `stargazer`.
- You can interpret regression results.
- You can explain why coefficient estimates change when new variables are added to the regression.


