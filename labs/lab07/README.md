# ECON 433 - Lab Session 7
## Regression Analysis

In this lab you will learn how to conduct regression analysis of linear models in R.

### Background

A model relates an outcome variable to one or more variables called covariates. The outcome variable is sometimes called the "dependent variable" and the covariates are sometimes called the "independent variables". 

A *linear* model specifies the outcome variable as a linear equation in the covariates. An example of a linear model is:

$$Y = \beta_1 X_1 + \beta_2 X_2 + \beta_3 X_3 + \epsilon$$

In this model, the outcome is $Y$ and the covariates are $X_1$, $X_2$, and $X_3$. 

The terms $\beta_1$, $\beta_2$, and $\beta_3$ are known as *coefficients*. The coefficient on a covariate shows how much the outcome changes for each unit change in the covariate.

The term $\epsilon$ is called the error term, or residual. The error term represents factors which affect the outcome that the researcher cannot observe. A standard assumption is that the error term is independent of and uncorrelated with the covariates. If this assumption fails, then we have *confounding factors* which complicate the analysis.

The goal of regression analysis is to estimate the value of the coefficients that produce a best fit for the data. That is, $\beta_1$, $\beta_2$, and $\beta_3$ are chosen to make the observed values of $Y$ as close as possible to the observed values of $\beta_1 X_1 + \beta_2 X_2 + \beta_3 X_3$. In technical terms, the coefficients are chosen to minimize the sum of the squared residuals.

R has a robust set of tools for conducting regression analysis on linear models. That is what you will explore in this lesson.





