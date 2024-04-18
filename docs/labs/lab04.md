---
layout: default
title: 4. Data Wrangling
parent: Labs
nav_order: 4
---

# Lab 4
{: .no_toc }

## Data Wrangling
{: .no_toc }

In this lab you will learn how to perform some common data operations in R.

Specifically, you will learn to do the following:
- Install and load packages in R
- Merge two dataframes together (combine data horizontally by finding rows that match on key variables)
- Append two dataframes together (combine data vertically)
- Write a dataframe to a CSV file
- Filter a dataframe (select only the rows that meet a condition)

## Preparation

Before starting the lab, you should download these files from Canvas and upload them to your R Studio Cloud environment.
- `IPUMS_ACS2019_CA_1.csv`
    - Contains basic geographic and demographic information for people in California in 2019
- `IPUMS_ACS2019_CA_2.csv`
	- Contains additional education and occupational information for people in California in 2019
- `IPUMS_ACS2014_CA_1.csv`
    - Contains basic geographic and demographic information for people in California in 2014
- `IPUMS_ACS2014_CA_2.csv`
	- Contains additional education and occupational information for people in California in 2014

You'll also need to [install some packages](/docs/vignettes/installing-packages){:target="_blank"}. A package is a collection of functions and tools that expands R's baseline functionality. Packages are written by authors and developers from around the world, and are made available for free on [CRAN](https://cran.r-project.org/){:target="_blank"} (the Comprehensive R Archive Network).

Today you'll need to install the package called `dplyr`. To do so, type the following into your console and hit `ENTER`:

```r
install.packages("dplyr")
```

## Instructions

Follow along as I show the class how to conduct today's lab. 

If you followed along correctly, you should end up with the following script. The script does the following:
- Clear the workspace and load the required libraries.
- Read the two 2019 CSV files into dataframes, then merge them into a single 2019 dataframe.
- Read the two 2014 CSV files into dataframes, then merge them into a single 2014 dataframe.
- Append the 2014 and 2019 dataframes together.
- Save the resulting dataframe into a CSV file called `IPUMS_ACS_CA_2014_2019.csv`.
- Use the resulting dataframe to calculate the following statistics:
	- Percent of white people aged 25+ that are college educated in 2014
	- Percent of black people aged 25+ that are college educated in 2014
	- Percent of white people aged 25+ that are college educated in 2019
	- Percent of black people aged 25+ that are college educated in 2019

```r
rm(list=ls())   # Clear the workspace
library(dplyr)  # Load the packages
#(If dplyr is not installed, run install.packages("dplyr") from the console first)

# Read the 2019 CSV files and merge them
df_2019_1 <- read.csv("IPUMS_ACS2019_CA_1.csv")
df_2019_2 <- read.csv("IPUMS_ACS2019_CA_2.csv")
df2019 <- inner_join(df_2019_1, df_2019_2, by=c("YEAR","SERIAL","PERNUM"))

# Read the 2014 CSV files and merge them
df_2014_1 <- read.csv("IPUMS_ACS2014_CA_1.csv")
df_2014_2 <- read.csv("IPUMS_ACS2014_CA_2.csv")
df2014 <- inner_join(df_2014_1, df_2014_2, by=c("YEAR","SERIAL","PERNUM"))

# Append the 2014 and 2019 dataframes
df <- rbind(df2014, df2019)

# Show the structure of the resulting dataframe
str(df)

# Save the resulting dataframe
write.csv(df, "IPUMS_ACS_CA_2014_2019.csv", row.names=FALSE)

# Create a variable indicating 4+ years of college
df$COLLEGE <- df$EDUC>=10

# Calculate the percent of white people aged 25+ that are college
# educated in 2014
# ---------------------------------------------------------------
df_white_adult_2014 <- filter(df, RACHSING==1 & AGE>=25 & YEAR==2014)
weighted.mean(df_white_adult_2014$COLLEGE, df_white_adult_2014$PERWT)

# Calculate the percent of black people aged 25+ that are college
# educated in 2014
# ---------------------------------------------------------------
df_black_adult_2014 <- filter(df, RACHSING==2 & AGE>=25 & YEAR==2014)
weighted.mean(df_black_adult_2014$COLLEGE, df_black_adult_2014$PERWT)

# Calculate the percent of white people aged 25+ that are college
# educated in 2019
# ---------------------------------------------------------------
df_white_adult_2019 <- filter(df, RACHSING==1 & AGE>=25 & YEAR==2019)
weighted.mean(df_white_adult_2019$COLLEGE, df_white_adult_2019$PERWT)

# Calculate the percent of black people aged 25+ that are college
# educated in 2019
# ---------------------------------------------------------------
df_black_adult_2019 <- filter(df, RACHSING==2 & AGE>=25 & YEAR==2019)
weighted.mean(df_black_adult_2019$COLLEGE, df_black_adult_2019$PERWT)
```

If you missed something during lecture, or if you need a refresher, you may find the following docs helpful:

- **Vignettes**: 
	- [Installing packages](/docs/vignettes/installing-packages){:target="_blank"}
- **Functions**: 
	- [inner_join](/docs/functions/inner_join){:target="_blank"}
	- [rbind](/docs/functions/rbind){:target="_blank"}
	- [write.csv](/docs/functions/write-csv){:target="_blank"}
	- [filter](/docs/functions/filter){:target="_blank"}

---

## Assignment

For this assignment, you will need to download `students.csv` and `classes.csv` and upload them to your R Studio Cloud environment.

`students.csv` is a csv file where each row represents a student. The file has the following columns:

- `student_id`: the unique id number of the student
- `class_id`: the id number of the classroom the student is in
- `school_id`: the id number of the school the student is in
- `test_score`: the student's standardized test score
- `family_income`: the student's annual family income
- `race`: the student's race; possible values are "BLACK", "WHITE", "HISPANIC", and "ASIAN".
- `cohort`: whether the student was assigned to the experimental or regular cohort (more information below.)

`classes.csv` is a csv file where each row represents a classroom. The file has the following columns:

- `class_id`: the unique id number of the classroom
- `school_id`: the unique id number of the school
- `class_size`: an indicator for whether the class is small or large
- `teacher_has_ma`: an indicator for whether the classroom's teacher has a Master's degree.

**Assignment instructions**

- Create a new script that accomplishes the following tasks:
	- Read `students.csv` and `classes.csv` into two dataframes in R.
	- Merge those dataframes on the variables `class_id`, `school_id`. Call the merged dataframe `df`.
	- Save `df` as a CSV file called `students_classes_merged.csv`.
	- Create a new dataframe called `df_experimental` which filters `df` on `cohort=="EXPERIMENTAL"`.
	- Tabulate the `class_size` variable in `df_experimental`.

- Upload the script to the Lab 04 Assignment.

- Take the Lab 04 Quiz.

---

## Takeaways

- You can perform the following data operations in R:
	- Filtering (`filter`)
	- Appending (`rbind`)
	- Merging (`inner_join`)
	- Saving data to CSV (`write.csv`)

