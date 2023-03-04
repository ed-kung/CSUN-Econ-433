# ECON 433 - Lab Session 6
## Linear Models

In this lab you will learn how to estimate linear models in R and to interpret the results. 

## Background

A **model** relates an **outcome variable** to one or more variable called **covariates**. 

### Outcome variable
The **outcome variable** is the variable that you are seeking to explain or predict. Also sometimes called the dependent variable, or left-hand-side variable.

### Covariates
The **covariates** are the variables that influence the outcome variable. Also sometimes called independent variables, regressors, right-hand-side variables, or features.

### Linear Models
A **linear model** specifies the outcome variable as a linear function of the covariates. An example of a linear model is:

$$Y = \beta_0 + \beta_1 X_1 + \beta_2 X_2 + \beta_3 X_3 + \epsilon$$

In this model, the outcome variable is $Y$ and the covariates are $X_1$, $X_2$, and $X_3$. 

### Coefficients
The terms $\beta_1$, $\beta_2$, and $\beta_3$ are known as **coefficients**. In a linear model, the coefficients govern how a one-unit change in the covariate affect the outcome variable. For example, if:

|               |             |                |
| ------------- | ----------- | -------------- |
| $\beta_1=0.5$ | $\beta_2=0$ | $\beta_3=-1.7$ |

Then:

- A one-unit change in $X_1$ increases $Y$ by $0.5$.
- A one-unit change in $X_2$ does not change $Y$.
- A one-unit change in $X_3$ reduces $Y$ by $1.7$.

### Error Term
The term $\epsilon$ is called the **error term**, or the residual. The error term represents factors which affect the outcome variable but that the researcher cannot observe. A standard assumption is that the error term is *independent* and *uncorrelated* with the covariates. If this assumption fails, then we have an issue known as **endogeneity** which complicates the analysis. The error term is also always assumed to have a mean of zero.

### Intercept
The term $\beta_0$ is called the **intercept**, or the constant term. The intercept is the value of the outcome if all the covariates and the error term are equal to zero.

### Regression Analysis
The goal of our analysis is to estimate the values for the coefficients, which are unknown. We want to find out how each of the covariates influence the outcome variable. Estimating the coefficients of a linear model is known as **regression analysis**. R has a robust set of built-in tools for conducting regression analysis.

### Interpretation of the Model as Expected Value
Because the error term has mean zero and is independent of the covariates, we can write the expected value of $Y$ conditional on $X$, as follows:

$$
\begin{align}
E[Y | X_1, X_2, X_3] &= E[\beta_0 + \beta_1 X_1 + \beta_2 X_2 + \beta_3 X_3 + \epsilon | X_1, X_2, X_3] \\
&= \beta_0 + \beta_1 X_1 + \beta_2 X_2 + \beta_3 X_3 + E[\epsilon | X_1, X_2, X_3]
&= \beta_0 + \beta_1 X_1 + \beta_2 X_2 + \beta_3 X_3
\end{align}
$$

In other words, knowing the coefficients allows us to predict the **expected value of the outcome variable for a given set of covariates**.

For example, if:

- $\beta_0 = 2.3$
- $\beta_1 = 0.5$
- $\beta_2 = 0$
- $\beta_3 = -1.7$

and if:

- $X_1 = 1.2$
- $X_2 = 3$
- $X_3 = 0.8$

then:

$$
\begin{align}
E[Y | X_1, X_2, X_3] &= \beta_0 + \beta_1 X_1 + \beta_2 X_2 + \beta_3 X_3 \\
&= 2.3 + 0.5 \times 1.2 + 0 \times 3 + (-1.7) \times 0.8 \\
&= 1.54
\end{align}
$$

## Lab Work

In today's lab you will be estimating a model of wage income to study the gender wage gap.

### Setup

Before you start, you will need the following files. They should already be uploaded to the cloud from previous labs. If they aren't, you should download the files from Canvas and upload them to R Cloud.

