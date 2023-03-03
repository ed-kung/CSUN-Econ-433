# ECON 433 - Lab Session 6
## Linear Models

In this lab you will learn how to estimate linear models in R and to interpret the results. 

## Background

A **model** relates an **outcome variable** to one or more variable called **covariates**. 

**Outcome**: The variable that you are seeking to explain or predict. Also sometimes called the dependent variable, or left-hand-side variable.

**Covariate**: The variables that influence the outcome variable. Also sometimes called independent variables, regressors, right-hand-side variables, or features.

A **linear model** specifies the outcome variable as a linear function of the covariates. An example of a linear model is:

$$Y = \beta_0 + \beta_1 X_1 + \beta_2 X_2 + \beta_3 X_3 + \epsilon$$

In this model, the outcome variable is $Y$ and the covariates are $X_1$, $X_2$, and $X_3$. 

The terms $\beta_1$, $\beta_2$, and $\beta_3$ are known as **coefficients**. The coefficients govern how a one-unit change in the covariate affect the outcome variable. For example, if the coefficients are: $\beta_1=0.5$, $\beta_2=0$, and $\beta_3=-1.7$, then a one-unit change in $X_1$ will increase $Y$ by 0.5, a one-unit change in $X_2$ will not change $Y$, and a one-unit change in $X_3$ will reduce $Y$ by 1.7.




