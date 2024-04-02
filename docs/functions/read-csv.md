---
layout: default
title: read.csv
parent: Functions
---

# read.csv

---

## Usage

Used to read data from a CSV file and store that data in a dataframe. 

```r
named_object <- read.csv("filename.csv")
```

- The input must be the name of a CSV file in double quotation marks.
- The output is a dataframe containing the data in the CSV file.

---

## Example

```r
rm(list=ls())

df <- read.csv("IPUMS_ACS2019_CA_1.csv")
```

 
