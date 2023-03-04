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
E[Y | X] &= E[\beta_0 + \beta_1 X_1 + \beta_2 X_2 + \beta_3 X_3 + \epsilon | X] \\
&= \beta_0 + \beta_1 X_1 + \beta_2 X_2 + \beta_3 X_3 + E[\epsilon | X] \\
&= \beta_0 + \beta_1 X_1 + \beta_2 X_2 + \beta_3 X_3
\end{align}
$$

In other words, knowing the coefficients allows us to predict the **expected value of the outcome variable for a given set of covariates**.

For example, if:

|                 |                 |               |                  |
| --------------- | --------------- | ------------- | ---------------- |
| $\beta_0 = 2.3$ | $\beta_1 = 0.5$ | $\beta_2 = 0$ | $\beta_3 = -1.7$ | 
|                 | $X_1 = 1.2$     | $X_2 = 3$     | $X_3 = 0.8$      |

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

You will also need the packages `dplyr`, `stargazer`, and `lfe`. `dplyr` should already be installed from previous labs. If it isn't, install it with `install.packages("dplyr")`. 

Install Stargazer with `install.packages("stargazer")`. Stargazer is a library for displaying regression output more beautifully than with the built-in methods.

Install `lfe` with `install.packages("lfe")`. `lfe` is a package for running regressions with large factor variables.

### Model

For today's lab, you will be estimating a log-linear model of wage income. That is, the natural log of wage-income is modeled as a linear function of the covariates.

Let $i$ denote a person and let $Y_i$ denote person $i$'s annual wage income. Let $w_i$ be person $i$'s wage rate and let $h_i$ be the number of hours they worked in the year. Then:

$$Y_i = h_i \times w_i$$

We model the log wage-rate as a linear model:

$$\ln w_i = \beta_0 + \beta_1 X_{i1} + \beta_2 X_{i2} + \ldots + \beta_K X_{iK} + \epsilon_{i}$$

In the model, $X_{i1}, X_{i2}, \ldots, X_{iK}$ are $K$ different variables which might influence the wage rate, like education level, work experience, and industry of occupation. Since we're interested in the gender wage gap, we'll also want to include gender as one of the $X$'s.

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

Let's first estimate a simple model with just one covariate: gender. Run the following script in R:

    rm(list=ls())      # Clear the workspace
    library(dplyr)     # Load required libraries
    library(stargazer)
    library(lfe)
    
    # Load the data and merge them
    df1 <- read.csv("IPUMS_ACS2019_CA_1.csv")
    df2 <- read.csv("IPUMS_ACS2019_CA_2.csv")
    df <- inner_join(df1, df2, by=c("YEAR","SERIAL","PERNUM"))
    
    # Deal with missing values for INCWAGE
    df$INCWAGE[ df$INCWAGE>=999998] <- NA
    
    # Focus on employed individuals age 25 to 65 that make positive wage income
    df <- filter(df, AGE>=25 & AGE<=65 & EMPSTAT==1 & INCWAGE>0)
    
    # Create a boolean variable for whether the person is female
    df$FEMALE <- df$SEX==2
    
    # Create a linear model object
    mod1 <- felm(log(INCWAGE) ~ FEMALE, data=df, weights=PERWT)

    # Display the model results with Stargazer
    stargazer(mod1, type="text", keep.stat=c("n","rsq"))

The following new elements of code have been introduced:

- `lm` is the command to create and estimate a linear model. The results are stored in an object we called `mod1`.

- The first argument of `lm` is called the "formula". Our formula here was `log(INCWAGE) ~ FEMALE`. A formula has the pattern `Y ~ X1 + X2 + X3`. The variable to the left of the tilde symbol `~` is the outcome variable and the variables to the right of the tilde are the covariates. Each covariate is separated by a `+` symbol. In our example, we have only one covariate, `FEMALE`.

- The second argument of `lm` is the dataframe to use for the regression. In this case, the dataframe we're using is `df`.

- The `weights` argument of `lm` tells R what to use as the sample weights. In our data, the appropriate weight variable is `PERWT`. Sample weights are only required if your dataset is a stratified sample.

