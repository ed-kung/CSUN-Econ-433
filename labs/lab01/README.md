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

### Instructions

I will walk you through the process of signing up for IPUMS and downloading ACS microdata for the state of California in 2019.

1. Go to www.ipums.org.
2. Click on the "IPUMS USA" logo.
3. Click "Get Data". You will be taken to IPUMS' data selection interface. Here you will select the variables (columns) that you want to include as well as the samples (surveys) that you want to include.
4. First, we will see what variables are preselected. 

    In the "HOUSEHOLD" dropdown menu, click "TECHNICAL". Notice that the variables `YEAR`, `MULTYEAR`, `SAMPLE`, `SERIAL`, `CBSERIAL`, `HHWT`, `CLUSTER`, and `STRATA` have a label that says "preselected" next to them. 
  
    In the "PERSON" dropdown menu, click "TECHNICAL". Notice that `PERNUM` and `PERWT` are preselected.

    The preselected variables contain technical data about survey sampling which are necessary for calculating accurate statistics. For now, we will only care about the meaning of four of these variables: `YEAR`, `SERIAL`, `PERNUM`, and `PERWT`. 
  
5. You can click on any variable's name to get more information about its meaning. Go back to "HOUSEHOLD->TECHNICAL" and click on the variable `YEAR`. You will see a description of the variable. The meaning of `YEAR` is quite obvious. 

6. Go back and click on `SERIAL`. `SERIAL` is the unique identification number for each household in a survey. 

7. Now go to "PERSON->TECHNICAL" and click on `PERNUM`. `PERNUM` numbers the unique persons within each household. Combined with `SERIAL`, `SERIAL` and `PERNUM` uniquely identify each person within IPUMS. 

    **Unique Identifiers** - A dataset contains rows and columns. Each row represents a record and each column (a.k.a. variable) contains information about that record. In data analytics, it is always important to know which variables uniquely identify a record in your dataset, because if you have duplicate records with the same unique identifiers then you know you have an error in the data. 
    
    In the IPUMS data, each record is a person and the variables `SERIAL`, `PERNUM` together uniquely identify a record. If we find records with duplicate values of `SERIAL`, `PERNUM`, we'll know we did something wrong. 
  
8. Finally, go back and click on `PERWT`. `PERWT` indicates how many persons in the U.S. population are represented by a given person in the IPUMS sample. In other words, it is a *sampling weight*.

    **Sampling Weight** - The ACS methodology does not survey every person in the U.S. with equal probability. It oversamples underrepresented groups to ensure that there is a sufficient quantity of data about that group. Because of the weighted sampling, researchers need to know how many people each survey respondent represents in the population in order to calculate accurate statistics. Oversampled groups will have smaller sampling weights whereas undersampled groups will have larger sampling weights.

9.   