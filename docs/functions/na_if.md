---
layout: default
title: na_if
parent: Functions
---

# na_if
{: .no_toc }

Requires `dplyr` package.

- TOC
{:toc}

---

## Usage

Used to assign `NA` to invalid values of a variable. This is required in order to compute accurate summary statistics.

Usage:
```r
dataframe$variable <- na_if(dataframe$variable, invalid_value)
```

- Replaces all instances of `invalid_value` in `dataframe$variable` with `NA`.

---

## Example

```r
rm(list=ls())
library(dplyr)

df <- read.csv("IPUMS_ACS2019_CA_1.csv")

df$INCWAGE <- na_if(df$INCWAGE, 999999)
df$INCWAGE <- na_if(df$INCWAGE, 999998)
```

This code replaces all instances of `999999` and `999998` in `df$INCWAGE` with `NA`.

