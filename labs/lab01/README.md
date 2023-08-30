# ECON 433 - Lab Session 1
## Introduction to Public Datasets with IPUMS

In this lab, you will be introduced to a public data repository maintained by the University of Minnesota known as IPUMS. IPUMS allows users to download microdata from the U.S. Decennial Census and the American Community Survey (ACS). The Census and the ACS are the two main surveys researchers use to track U.S. socioeconomic data over time. The data is useful for both marketing and policy research.

**Microdata** - *Microdata* refers to data about individual survey units, in this case people and households. The opposite of microdata is *aggregated data*. An example of microdata is a table showing the income level and state of residence for each individual who took the survey. An example of aggregated data is a table showing the average income for each state. Researchers generally consider microdata to be more valuable than aggregated data because aggregated data can be calculated from microdata, but not the other way around.

An example of microdata:

| Person    | State | Income     |
| --------- | ----- | ---------- |
| Alice     |    CA | $80,000    |
| Bob       |    NY | $90,000    |
| Charlie   |    CA | $50,000    |
| Dan       |    WY | $100,000   |
| ...       |   ... | ...        |

An example of aggregated data:

| State | Average Income |
| ----- | -------------- |
| CA    | $100,000       |
| NY    | $120,000       |
| FL    | $90,000        |
| ...   | ...            |

**Decennial Census** - Every 10 years the Census Bureau collects information on every person living in the U.S. Because this is a huge data collection effort, it only occurs once every decade and the questions asked are not as detailed as in the ACS.

**American Community Survey** - Every year the Census Bureau collects information on a random sample of U.S. households. This survey is known as the ACS. Because the data is collected on a much smaller sample than the Decennial Census, the ACS is able to ask more detailed questions.

## Instructions

I will walk you through the process of signing up for IPUMS and downloading ACS microdata for the state of California in 2019.


### Account Creation

1. Go to www.ipums.org.
2. Click on the "IPUMS USA" logo.
3. Click "REGISTER" on the top-right corner.
4. Click "Apply for Access" and fill out the form. For occupation category, select "undergraduate student". For specific occupation title, select "student". For field of research, select "economics". Under general research statement, type "I will use this data to study the gender wage gap" because that will be one of our exercises. For "How did you learn about this database?", select "Teacher or professor". Click all the required boxes and click "SUBMIT".
5. Wait until you receive account access, then log in once you do. 

### Selecting Variables

Once you have your account created, you can begin creating a data extract.

6. Go back to usa.ipums.org/usa and click "Get Data". You will be taken to IPUMS' data selection interface. Here you will select the variables (columns) that you want to include as well as the samples (surveys) that you want to include.

7. First, we will see what variables are preselected. 

    In the "HOUSEHOLD" dropdown menu, click "TECHNICAL". Notice that the variables `YEAR`, `MULTYEAR`, `SAMPLE`, `SERIAL`, `CBSERIAL`, `HHWT`, `CLUSTER`, and `STRATA` have a label that says "preselected" next to them. 
  
    In the "PERSON" dropdown menu, click "TECHNICAL". Notice that `PERNUM` and `PERWT` are preselected.

    The preselected variables contain technical data about survey sampling which are necessary for calculating accurate statistics. For now, we will only care about the meaning of four of these variables: `YEAR`, `SERIAL`, `PERNUM`, and `PERWT`. 
  
8. You can click on any variable's name to get more information about its meaning. Go back to "HOUSEHOLD->TECHNICAL" and click on the variable `YEAR`. You will see a description of the variable. The meaning of `YEAR` is quite obvious. 

9. Go back and click on `SERIAL`. `SERIAL` is the unique identification number for each household in a survey. 

10. Now go to "PERSON->TECHNICAL" and click on `PERNUM`. `PERNUM` numbers the unique persons within each household. Combined with `SERIAL`, `SERIAL` and `PERNUM` uniquely identify each person within IPUMS. 

    **Unique Identifiers** - A dataset contains rows and columns. Each row represents a record and each column (a.k.a. variable) contains information about that record. In data analytics, it is always important to know which variables uniquely identify a record in your dataset, because if you have duplicate records with the same unique identifiers then you know you have an error in the data. 
    
    In data science, the column that contains the unique identifier is called the **primary key**.
    
    In the IPUMS data, the primary keys are `SERIAL` and `PERNUM`. `SERIAL` and `PERNUM` together uniquely identify a record. If we find records with duplicate values of `SERIAL` and `PERNUM`, we'll know we did something wrong. 
  