- `IPUMS_ACS2014_CA_1.csv`
- `IPUMS_ACS2014_CA_2.csv`
- `IPUMS_ACS2019_CA_1.csv`
- `IPUMS_ACS2019_CA_2.csv`

You will also need the packages `dplyr` and `stargazer`. `dplyr` should already be installed from previous labs. If it isn't, install it with `install.packages("dplyr")`. Install Stargazer with `install.packages("stargazer")`. Stargazer is a library for displaying regression output more beautifully than with the built-in methods.

### Model

For today's lab, you will be estimating a log-linear model of wage income. That is, the natural log of wage-income is modeled as a linear function of the covariates.

Let $i$ denote a person and let $Y_i$ denote person $i$'s annual wage income. Let $w_i$ be person $i$'s wage rate and let $h_i$ be the number of hours they worked in the year. Then:

$$Y_i = h_i \times w_i$$

We model the log wage-rate as a linear model:

$$\ln w_i = \beta_0 + \beta_1 X_{i1} + \beta_2 X_{i2} + \ldots + \beta_K X_{iK} + \epsilon_{i}$$

In the model, $X_{i1}, \ldots, X_{iK}$ are $K$ different variables which might influence the wage rate, like education level, work experience, and industry of occupation. Since we're interested in the gender wage gap, we'll also want to include gender as one of the $X$'s.

The residual term, $\epsilon_{i}$, represents unobserved factors that could affect the wage rate, like a person's grit or personality.

We can now write the full model for log wage income:

$$
\begin{align} 
Y_i &= w_i \times h_i \\ 
\ln Y_i &= \ln w_i + \ln h_i \\
\ln Y_i &= \beta_0 + \beta_1 X_{i1} + \beta_2 X_{i2} + \ldots + \beta_K X_{iK} + \ln h_i + \epsilon_{i}
\end{align}
$$

The outcome variable is $\ln Y_i$ (the natural log of wage income) and the covariates are $X_{i1}$ through $X_{iK}$ and $\ln h_i$ (the natural log of hours worked).

This looks like a linear model that we can estimate using standard tools in R!

### Estimation with one variable

Let's first estimate a simple model with just one covariate:

$$\ln Y_i = \beta_0 + \beta_1 X_{i1} + \epsilon_{i}$$

The one covariate we'll use is gender. Run the following script in R:

    rm(list=ls())      # Clear the workspace
    library(dplyr)     # Load required libraries
    library(stargazer)
    
    # Load the data and merge them
    df1 <- read.csv("IPUMS_ACS2019_CA_1.csv")
    df2 <- read.csv("IPUMS_ACS2019_CA_2.csv")
    df <- inner_join(df1, df2, by=c("YEAR","SERIAL","PERNUM"))
    
    # Deal with missing values for INCWAGE
    df$INCWAGE[ df$INCWAGE>=999998] <- NA
    
    # Focus on employed individuals age 25 to 65 that make positive wage income
    df <- filter(df, AGE>=25 & AGE<=65 & EMPSTAT==1 & INCWAGE>0)
    
    # Create a 0 or 1 variable for whether the person is female
    df$FEMALE <- df$SEX==2
    
    # Create a linear model object
    mod1 <- lm(log(INCWAGE) ~ FEMALE, data=df, weights=PERWT)

    # Display the model results with Stargazer
    stargazer(mod1, type="text")

You should see output that looks like:

    =================================================
                             Dependent variable:     
                        -----------------------------
                                log(INCWAGE)         
    -------------------------------------------------
    FEMALE                        -0.313***          
                                   (0.005)           
                                                     
    Constant                      10.860***          
                                   (0.004)           
                                                     
    -------------------------------------------------
    Observations                   140,615           
    R2                              0.024            
    Adjusted R2                     0.024            
    Residual Std. Error     10.149 (df = 140613)     
    F Statistic         3,527.394*** (df = 1; 140613)
    =================================================
    Note:                 *p<0.1; **p<0.05; ***p<0.01

Let's step through the code. 


## Takeaways

- You can run linear regressions in R
- You can show regression output using Stargazer
- You can interpret regression results







