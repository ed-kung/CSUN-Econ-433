---
layout: default
title: str
parent: Functions
---

# str

---

## Usage

Used to show the structure of a dataframe. The following information is reported:
- The number of rows (observations)
- The number of columns (variables)
- For each variable:
    - The name of the variable
    - The data type of the variable
    - The first few rows of the variable

Usage:
```r
str(dataframe)
```

- The input should be a dataframe.
- We usually don't store the output, and display it to console instead.

---

## Example

```r
rm(list=ls())

df <- read.csv("IPUMS_ACS2019_CA_1.csv")

str(df)
```

 