- `stargazer` is the command to produce a regression output table. It takes as arguments the stored results you want to generate a table for. For now, don't worry about the `type` and `keep.stat` arguments.

You should see output that looks like:

    ========================================
                     Dependent variable:    
                 ---------------------------
                        log(INCWAGE)        
    ----------------------------------------
    FEMALE                -0.313***         
                           (0.005)          
                                            
    Constant              10.860***         
                           (0.004)          
                                            
    ----------------------------------------
    Observations           140,615          
    R2                      0.024           
    ========================================
    Note:        *p<0.1; **p<0.05; ***p<0.01

Here's how we interpret the results:

- The estimated coefficient on `FEMALE` is -0.313. This means that log wage income is 0.313 lower for females than for males, when we don't control for anything else. A 0.313 difference in log wage is about a 31.3% difference in actual wage. Does this sound right to you?

- The 0.005 under the -0.313 is called a standard error. Roughly speaking, it measures how much uncertainty there is in our "point estimate" of -0.313. Standard errors help us construct **confidence intervals** of the point estimate. A the 95% confidence interval is equal to the point estimate plus or minus 1.96 times the standard error:

    $$ \text{Confidence Interval} = \text{Point Estimate} \pm 1.95 \text{S.E.} $$

    So our 95% confidence interval for the coefficient on female is $-0.313 \pm 1.96 \times 0.005 = [-0.3228, -0.3032]$. Roughly speaking, we can be 95% confident that the "true" coefficient on female lies between -0.3228 and -0.3032 (true only if the model itself is correctly specified).
    
- The three stars next to -0.313 indicate that the p-value of the estimate is less than 0.01. For linear regressions, this means that we are 99% confident that the true coefficient is not zero. 

    If there were two stars that would indicate the p-value is less than 0.05 but more than 0.01, which means we are 95% confident that the true coefficient is not zero, but we are not 99% confident.
    
    If there was one star that would indicate that the p-value is less than 0.1 but more than 0.05. This would mean that we are 90% confident that the true coefficient is not zero, but not 95% confident.
    
    No stars means that we are not even 90% confident that the true coefficient is not zero. 
    
    When the p-value is low (and thus the coefficient estimates have the stars), we say that the estimate is **statistically significant**. Statistical significance means that we can be confident that the covariate does indeed have an influence on the outcome variable (again, assuming that the model is correctly specified).
    
    Interpretation of the stars can be seen from the note at the bottom of the table, which Stargazer automatically prints.
    
    It's important to remember that a lack of statistical significance does not mean that two variables are not related. It may simply mean that we can't detect the relationship because the data is too noisy.
    
    By contrast, statistical significance does not necessarily mean that the two variables are causally related. Your model could be incorrectly specified, or there could be an endogeneity problem. 
    
    Correctly interpreting regression coefficients and persuading others of their meaning is part of the art of statistical research.
    
- Our estimate for the intercept is 10.86 with a standard error of 0.004. It has a p-value of less than 0.01 which means we are more than 99% confident the true intercept is not zero. 

- The table also shows information about the number of observations and the **R-squared**. R-squared measures the percentage of variation in the outcome variable that the model can explain. So a R-squared of 0.024 means that the model can explain only 2.4% of the variation in the data. That means that 97.6% of the variation in log-wages is left unexplained by our model! That is, the error term captures 97.6% of the variation and our covariates captures only 2.4% of it.

    A low R-squared does not mean that the model is bad. It means that the model has low predictive power. But the model can still be useful for revealing relationships between variables. Our simple model showed a strong relationship between gender and wage income---a useful result even if the model can't predict wage income accurately!
    

### Estimation with two variables and displaying regressions side by side

Do you really believe that women make 30% less than men for equal work? The previous regression seems to support that claim.

But what if the model is incorrectly specified? Remember, the model assumes that the error term is uncorrelated with the covariates. Do you think this assumption is reasonable? 

When the regression model is `log(INCWAGE) ~ FEMALE`, what factors do you think might be captured by the error term? Is there any possibility that they would actually be correlated with `FEMALE`?

One potential factor is hours worked. If men work more hours than women, then that could explain why they get paid more overall. Let's test this new hypothesis by adding `log(UHRSWORK)` to the regression. Note that we use the log of hours worked because that's what our model suggested is the appropriate functional form.

