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

- $\beta_1=0.5$
- $\beta_2=0$
- $\beta_3=-1.7$

Then:

- A one-unit change in $X_1$ increases $Y$ by $0.5$.
- A one-unit change in $X_2$ does not change $Y$.
- A one-unit change in $X_3$ reduces $Y$ by $1.7$.

### Error Term
The term $\epsilon$ is called the **error term**, or the residual. The error term represents factors which affect the outcome variable but that the researcher cannot observe. A standard assumption is that the error term is *independent* and *uncorrelated* with the covariates. If this assumption fails, then we have an issue known as **endogeneity** which complicates the analysis.

### Intercept
The term $\beta_0$ is called the **intercept**, or the constant term. The intercept is the value of the outcome if all the covariates and the error term are equal to zero.

### Regression Analysis
Estimating a model with a numerical outcome variable is known as **regression analysis**. For a linear model, the goal of regression analysis is to find out what the coefficients are. We can do this using a statistical technique known as **ordinary least squares** estimation. R has a robust set of tools for estimating linear models.

## Lab Work

### Setup

For today's lab, you will need the following files. They should already be uploaded to the cloud from previous labs. If they aren't, you should download the files from Canvas and upload them to R Cloud.

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

$$\ln w_i = \beta_0 + \beta_1 X_{i1} + \ldots + \beta_K X_{iK} + \epsilon_{i}$$

In the model, $X_{i1}, \ldots, X_{iK}$ are $K$ different variables which might influence the wage rate, like education level, work experience, and industry of occupation. The residual term, $\epsilon_{i}$, represents unobserved factors that could affect the wage rate, like a person's grit or personality.

We can now write the full model for log wage income:

$$
\begin{align} 
Y_i &= w_i \times h_i \\ 
\ln Y_i &= \ln w_i + \ln h_i 
\ln Y_i &= \beta_0 + \beta_1 X_{i1} + \ldots + \beta_K X_{iK} + \ln h_i + \epsilon_{i}
\end{align}
$$









