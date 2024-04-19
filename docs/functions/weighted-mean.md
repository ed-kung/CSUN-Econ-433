---
layout: default
title: weighted.mean
parent: Functions
---

# weighted.mean
{: .no_toc }

- TOC
{:toc}

---

## Usage

Used to calculate the weighted mean of a variable.

**Usage 1:**
```r
weighted.mean(dataframe$variable, dataframe$weights, na.rm=TRUE)
```
- This calculates the weighted mean of `variable` in `dataframe` using `weights` as weights.  
- We always include `na.rm=TRUE` as the third input to tell R to remove any `NA` values from the calculation.

**Usage 2:**
```r
some_dataframe_name <- dataframe %>%
  group_by(groupvar1, groupvar2, ...) %>%
  summarize(
    avg_variable = weighted.mean(variable, weights, na.rm=TRUE)
  )
```

- This calculates the weighted mean of `variable` in `dataframe` within each possible combination of values for `groupvar1`, `groupvar2`, ...
- See the vignette on [summary statistics](/docs/vignettes/summary-statistics) for more details

---

## Example 1

```r
rm(list=ls())

df <- read.csv("IPUMS_ACS2019_CA_1.csv")

weighted.mean(df$AGE, df$PERWT, na.rm=TRUE)
```

This calculates the weighted mean of `AGE` in `df` using `PERWT` as weights.

---

## Example 2

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

This calculates the weighted mean of `EMPLOYED` (e.g. the employment rate) within each value of `RACHSING` (e.g. by race), using `PERWT` as the weights.

---

## Mathematical Background

Suppose you have $$N$$ samples of a variable:

$$
(x_1, x_2, x_3, \ldots, x_N)
$$

Along with $$N$$ weights:

$$
(w_1, w_2, w_3, \ldots, w_N)
$$

The weighted mean of $$x$$ using $$w$$ as weights is:

$$
\frac{ \sum_{i=1}^{N} x_i w_i }{ \sum_{i=1}^{N} w_i }
$$

