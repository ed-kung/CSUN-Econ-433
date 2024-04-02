---
layout: default
title: Anatomy of a R command
parent: Vignettes
nav_order: 4
---

# Anatomy of a R command
{: .no_toc }

- TOC
{:toc}

---

## Basic Anatomy

Almost every R command you run will look like either:

```r
named_object <- function(input_1, input_2, ...)
```

or

```r
function(input_1, input_2, ...)
```

---

## What is a function?

A function takes one or more inputs (sometimes it can even take zero inputs), and returns an output.

The output can be almost anything. It could be a [dataframe](/docs/glossary/dataframe), a [variable](/docs/glossary/variable), a number, a [dataframe](/docs/glossary/regression), or almost anything else.


---

## Commands that store output in a named object

Commands that store output in a named object look like this:

```r
named_object <- function(input_1, input_2, ...)
```

This command runs the function with the inputs you give it, then it stores the output in `named_object`. You can give this object any name you want.

**Example**

```r
my_dataframe <- read.csv("my_file.csv")
```

- This command reads the data from a CSV file called "my_file.csv", returns it as a dataframe, and stores that dataframe in `my_dataframe`. 
- `read.csv` is the function.
- `"my_file.csv"` is the input to the function.
- `my_dataframe` is the name of the object you're storing the dataframe in.

See my documentation on [read.csv](/docs/functions/read-csv/) for more info.


---

## Commands that don't store output

Commands that don't store output look like this:

```r
function(input_1, input_2, ...)
```

This command runs the function with the inputs you give it, but the output is not stored anywhere. Instead, the output will be displayed directly in the console.

**Example**

```r
summary(my_dataframe$my_variable)
```

- This command shows summary statistics for the variable `my_variable` in the dataframe `my_data`.
- `summary` is the function.
- `my_dataframe$my_variable` is the input to the function.
- Since you did not tell R to store the output anywhere, the output gets displayed in the console.

See my documentation on [summary](/docs/functions/summary) for more info.

