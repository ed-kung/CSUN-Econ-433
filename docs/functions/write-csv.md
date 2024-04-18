---
layout: default
title: write.csv
parent: Functions
---

# read.csv
{: .no_toc }

- TOC
{:toc}

---

## Usage

Used to write data from a dataframe to a CSV file. 

Usage:
```r
write.csv(dataframe, "filename.csv", row.names=FALSE)
```

- The first input is the name of the dataframe you want to save as a CSV file
- The second input is the filename you want to save the data to
- For this class, we'll always include `row.names=FALSE` as the third input. This avoids writing an extraneous column to the CSV file.

---

## Example

```r
rm(list=ls())

df_1 <- read.csv("IPUMS_ACS2019_CA_1.csv")
df_2 <- read.csv("IPUMS_ACS2019_CA_2.csv")

merged_df <- inner_join(df_1, df_2, by=c("YEAR","SERIAL","PERNUM"))

write.csv(merged_df, "IPUMS_ACS2019_CA_ALL.csv", row.names=FALSE)
```

