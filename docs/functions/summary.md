---
layout: default
title: summary
parent: Functions
---

# summary

---

## Usage

Used to show summary statistics of a variable in a dataframe.

```r
summary(dataframe$variable)
```

- The input should be a variable in a dataframe.
- We usually don't store the output, and display it to console instead.
- The behavior of summary depends on the variable's data type:
    - For integer and numeric variables, the mean, median, and percentiles will be shown.
    - For factor variables, a table will be shown, showing how many rows have each possible value of the variable.

---

## Example

```r
rm(list=ls())

df <- read.csv("IPUMS_ACS2019_CA_1.csv")

summary(df$INCWAGE)
```

 
