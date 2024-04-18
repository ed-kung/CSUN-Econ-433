---
layout: default
title: rbind
parent: Functions
---

# rbind
{: .no_toc }

- TOC
{:toc}

---

## Usage

Used to combine two dataframes vertically into a new dataframe. This procedure is also sometimes known as *appending* two dataframes.

Usage:
```r
some_dataframe_name <- rbind(dataframe1, dataframe2)
```

- The first and second inputs must both be dataframes.
- The output is a dataframe that combines the two input dataframes "vertically".
- The input dataframes should contain the same variable/column names.

{: .warning}
> If you store the output in an object with the same name as one of the input dataframes, you will overwrite it. (e.g. `df <- rbind(df, another_df)`) This causes data loss, so you should avoid doing this!

---

## Example

```r
rm(list=ls())

df_2014 <- read.csv("IPUMS_ACS2014_CA_1.csv")
df_2019 <- read.csv("IPUMS_ACS2019_CA_1.csv")

df <- rbind(df_2014, df_2019)
```

