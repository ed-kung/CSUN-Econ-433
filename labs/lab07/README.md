# ECON 433 - Lab Session 7
## Regression Analysis

In this lab you will learn how to conduct regression analysis of linear models in R.

### Background

A model relates an outcome variable to one or more variables called covariates. The outcome variable is sometimes called the "dependent variable" and the covariates are sometimes called the "independent variables". 

A *linear* model specifies the outcome variable as a linear equation in the covariates. An example of a linear model is:

$$Y = \beta_0 + \beta_1 X_1 + \beta_2 X_2 + \beta_3 X_3 + \epsilon$$

In this model, the outcome is $Y$ and the covariates are $X_1$, $X_2$, and $X_3$. 

The terms $\beta_1$, $\beta_2$, and $\beta_3$ are known as *coefficients*. The coefficient on a covariate shows how much the outcome changes for each unit change in the covariate.

The term $\epsilon$ is called the error term, or residual. The error term represents factors which affect the outcome that the researcher cannot observe. A standard assumption is that the error term is independent of and uncorrelated with the covariates. If this assumption fails, then we have *confounding factors* which complicate the analysis.

The term $\beta_0$ is called the *intercept*. The intercept is the value that the outcome takes if all the covariates and residuals are equal to zero.

The goal of regression analysis is to estimate the value of the coefficients and intercept that produce a best fit for the data. That is, $\beta_0$, $\beta_1$, $\beta_2$, and $\beta_3$ are chosen to make the observed values of $Y$ as close as possible to the calculated values of $\beta_0 + \beta_1 X_1 + \beta_2 X_2 + \beta_3 X_3$. In technical terms, the intercept and coefficients are chosen to minimize the sum of the squared residuals.

R has a robust set of tools for conducting regression analysis on linear models. That is what you will explore in this lesson.

### A linear model of wage income

Here, we derive a linear model of annual wage income. Let $i$ denote a person and let $Y_i$ denote the annual wage income of person $i$. 

$$Y_i = w_i h_i$$

where $w_i$ is the hourly wage rate and $h_i$ is the number of hours worked annually.

We will model the wage rate as follows:

$$w_i = e^{\beta_0 + \beta_1 X_{i1} + \ldots + \beta_K X_{iK} + \epsilon_i}$$

where $X_{i1}$, $\ldots$, $X_{iK}$ are $K$ different variables which might affect wage rate, like education level or industry of occupation. The residual term, $\epsilon_i$, represents unobserved factors that could affect wage rate, like a person's grit or personality.

Taking natural logs of both sides, we get:

$$\ln w_i = \beta_0 + \beta_1 X_{i1} + \ldots + \beta_K X_{iK} + \epsilon_i$$

Noting that:

$$\ln Y_i = \ln w_i + \ln h_i$$

we can write the final equation:

$$\ln Y_i = \beta_0 + \beta_1 X_{i1} + \ldots + \beta_K X_{iK} + \ln h_i + \epsilon_i$$

The final equation says that log-wage is a linear equation of the covariates $X_{i1}, \ldots , X_{iK}$, log hours-worked, and a residual term. Since it is a linear equation, we can estimate it using standard tools in R.


### Setup

For this lab, you will need the `dplyr`, `lfe`, and `stargazer` packages. Make sure they are installed and loaded using `install.packages` and `library`. You will also need the files:

- `IPUMS_ACS2019_CA_1.csv`
- `IPUMS_ACS2019_CA_2.csv`

Make sure these files are in your working directory before beginning.

### Regressing log wage-income on gender

You will use your data from California 2019 to answer the question: Are women paid less than men? This is a politically sensitive topic that requires much deeper analysis than just this lab. However, the data that we have available is good for demonstrating the usefulness of regressions.

1. Create the following script and execute it:

        rm(list=ls()) # clear the workspace
        
        # Load required libraries
        library(dplyr)
        library(lfe)
        library(stargazer)
        
        # Load the data and merge
        df1 <- read.csv("IPUMS_ACS2019_CA_1.csv")
        df2 <- read.csv("IPUMS_ACS2019_CA_2.csv")
        df <- inner_join(df1, df2, by=c("YEAR","SERIAL","PERNUM"))

        # Deal with missing values in INCWAGE
        df$INCWAGE <- ifelse(df$INCWAGE>=999998, NA, df$INCWAGE)
        
        # Focus on employed individuals aged 25 to 65
        # that make positive wage income
        df <- filter(df, AGE>=25, AGE<=65, EMPSTAT==1, INCWAGE>0)
        
        # Create female variable
        df$FEMALE <- df$SEX==2
        
        # Create log wage variable
        df$LOGWAGE <- log(df$INCWAGE)
        
        # Run a regression of LOGWAGE on FEMALE
        # and store the results in r1
        r1 <- felm(LOGWAGE ~ FEMALE, data=df)
        
        # Show the regression results
        summary(r1)
        
You should see a table that looks like this:

                 Estimate Std. Error t value Pr(>|t|)    
    (Intercept) 10.929408   0.003714 2943.10   <2e-16 ***
    FEMALETRUE  -0.333895   0.005409  -61.73   <2e-16 ***
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    
The model you just estimated is the following:

$$\ln Y_i = \beta_0 + \beta_1 FEMALE_i + \epsilon_i$$

With the data, you estimated a value of $10.93$ for $\beta_0$ and $-0.334$ for $\beta_1$. The model suggests that log wage income for females is $0.334$ less than log wage income for men. Since log-differences are approximately equal to percentage differences, this suggests that women make 33% less than men do.

### Controlling for hours worked

You could criticize the previous regression by saying that it doesn't control for hours worked. Hours worked is a confounding factor because it may be correlated with gender and it also affects total wage income. 

2. To control for hours worked, add the following lines to your script and execute:

        # Run a regresion of LOGWAGE on FEMALE and LOGHRS
        # Store the result in r2
        r2 <- felm(LOGWAGE ~ FEMALE + LOGHRS, data=df)
        
        # Show the results of r2
        summary(r2)
        
You should see the following results:



















