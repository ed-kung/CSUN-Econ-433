---
layout: default
title: 7. Linear Regressions II
parent: Labs
nav_order: 7
---

# Lab 7
{: .no_toc }

## Linear Regressions II
{: .no_toc }

In this lab, you will continue practicing your data skills. You will create a chart and run some regressions.

---

## Background

Today, you will try to understand patterns in homeownership rate using IPUMS ACS data from California 2019.  The data is contained in the CSV file, `lab07_assignment_data.csv`.

In this data, each row is a [household](/CSUN-Econ-433/docs/glossary/household){:target="_blank"}. (Previously, you worked with data in which each row is a person. For today's lab, we'll work with household level data because homeownership rate is only measured at the household level.)

The following variables are available in this data:
- `YEAR`: The year the household was surveyed
- `SERIAL`: The identification number of the household
- `HHWT`: The survey weight of the household. You need this to construct summary statistics and run regressions.
- `STATEFIP`: The state FIPS code (6 for California)
- `COUNTYFIP`: The county FIPS code that the household is located in
- `OWNERSHP`: Whether the household owns the home they live in
- `HHINCOME`: Total income of all members in the household
- `SEX`: Sex of the household head
- `AGE`: Age of the household head
- `MARST`: Marital status of the household head
- `RACHSING`: Race of the household head
- `EDUC`: Educational attainment of the household head
- `EMPSTAT`: Employment status of the household head
- `OCC`: Occupation of the household head
- `IND`: Industry of the household head

Don't be lazy: make sure you look up the IPUMS codebook for any variables you don't know the coding for.

---

## Preparation

Download `lab07_assignment_data.csv` and upload it to your R Studio Cloud files directory.

Make sure `dplyr`, `ggplot2`, `lfe`, and `stargazer` are installed in your R Studio Cloud workspace.

---

## Assignment

Create a new script that accomplishes the following tasks:

1. Load the data from `lab07_assignment_data.csv` and store it in a dataframe called `df`.

2. Assign `NA` to invalid values of `HHINCOME`.

3. Create the following variables:
    - `OWNHOME`: A boolean variable indicating whether the household owns the home they live in
    - `COLLEGE`: A boolean variable indicating whether the household head has 4+ years of college education
    - `MARRIED`: A boolean variable indicating whether the household head is married
    - `MALE`: A boolean variable indicating whether the household head is male
    - `AGESQ`: The square of the age of household head. 
	    - *Note:* To calculate the square of a variable in R, you can't use the exponent sign `^`. Instead you need to do this: `df$XSQ <- df$X * df$X`.

4. Create a line plot showing homeownership rate by age of household head.
    - Title the plot "Homeownership Rate by Age of Household Head: California 2019"
    - Label the X axis "Age"
    - Label the Y axis "Homeownership Rate"
    - Don't forget to use `HHWT` as the survey weight when calculating homeownership rate.

5. Run 3 regressions and show them on a single Stargazer table.
    - For all regressions, use only data of households with `HHINCOME>0`.
    - Regression 1: Regress `OWNHOME` on `log(HHINCOME)`.
    - Regression 2: Regress `OWNHOME` on `log(HHINCOME)`, `AGE`, `AGESQ`, `MALE`, `COLLEGE`, `MARRIED`, and `as.factor(RACHSING)`.
    - Regression 3: In addition to all the variables in regression 2, include `COUNTYFIP`, `IND`, and `OCC` as dummy variables.
    - Don't forget to use `HHWT` as the survey weights in the regression.
    
Show me your script and output to receive your grade and be dismissed. If you aren't able to complete the assignment in class, you can upload the script to the Lab 07 Script assignment.

---

## Expected output

```
================================================================================
                                         Dependent variable:                    
                     -----------------------------------------------------------
                                               OWNHOME                          
                             (1)                 (2)                 (3)        
--------------------------------------------------------------------------------
log(HHINCOME)             0.138***            0.115***            0.111***      
                           (0.001)             (0.001)             (0.001)      
                                                                                
AGE                                           0.023***            0.022***      
                                              (0.0004)            (0.0004)      
                                                                                
AGESQ                                        -0.0001***          -0.0001***     
                                              (0.00000)           (0.00000)     
                                                                                
MALE                                          -0.021***           -0.019***     
                                               (0.002)             (0.003)      
                                                                                
COLLEGE                                       0.037***            0.042***      
                                               (0.003)             (0.003)      
                                                                                
MARRIED                                       0.152***            0.137***      
                                               (0.003)             (0.003)      
                                                                                
as.factor(RACHSING)2                          -0.130***           -0.112***     
                                               (0.005)             (0.005)      
                                                                                
as.factor(RACHSING)3                            0.019               0.006       
                                               (0.018)             (0.018)      
                                                                                
as.factor(RACHSING)4                          -0.012***           0.028***      
                                               (0.004)             (0.004)      
                                                                                
as.factor(RACHSING)5                          -0.063***           -0.038***     
                                               (0.003)             (0.003)      
                                                                                
Constant                  -0.992***           -1.627***                         
                           (0.014)             (0.017)                          
                                                                                
--------------------------------------------------------------------------------
Observations               134,094             134,094             134,094      
R2                          0.084               0.254               0.297       
Adjusted R2                 0.084               0.254               0.292       
Residual Std. Error  4.682 (df = 134092) 4.226 (df = 134083) 4.117 (df = 133252)
================================================================================
Note:                                                *p<0.1; **p<0.05; ***p<0.01
```

---

## Takeaways

- You can work independently on data projects involving data visualization and regression.




