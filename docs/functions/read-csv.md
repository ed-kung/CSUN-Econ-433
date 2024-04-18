---
layout: default
title: read.csv
parent: Functions
---

# read.csv
{: .no_toc }

- TOC
{:toc}

---

## Usage

Used to read data from a CSV file and store that data in a dataframe. 

Usage:
```r
some_dataframe_name <- read.csv("filename.csv")
```

- The input must be the name of a CSV file in double quotation marks.
- The output is a dataframe containing the data in the CSV file.

---

## Example

```r
rm(list=ls())

df <- read.csv("IPUMS_ACS2019_CA_1.csv")
```

---

## Note about reading multiple files

If you need to read more than one CSV file, make sure you store them in objects with different names!  If you don't, you'll end up overwriting your data.

**Bad example:**

```r
# (This is example of bad code. You end up overwriting the data in df)
df <- read.csv("IPUMS_ACS2019_CA_1.csv")
df <- read.csv("IPUMS_ACS2019_CA_2.csv")
```

**Good example:**

```r
# (Instead, do this)
df_1 <- read.csv("IPUMS_ACS2019_CA_1.csv")
df_2 <- read.csv("IPUMS_ACS2019_CA_2.csv")
```

