---
layout: default
title: filter
parent: Functions
---

# filter
{: .no_toc }

Requires `dplyr` package.

- TOC
{:toc}

---

## Usage

Used to select only the rows of a dataframe that match a condition.

```r
named_object <- filter(dataframe, condition)
```

- The first input must be a dataframe.
- The second input is a condition.
- The output is a dataframe that contains only the rows that match the condition.

{: .warning}
> If you store the output in an object with the same name as the input dataframe, you will overwrite the input dataframe. (e.g. `df <- filter(df, EMPSTAT==1)`) This causes data loss, so you should avoid doing this!

---

## Example

```r
rm(list=ls())

df <- read.csv("IPUMS_ACS2019_CA_1.csv")

df_employed <- filter(df, EMPSTAT==1)
```

In this examples, only the rows with `EMPSTAT==1` (employed individuals) are kept in the dataframe `df_employed`.

---

## Detailed example

Suppose dataframe `df` contains the following data:

| ID | EMPSTAT | SEX |
| -: | ------: | --: |
|  1 |       1 |   1 |
|  2 |       3 |   2 |
|  3 |       2 |   1 |
|  4 |       1 |   2 |
|  5 |       1 |   1 |
|  6 |       2 |   2 |

If you ran the command:

```r
df_employed_males <- filter(df, EMPSTAT==1 & SEX==1)
```

Then `df_employed_males` will contain:

| ID | EMPSTAT | SEX |
| -: | ------: | --: |
|  1 |       1 |   1 |
|  5 |       1 |   1 |

---

## A common error

Be careful when using `filter`. It's easy to create a condition which causes it to return zero rows.

For example, suppose `df` contains the following data, and we want to select the people with `EMPSTAT==1` and the people with `EMPSTAT==2`.

| ID | EMPSTAT | SEX |
| -: | ------: | --: |
|  1 |       1 |   1 |
|  2 |       3 |   2 |
|  3 |       2 |   1 |
|  4 |       1 |   2 |
|  5 |       1 |   1 |
|  6 |       2 |   2 |


Students will commonly write something like this:

```r
# (This is an example of bad code)
filtered_df <- filter(df, EMPSTAT==1 & EMPSTAT==2)
```

But if you did this, then `filtered_df` will contain zero rows.  This is because a row cannot have both `EMPSTAT==1` AND `EMPSTAT==2`, so no rows match the condition.

The correct way to select the people with `EMPSTAT==1` and the people with `EMPSTAT==2` is this:

```r
# (This is the correct way to select people with EMPSTAT==1 or EMPSTAT==2)
filtered_df <- filter(df, EMPSTAT==1 | EMPSTAT==2)
```

This makes use of the OR operator (`|`) instead of the AND operator (`&`). It requests rows where `EMPSTAT==1` OR `EMPSTAT==2`.  The resulting dataframe will contain:

| ID | EMPSTAT | SEX |
| -: | ------: | --: |
|  1 |       1 |   1 |
|  3 |       2 |   1 |
|  4 |       1 |   2 |
|  5 |       1 |   1 |
|  6 |       2 |   2 |




 



