---
layout: default
title: 1. Introduction to IPUMS
parent: Labs
nav_order: 1
---

# Lab 1
{: .no_toc }

## Introduction to Public Datasets with IPUMS
{: .no_toc }

In this lab you'll be introduced to a public dataset repository known as [IPUMS](https://usa.ipums.org/usa/){:target="_blank"} (Integrated Public Use Microdatasets). 

From this repository, you can download [microdata](/CSUN-Econ-433/docs/glossary/microdata){:target="_blank"} from the U.S. Decennial Census and the American Community Survey (ACS).

The Census and the ACS are two of the main surveys researchers use to track U.S. demographic data over time. The data is useful for both marketing and policy research.

### Outline
{: .no_toc }
- TOC
{:toc}


## Instructions

I will walk you through the process of signing up for IPUMS and downloading ACS microdata for the state of California in 2019.

### Account Creation

- Go to [www.ipums.org](https://ipums.org){:target="_blank"}.
- Click on the `IPUMS USA` logo.
- Click `REGISTER` on the top-right corner.
- Click `Apply for Access` and fill out the form. For occupation category, select "undergraduate student". For specific occupation title, select "student". For field of research, select "economics". Under general research statement, type "I will use this data to study the gender wage gap" because that will be one of our exercises. For "How did you learn about this database?", select "Teacher or professor". Click all the required boxes and click "SUBMIT".
- Wait until you receive account access, then log in once you do. 

### Browsing Variables

Before creating a data extract, let's take a look around IPUMS first.

- Go back to [https://usa.ipums.org/usa/](https://usa.ipums.org/usa/){:target="_blank"} and click `Get Data`. You will be taken to the IPUMS data selection interface. Here you can select the variables you want to include in your data.  You can also find more information about each variable.

- In the `HOUSEHOLD` dropdown menu, click `TECHNICAL`. Click on the variable named `SERIAL` and read the description. `SERIAL` is the identification number for a household in the survey.

- Go back to the variable selection screen. In the `PERSON` dropdown menu, click `TECHNICAL`, then click on `PERNUM` and read the description. `PERNUM` is a unique number for each person within a single household.  

{: .blue-callout-title }
> Note
> 
> In each IPUMS sample, the combination of the two variables `SERIAL` and `PERNUM` uniquely identify each person in the survey. `SERIAL` uniquely identifies the household a person belongs to, and each person in the household receives a separate `PERNUM`.

- Go back and read the description for `EDUC` in `PERSON` -> `EDUCATION`. `EDUC` shows the education level of an individual. While still in the information screen for `EDUC`, click `CODES` to look at the meaning of the codes for the variable `EDUC`.

{: .green-callout-title }
> Question
> 
> How would we use `EDUC` to find people who have 4 or more years of college?

### Selecting Variables

Now that you know how to navigate the variable selection screen, you are ready to create a data extract.

The first step is to select the variables you want to include.

- In the `HOUSEHOLD` dropdown menu, click `TECHNICAL`. Notice that the variables `YEAR`, `MULTYEAR`, `SAMPLE`, `SERIAL`, `CBSERIAL`, `HHWT`, `CLUSTER`, and `STRATA` have a label that says "preselected" next to them. These variables are always automatically selected.

- In the `PERSON` dropdown menu, click `TECHNICAL`. Notice that `PERNUM` and `PERWT` are preselected. 

- Go to `HOUSEHOLD`->`GEOGRAPHIC` and click the `+` symbol under "Add to cart" for the variables `STATEFIP` and `COUNTYFIP`. These variables tell us the state and county that the household is located.

- Go to `PERSON`->`DEMOGRAPHIC` and click on the `+` symbol for the variables: `SEX`, `AGE`, and `MARST`. These variables will tell us the individual's sex, age, and marital status.

- Go to `PERSON`->`RACE, ETHNICITY, and NATIVITY` and add `RACHSING`. This variable tells us the individual's race.

- Go to `PERSON`->`EDUCATION` and add `EDUC`. This variable tells us the individual's educational attainment.

- Go to `PERSON`->`WORK` and add `EMPSTAT` to the cart. This variable tells us the person's employment status.

- Go to `PERSON`->`INCOME` and add `INCWAGE` to the cart. This variable tells us the person's wage and salary income.

### Creating the Extract

We're done selecting variables! Now, let's tell IPUMS that we only want data from California in 2019.

- On the main data selection screen, click `SELECT SAMPLES`.

- Uncheck `Default sample from each year`. Check `ACS` for the year 2019. Make sure that's the only box you have checked.  Then click `SUBMIT SAMPLE SELECTIONS`.

- Your data cart should say `11 VARIABLES` and `1 SAMPLE`. Click `VIEW CART` to review your variable and sample selections, then click `CREATE DATA EXTRACT`.

By default, IPUMS will give you data from the entire U.S., making for a very large dataset. Large datasets are hard to work with, so let's narrow the data down to California.

- Click `SELECT CASES`. Check `STATEFIP` and click `SUBMIT`. Click `06 California`. Click `SUBMIT`. On the Extract Request page it should say `STATEFIP (1 of 62 codes)` under `SELECT CASES`.

- Finally, the default data format used by IPUMS is `.dat`, but we prefer `.csv`. Under `Data Format`, click `Change`. Select `Comma delimited (.csv)` and click `Apply Selection`.

- You are now ready to create your data extract! Click `SUBMIT EXTRACT`.

### Downloading the Extract

It will take a few minutes for the extract to be ready. Once it's ready, you should receive an email telling you so. You can also refresh the page to check if it's ready.

- Once the extract is ready, click `Download CSV`. Download it to anywhere on your computer.

- The file type is `.gz`, which is a type of compression like `.zip`. You can extract with programs like 7-zip or WinRAR, or TheUnarchiver on Mac. The resulting `.csv` file should be about 35 MB in size.

{: .red-callout-title }
> Warning
> 
> Students often run into issues unzipping this file. If you're having trouble on your computer, you can also try an online extraction utility like [Ezyzip](https://www.ezyzip.com/unzip-tar-gz-file-online.html){:target="_blank"}. 

- Open the file in Excel. How many rows are there? How many columns?

## Extra Credit

Los Angeles county is represented in the data by the `COUNTYFIP` code 37. Try caculating the average wage and salary income (`INCWAGE`) for employed people (`EMPSTAT==1`) between the ages of 25 and 65 in Los Angeles county in 2019. You'll have to ignore people with invalid codes for `INCWAGE` (see the codebook to learn what these invalid codes are.)

You may use Excel or R or any other program to make this calculation. Submit the answer on your Week 1 Problem Set.

## Takeaways

- You know what the Decennial Census and the ACS are. You know what IPUMS is.
- You know how to create custom ACS microdata extracts using IPUMS.






