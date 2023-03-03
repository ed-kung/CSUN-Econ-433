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
The term $\epsilon$ is called the error term, or the residual. The error term represents factors which affect the outcome variable but that the researcher cannot observe. A standard assumption is that the error term is *independent* and *uncorrelated* with the covariates. If this assumption fails, then we have an issue known as **endogeneity** which complicates the analysis.






