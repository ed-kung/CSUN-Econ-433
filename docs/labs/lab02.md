---
layout: default
title: 2. Introduction to R
parent: Labs
nav_order: 2
---

# Lab 2
{: .no_toc }

## Introduction to R
{: .no_toc }

In this lab you will be introduced to R, a programming language designed for statistical analysis.

[Why learn R?](/docs/vignettes/whyR/){:target="_blank"}

In this lab, you will:
- Sign up for an account on posit.cloud and learn how to use RStudio Cloud.
- Load data contained in a `.csv` file into R.
- Conduct basic data exploration tasks in R.

---

## Instructions

Follow along as I show the class how to conduct today's lab. 

If you followed along correctly, you should end up with the following script. The script shows you how to:
- Read data from a CSV file into R and store it in a dataframe.
- Display the variables inside a dataframe and their data types.
- Tabulate and show summary statistics for variables in a dataframe.
- Create new variables based on existing variables.

```r
rm(list=ls())   # Clear the workspace

# Read IPUMS_ACS2019_CA_1.csv and store it in df
df <- read.csv("IPUMS_ACS2019_CA_1.csv")

# Show the "structure" of the data
str(df)

# Tabulate SEX, MARST, and RACHSING
table(df$SEX)
table(df$MARST)
table(df$RACHSING)

# Show summary statistics for AGE and INCWAGE
summary(df$AGE)
summary(df$INCWAGE)

# Create a boolean variable called EMPLOYED 
# that is TRUE when the person is employed
# and FALSE otherwise
df$EMPLOYED <- (df$EMPSTAT==1)

# Create a boolean variable called WORKING_AGE
# that is TRUE when the person's AGE is 
# between 25 and 65 and FALSE otherwise
df$WORKING_AGE <- (df$AGE>=25) & (df$AGE<=65)

# Create a boolean variable called WORKING_AGE_EMPLOYED
# that is TRUE when the person's AGE is
# between 25 and 65 and the person is employed,
# and FALSE otherwise
df$WORKING_AGE_EMPLOYED <- (df$EMPLOYED==TRUE) & (df$WORKING_AGE==TRUE)

# Create a variable called LOG_INCWAGE that is
# equal to the log of INCWAGE
df$LOG_INCWAGE <- log(df$INCWAGE)

# Create a variable called BIRTH_YEAR that is 
# equal to YEAR minus AGE
df$BIRTH_YEAR <- df$YEAR - df$AGE

# Show structure of data again
str(df)

# Tabulate EMPLOYED, WORKING_AGE, and WORKING_ADULT
table(df$EMPLOYED)
table(df$WORKING_AGE)
table(df$WORKING_AGE_EMPLOYED)

# Show summary statistics of LOG_INCWAGE
summary(df$LOG_INCWAGE)
```

If you missed something during lecture, or if you need a refresher, you may find the following docs helpful:

- **Vignettes**: 
	- [RStudio basics](/docs/vignettes/rstudio-basics){:target="_blank"}
	- [Editing scripts](/docs/vignettes/editing-scripts){:target="_blank"} 
	- [Anatomy of an R command](/docs/vignettes/anatomy){:target="_blank"}
	- [Check your data!](/docs/vignettes/checking-data){:target="_blank"}
	- [Creating variables](/docs/vignettes/creating-variables){:target="_blank"}
- **Functions**: 
	- [rm(list=ls())](/docs/functions/rm-list-ls){:target="_blank"}
	- [read.csv](/docs/functions/read-csv){:target="_blank"}
	- [str](/docs/functions/str){:target="_blank"}
	- [table](/docs/functions/table){:target="_blank"}
	- [summary](/docs/functions/summary){:target="_blank"}
- **Glossary**: 
	- [dataframe](/docs/glossary/dataframe){:target="_blank"}
	- [variable](/docs/glossary/variable){:target="_blank"}
	- [data type](/docs/glossary/data-type){:target="_blank"}
	- [logical operator](/docs/glossary/logical-operator){:target="_blank"}

---

## Assignment

- Create a **new** script that accomplishes the following tasks:
    - Read `IPUMS_ACS2019_CA_1.csv` and store it in a dataframe called `df`.
    - Create a boolean variable called `UNEMPLOYED_WORKING_AGE_MALE` that is `TRUE` if the person is:
        - Unemployed (but in the labor force)
        - Between the ages of 25 and 65
        - Male
    - Create a boolean variable called `NLF_WORKING_AGE_MALE` that is `TRUE` if the person is:
        - Not in the labor force
        - Between the ages of 25 and 65
        - Male
    - Show the structure of the data after having created the above two variables
    - Tabulate `UNEMPLOYED_WORKING_AGE_MALE` and `NLF_WORKING_AGE_MALE`
    
    *Hint*: You'll need to look up the codes for `EMPSTAT` and `SEX` in IPUMS.
    
- Upload the script to the Lab 02 Assignment.

- Take the Lab 02 Quiz.

---

## Takeaways

- You can use RStudio Cloud.
- You can do the following basic tasks in R:
    - Read a CSV file into a dataframe
    - View and browse a dataframe
    - Show the structure of a dataframe
    - Identify the datatypes of variables inside a dataframe
    - Tabulate and summarize variables inside a dataframe
    - Create new variables in a dataframe
    - Use logical operators to create new boolean variables
- You understand the concept of data types









