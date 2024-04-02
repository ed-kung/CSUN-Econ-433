---
layout: default
title: table
parent: Functions
---

# table

---

## Usage

Used to tabulate a variable in a dataframe.  (It shows how many rows contain each possible value of the variable.)

```r
table(dataframe$variable)
```

- The input should be a variable in a dataframe.
- We usually don't store the output, and display it to console instead.

---

## Example

```r
rm(list=ls())

df <- read.csv("IPUMS_ACS2019_CA_1.csv")

table(df$EMPSTAT)
```

 
