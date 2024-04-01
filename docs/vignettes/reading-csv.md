---
layout: default
title: Reading CSV files
parent: Vignettes
nav_order: 4
---

# Reading CSV files
{: .no_toc }

- TOC
{:toc}

---

## Basic command

```r
df <- read.csv("filename.csv")
```

Notes:
- `read.csv` is the name of the command
- The filename needs to be surrounded by quotation marks
- `df` here is just the name you want to give to the dataframe. You could have called it anything. For example, `foo <- read.csv("filename.csv")` also could have worked. It would store the data in a dataframe called `foo` instead of `df`.

---

## Reading multiple files

R can read from multiple different CSV files and store them in different dataframes. Example:

```r
df1 <- read.csv("first_file.csv")
df2 <- read.csv("second_file.csv")
df3 <- read.csv("third_file.csv")
```

You can thus reference the data in each file by `df1`, `df2`, and `df3`, respectively.

Notes:
- Make sure you use different names for each dataframe. If you use the same name, the old dataframe will get overwritten.

