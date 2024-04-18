---
layout: default
title: inner_join
parent: Functions
---

# inner_join
{: .no_toc }

Requires `dplyr` package.

- TOC
{:toc}

---

## Usage

Used to combine two dataframes horizontally into a new dataframe. The dataframes are combined by matching the rows that have the same values on one or more identifier, or "key" variables.

This procedure is called *merging* two dataframes. It can also be called *joining*.

Usage:

```r
some_dataframe_name <- inner_join(dataframe1, dataframe2, by=c(...))
```

- The first and second inputs must both be dataframes.
- The third input must be `by=c(...)`, with `...` being the names of the variables you want to match on. 
    - The variables names should be contained in double quotation marks, and separated by commas. (See examples below.)
- The output is a dataframe that combines the two input dataframes "horizontally". It will include all the variables from both dataframes.

{: .warning}
> If you store the output in an object with the same name as one of the input dataframes, you will overwrite it. This causes data loss, so you should avoid doing this!

{: .note }
> If more than one row in `dataframe1` match a row in `dataframe2` (or vice versa), then all of those rows are matched and kept in the output dataframe.

The purpose of an inner join is to combine two datasets that contain different pieces of information about the same set of subjects. For example, one dataset contains crime data about a set of neighborhoods, and another dataset contains housing data about the same neighborhoods.


---

## Example 1

```r
rm(list=ls())

df_1 <- read.csv("IPUMS_ACS2019_CA_1.csv")
df_2 <- read.csv("IPUMS_ACS2019_CA_2.csv")

df <- inner_join(df_1, df_2, by=c("YEAR", "SERIAL", "PERNUM"))
```

---

## Example 2

Suppose `df_students` contains the following data:

| STUDENT_ID | CLASS_ID | TEST_SCORE |
| ---------: | -------: | ---------: |
|          1 |        A |         80 |
|          2 |        B |         70 |
|          3 |        B |         90 |
|          4 |        C |         40 |
|          5 |        A |        100 |
|          6 |        C |         70 |

And suppose `df_classes` contains:

| CLASS_ID | AVERAGE_SCORE |
| -------: | ------------: |
|        A |          74.5 |
|        B |          80.4 |
|        C |          67.3 |

If you ran:

```r
df_merged <- inner_join(df_students, df_classes, by=c("CLASS_ID"))
```

Then `df_merged` will contain:

| STUDENT_ID | CLASS_ID | TEST_SCORE | AVERAGE_SCORE |
| ---------: | -------: | ---------: | ------------: |
|          1 |        A |         80 |          74.5 |
|          2 |        B |         70 |          80.4 |
|          3 |        B |         90 |          80.4 |
|          4 |        C |         40 |          67.3 |
|          5 |        A |        100 |          74.5 |
|          6 |        C |         70 |          67.3 |

---

## Other types of joins

There are other types of joins, including `left_join`, `right_join`, and `outer_join`. However, we won't need to use them in this class. 
