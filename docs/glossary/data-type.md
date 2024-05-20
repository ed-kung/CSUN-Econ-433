---
layout: default
title: data type
parent: Glossary
---

# data type
{: .no_toc }

**data type** is a very important concept in data science. Every variable has its own data type. The data type tells R what kind of data the variable is meant to represent.

- TOC
{:toc}

## Common data types

| Data type | Name in R | Other names         | Meaning                            | Examples              |
| :-------- | :-------- | :------------------ | :--------------------------------- | :-------------------- |
| integer   | `int`     |                     | Positive or negative whole numbers | -3, 0, 1, 400         |
| numeric   | `num`     | float, double       | All numbers including decimals     | -3.14, 0, 1.2313, 100 |
| boolean   | `logi`    | binary, dichotomous | TRUE/FALSE and 1/0 variables       | TRUE, FALSE, 1, 0     |
| string    | `chr`     | character           | Text                               | "public", "economics" |
| date      | `Date`    |                     | A date or time                     | `3/31/2024 12:14:00`  |
| factor    | `factor`  | categorical         | A variable that can be one of a fixed number of possibilities | "WHITE", "BLACK", "ASIAN", "HISPANIC", "OTHER" |

## Why data types are important

Data types are important because they tell R how the variable should behave under different circumstances.

For example, integer and numeric data can be added, subtracted, multiplied, divided, and compared. Dates and times can be subtracted (to get the time between two events), but not added, multiplied, or divided. Strings and categoricals cannot be added, subtracted, multiplied, or divided at all.

Boolean variables have a special set of operations that can be applied to them, called logical operators. See [here](/docs/glossary/logical-operator) for more detail.

## Converting from one data type to another

To convert variable `var` in dataframe `df` to a different datatype:

- Convert to integer: `df$var <- as.integer(df$var)`
- Convert to numeric: `df$var <- as.numeric(df$var)`
- Convert to boolean: `df$var <- as.logical(df$var)`
- Convert to string: `df$var <- as.character(df$var)`
- Convert to date: `df$var <- as.Date(df$var)`
- Convert to factor: `df$var <- as.factor(df$var)`

In this class, you'll probably only ever have to convert a variable from integer or string to factor.






