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
        r1 <- felm(LOGWAGE ~ FEMALE, data=df, weights=df$PERWT)
        
        # Show the regression results
        summary(r1)
        
You should see a table that looks like this:

                 Estimate Std. Error t value Pr(>|t|)    
    (Intercept) 10.859859   0.003574 3038.32   <2e-16 ***
    FEMALETRUE  -0.313058   0.005271  -59.39   <2e-16 ***
    ---
    Signif. codes:  0 ???***??? 0.001 ???**??? 0.01 ???*??? 0.05 ???.??? 0.1 ??? ??? 1
    
The model you just estimated is the following:

$$\ln Y_i = \beta_0 + \beta_1 FEMALE_i + \epsilon_i$$

Note that because you are using weighted survey data, it was important to specify the weights in the regression command, `felm`.

With the data, you estimated a value of $10.86$ for $\beta_0$ and $-0.313$ for $\beta_1$. The model suggests that log wage income for females is $0.313$ less than log wage income for men. Since log-differences are approximately equal to percentage differences, this suggests that women make 31% less than men do.

### Controlling for hours worked

You could criticize the previous regression by saying that it doesn't control for hours worked. Hours worked is a confounding factor because it may be correlated with gender and it also affects total wage income. 

2. To control for hours worked, add the following lines to your script and execute:

        # Create log hours worked variable
        df$LOGHRS <- log(df$UHRSWORK)

        # Run a regresion of LOGWAGE on FEMALE and LOGHRS
        # Store the result in r2
        r2 <- felm(LOGWAGE ~ FEMALE + LOGHRS, data=df, weights=df$PERWT)
        
        # Show the results of r2
        summary(r2)
        
You should see the following results:

                 Estimate Std. Error t value Pr(>|t|)    
    (Intercept)  6.178838   0.023871  258.84   <2e-16 ***
    FEMALETRUE  -0.162114   0.004724  -34.32   <2e-16 ***
    LOGHRS       1.266368   0.006401  197.84   <2e-16 ***
    ---
    Signif. codes:  0 ???***??? 0.001 ???**??? 0.01 ???*??? 0.05 ???.??? 0.1 ??? ??? 1

Adding `LOGHRS` to the regression reduced the magnitude of the coefficient on `FEMALE`. It suggests that part of the 31% raw earnings differential between men and women is due to differences in hours worked. However, differences remain. After controlling for hours worked, the model still shows that females make 16% less than men do.

### Controlling for industry of occupation

What if women choose to work in lower paid industry than men? To rule out this explanation, we can control for industry of occupation. 

Industry is encoded in the variable `IND`. However, you can't just toss `IND` into the regression equation because `IND` is a categorical (or factor) variable. Meaning it is coded as numbers but the numbers themselves have no meaning. Thankfully, R knows how to handle categorical variables in regressions as long as you tell it which are categorical.

3. Add the following lines to your script and execute:

        # Run a regression of LOGWAGE on FEMALE, LOGHRS, IND
        # Store the results in r3
        r3 <- felm(LOGWAGE ~ FEMALE + LOGHRS | IND, data=df, weights=df$PERWT)
    
This line of code estimates a linear model, telling R that `IND` is a factor variable because it comes after the pipe |. When you include a factor variable in the regression, you estimate the following model:

$$\ln Y_i = \beta_0 + \beta_1 FEMALE_i + \beta_2 \ln HOURS_i + \beta_3 (INDUSTRY_i==1) + \beta_4 (INDUSTRY_i==2) + \ldots + \epsilon_i$$

That is, a separate coefficient is estimated for each possible value of the industry, excluding a base level. The base level is chosen automatically by R. The coefficients estimate how much each industry contributes to the outcome, over and above the base level. When a separate effect is estimated for each possible value of a variable, we call these "fixed effects". Adding fixed effects to a model is also sometimes known as "dummy variable encoding" or "one hot encoding".

If you type `summary(r3)` in the console, you will get this result:

                Estimate Std. Error t value Pr(>|t|)    
    FEMALETRUE -0.187187   0.004684  -39.96   <2e-16 ***
    LOGHRS      1.143053   0.005931  192.73   <2e-16 ***
    ---
    Signif. codes:  0 ???***??? 0.001 ???**??? 0.01 ???*??? 0.05 ???.??? 0.1 ??? ??? 1

By default, the factor variable coefficients are not shown because the table would be too large (there are 268 industry codes). But the results show that controlling for industry actually slightly [i]increases[/i] the estimated male-female wage differential. So you can't explain the male-female wage differential by saying that women work in lower-paid industries; at least not for California in 2019.

### Using Stargazer to compare results

`Stargazer` is a package that gives you more control over the display of your regression results. It also lets you compare results between two or more regressions.

4. Add the following lines to your script and execute:

        # Compare regression results
        stargazer(r1, r2, r3, type="text", 
          keep = c("FEMALE", "LOGHRS"),
          add.lines = list(
            c("Industry FE", "N", "N", "Y")
          )
        )

You should get output that looks like:

    ================================================================================
                                            Dependent variable:                     
                        ------------------------------------------------------------
                                                  LOGWAGE                           
                                (1)                  (2)                 (3)        
    --------------------------------------------------------------------------------
    FEMALE                   -0.313***            -0.162***           -0.187***     
                              (0.005)              (0.005)             (0.005)      
                                                                                    
    LOGHRS                                        1.266***            1.143***      
                                                   (0.006)             (0.006)      
                                                                                    
    --------------------------------------------------------------------------------
    Industry FE                  N                    N                   Y         
    Observations              140,615              140,615             140,615      
    R2                         0.024                0.237               0.377       
    Adjusted R2                0.024                0.237               0.375       
    Residual Std. Error 10.149 (df = 140613) 8.976 (df = 140612) 8.120 (df = 140345)
    ================================================================================
    Note:                                                *p<0.1; **p<0.05; ***p<0.01

This lets us see how our coefficient of interest, `FEMALE`, changes as more controls are added. The table shows us that controlling for hours worked explains much of the overall difference between male and female earnings, but not all of it. By contrast, different industries of work do not appear to explain much of the male-female wage differential.

### Assignment

In addition to the three regression you already ran, run these as well:

- `r4`: In addition to hours worked and industry, create a variable `COLLEGE` which indicates whether the person has a bachelors' degree or higher. Create another variable `MARRIED` to indicate whether the person is married. Include both variables and `AGE` in the regression.

- `r5`: In addition to the college indicator, control for the field of study (`DEGFIELD`), the occupation (`OCC`), the race (`RACE`), and the county of residence (`COUNTYFIP`). These are all factor variables that you can include as fixed effects. Hint: To control for more than one factor variable, you can use the notation `felm(Y ~ X1 + X2 | F1 + F2 + F3)` where `F1`, `F2`, and `F3` are the factor variables.

Put all 5 regressions together in one table using stargazer. Make sure the coefficients for `FEMALE`, `COLLEGE`, `MARRIED`, `AGE`, and `LOGHRS` are shown in the table. Then answer the questions on the Canvas assignment and show me your regression output.

### Takeaways

- You can estimate linear models using regression analysis in R
- YOu can interpret the output of linear regressions in R
- You can compare regression results using stargazer





