11. Finally, go back and click on `PERWT`. `PERWT` indicates how many persons in the U.S. population are represented by a given person in the IPUMS sample. In other words, it is a *sampling weight*.

    **Sampling Weight** - The ACS methodology does not survey every person in the U.S. with equal probability. It oversamples underrepresented groups to ensure that there is a sufficient quantity of data about that group. Because of the weighted sampling, researchers need to know how many people each survey respondent represents in the population in order to calculate accurate statistics. Oversampled groups will have smaller sampling weights whereas undersampled groups will have larger sampling weights.

Now that we've taken a tour of the technical variables, we're ready to select the variables we're interested in! For today, we will extract data on a person's sex, age, marital status, race, employment status, income, and education for the state of California in 2019. 

12. Go to "PERSON->DEMOGRAPHIC" and click on the + symbol under "Add to cart" for the variables: `SEX`, `AGE`, and `MARST`. You can click on any of these variables to find out more information about them. Try clicking on `MARST` and then clicking on "CODES" to see the list of values that `MARST` can take and their meanings.

13. Go to "PERSON->RACE, ETHNICITY, and NATIVITY" and add the `RACE` and `HISPAN` variables to your cart. You can click on either variable to see a list of codes and their meanings, as well as some historical detail about how race and Hispanic origin were recorded by the Census Bureau.

14. Go to "PERSON->EDUCATION" and add `EDUC` and `DEGFIELD` to your cart. Click on the variables to find out more about each variable.

15. Go to "PERSON->WORK" and add `EMPSTAT` to your cart.

16. Go to "PERSON->INCOME" and add `INCTOT` and `INCWAGE` to your cart.

17. Finally, let's add some geographic information to our data. Go to "HOUSEHOLD->GEOGRAPHIC" and add `STATEFIP` and `COUNTYFIP` to your cart. This will let us know the person's state and county of residence.

### Selecting Samples, Cases, and Creating the Extract

We're done selecting our variables! Now let's narrow our request down to data from the state of California in 2019.

18. On the main data selection screen, click "SELECT SAMPLES". Uncheck "Default sample from each year" and check "ACS" for the year 2019. Make sure you only have that one box checked, then click "SUBMIT SAMPLE SELECTIONS".

19. Your data cart should say "17 VARIABLES" and "1 SAMPLE". Click "VIEW CART" to review your variable and sample selections, then click "CREATE DATA EXTRACT".

20. We want to narrow the data down to California so the data is not too large. Click "SELECT CASES". Check "STATEFIP" and click "SUBMIT". Click "06 California" and click "SUBMIT". On the Extract Request page it should say "STATEFIP (1 of 62 codes)" under "SELECT CASES".

21. Finally, the default data format used by IPUMS is .dat, but we prefer .csv (comma separated values). Under "Data Format" click "Change". Select "csv" and click "Apply Selection". 

22. You are now ready to create your data extract! Click "SUBMIT EXTRACT".

### Downloading and Viewing the Data Extract

It will take a few minutes for the extract to be ready. Once it's ready, you should receive an email indicating so. You can also refresh the page to check if it's ready.

23. Once the extract is ready, click "Download CSV". Download it to anywhere on your computer.

24. The file type is .gz, which is a type of compression like .zip. Extract it using any Windows program compatible with .gz files, like 7-zip or WinRAR. The resulting .csv file should be about 44 MB in size.

25. Open the file in Excel. How many rows are there? How many columns?

26. Try using Excel to calculate the average wage and salary income for employed people between the ages of 25 and 65 in California in 2019. Remember to calculate the weighted average using `PERWT` as sample weights.

## To get credit and be dismissed

1. Show me your opened file in Excel and that it has the correct number of rows and columns.

2. Take the lab quiz.


## Takeaways

- You know what the Decennial Census and the ACS are. You know what IPUMS is.
- You can create custom ACS microdata extracts using IPUMS.