Run the following script:

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
    
    # Create a boolean variable for whether the person is female
    df$FEMALE <- df$SEX==2
    
    # Regress annual wage income on female
    mod1 <- lm(log(INCWAGE) ~ FEMALE, data=df, weights=PERWT)
    
    # Regress annual wage income on female and hours worked
    mod2 <- lm(log(INCWAGE) ~ FEMALE + log(UHRSWORK), data=df, weights=PERWT)

    # Display the model results with Stargazer
    stargazer(mod1, mod2, type="text", keep.stat=c("n","rsq"))

You should see the following output, which puts the results of the two models side by side. This format is very useful for comparing coefficient estimates between related models.

    ==========================================
                      Dependent variable:     
                  ----------------------------
                          log(INCWAGE)        
                       (1)            (2)     
    ------------------------------------------
    FEMALE          -0.313***      -0.162***  
                     (0.005)        (0.005)   
                                              
    log(UHRSWORK)                  1.266***   
                                    (0.006)   
                                              
    Constant        10.860***      6.179***   
                     (0.004)        (0.024)   
                                              
    ------------------------------------------
    Observations     140,615        140,615   
    R2                0.024          0.237    
    ==========================================
    Note:          *p<0.1; **p<0.05; ***p<0.01


Note the following key observations:

- The coefficient on `FEMALE` fell from -0.313 to -0.162 once `log(UHRSWORK)` is controlled for. This suggests that part of the gender wage gap is explained by the number of hours worked. However, hours worked does not explain the entire gender wage gap. Women still make about 15% less than men, even after taking into account the number of hours worked.

- The R-squared jumped from 2.4% to 23.7%. This suggests that although both gender and hours worked are statistically significant factors that influence wage income, hours worked has relatively more *explanatory power* in the sense that it captures more of the variation in wage income than gender does. 

- The coefficient on `log(UHRSWORK)` is 1.266 and highly statistically significant. When the log of an outcome variable is regressed on the log of a covariate, the coefficient can be interpreted as an elasticity. Thus, a coefficient of 1.266 implies that a 1% increase in hours worked leads to a 1.26% increase in annual wage income. This suggests that workers with a higher hourly wage also tend to work more hours.


### Controlling for factor variables

Now let's also control for the industry in which the person works. The `IND` variable contains this information. Since `IND` is a factor variable, we have to let R know this before we use it in a regression.

Run the following script:

    rm(list=ls())      # Clear the workspace
    library(dplyr)     # Load required libraries
    library(stargazer)
    
    # Load the data and merge them
    df1 <- read.csv("IPUMS_ACS2019_CA_1.csv")
    df2 <- read.csv("IPUMS_ACS2019_CA_2.csv")
    df <- inner_join(df1, df2, by=c("YEAR","SERIAL","PERNUM"))
    
    # Deal with missing values for INCWAGE
    df$INCWAGE[ df$INCWAGE>=999998] <- NA
    
    # Tell R that IND is a factor variable
    df$IND <- as.factor(df$IND)
    
    # Focus on employed individuals age 25 to 65 that make positive wage income
    df <- filter(df, AGE>=25 & AGE<=65 & EMPSTAT==1 & INCWAGE>0)
    
    # Create a boolean variable for whether the person is female
    df$FEMALE <- df$SEX==2
    
    # Regress annual wage income on female
    mod1 <- lm(log(INCWAGE) ~ FEMALE, data=df, weights=PERWT)
    
    # Regress annual wage income on female and hours worked
    mod2 <- lm(log(INCWAGE) ~ FEMALE + log(UHRSWORK), data=df, weights=PERWT)
    
    # Regress annual wage income on female, hours worked, and industry of work
    mod3 <- lm(log(INCWAGE) ~ FEMALE + log(UHRSWORK) + IND, data=df, weights=PERWT)
    
    # Display the model results with Stargazer
    stargazer(mod1, mod2, mod3, type="text", keep.stat=c("n","rsq"))




## Takeaways

- You can run linear regressions in R
- You can show regression output using Stargazer
- You can interpret regression results







