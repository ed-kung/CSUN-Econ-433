---
layout: default
title: Creating variables
parent: Vignettes
nav_order: 5
---

# Creating variables
{: .no_toc }

- TOC
{:toc}

---

## Basic command to create a variable

To create a new variable called `new_variable` inside a dataframe called `df`:

```r
df$new_variable <- ...
```

Replace the `...` with the formula you want to use to define the new variable.

{: .warning}
> If you try to create a new variable using the name of an existing variable, you will overwrite the existing variable with the new variable. Since this causes data loss, you should almost never do this!

---

## Creating a boolean variable

One of the most common things you'll do in this class is to create boolean variables that indicate whether some condition in the data is true.

For example, in IPUMS, the variable `EMPSTAT` is equal to `1` if the person is employed.

To create a boolean variable called `EMPLOYED` that is TRUE if the person is employed and FALSE otherwise, you can do this:

```r
df$EMPLOYED <- df$EMPSTAT==1
```

See [here](/docs/glossary/logical-operator) for a more detailed explanation of logical operators.

---

## Creating a variable with mathematical expressions

Sometimes, we need to take the log of a variable. To do this, we can create a new variable that is equal to the log of another variable:

```r
df$LOG_INCWAGE <- log(df$INCWAGE)
```

{: .note}
> We could have chosen any name for the new variable. `df$foo <- log(df$INCWAGE)` would have done the same thing, just naming the variable `foo` instead of `LOG_INCWAGE`.

We can create variables using arbitrary mathematical operations. For example, suppose the year of the survey is contained in the variable `YEAR` and the age of the person is contained in the variable `AGE`. The person's birth year is equal to `YEAR - AGE`, so we can create a variable called `BIRTH_YEAR` like this:

```r
df$BIRTH_YEAR <- df$YEAR - df$AGE
```

---

## Operations work row-by-row

When creating a variable, the operations are performed row-by-row. For example, `df$BIRTH_YEAR <- df$YEAR - df$AGE` calculates `YEAR - AGE` for each row and puts it in the corresponding row of `BIRTH_YEAR`.

**Example:**

Suppose the dataframe called `df` contains the following data:

| ID | EMPSTAT | INCWAGE | YEAR | AGE |
| -: | ------: | ------: | ---: | --: |
|  1 |       1 | 100000  | 2019 | 30  |
|  2 |       3 | 0       | 2019 | 40  |
|  3 |       2 | 20000   | 2019 | 25  |
|  4 |       1 | 80000   | 2019 | 50  |

If you run:

```r
df$EMPLOYED <- df$EMPSTAT==1
df$LOG_INCWAGE <- log(df$INCWAGE)
df$BIRTH_YEAR <- df$YEAR - df$AGE 
```

Then after running these commands, `df` will contain:

| ID | EMPSTAT | INCWAGE | YEAR | AGE | EMPLOYED | LOG_INCWAGE | BIRTH_YEAR |
| -: | ------: | ------: | ---: | --: | -------: | ----------: | ---------: |
|  1 |       1 | 100000  | 2019 | 30  |     TRUE |      11.513 |       1989 |
|  2 |       3 | 0       | 2019 | 40  |    FALSE |          NA |       1979 |
|  3 |       2 | 20000   | 2019 | 25  |    FALSE |       9.903 |       1994 |
|  4 |       1 | 80000   | 2019 | 50  |     TRUE |      11.290 |       1969 |











