# ECON 433 - Spring 2023 Midterm 2

In this midterm you will conduct difference-in-differences analysis on simulated health insurance data.

## Setup

You will need the file `insurance.csv` which can be downloaded from Canvas.

You will also need the packages `dplyr`, `stargazer`, `lfe`, and `ggplot2`. These should already be installed from previous labs, but if they are not you can install them with `install.packages`.

## Data Description

`insurance.csv` is a csv file where each row represents a health insurance plan in a state/year. It is therefore panel data where the subjects are health insurance plans and the time period is a year. The data covers all 50 states and has data from 2002 to 2009.

The file has the following columns:

- `PLAN_ID`: the identification number of the insurance plan
- `COMPANY_ID`: an identification number for the company that provides the plan
- `STATE`: the state that the plan is offered in
- `YEAR`: the year of the data
- `PREMIUM`: the annual premium of the insurance plan
- `AVERAGE_COST`: the average cost per enrollees the company incurs to provide the plan
- `ENROLLMENT`: the number of enrollees on the plan

## Objective

Between 2005 and 2006, Massachusetts passed a law that mandated all individuals to purchase health insurance. No other state passed a similar law in the same time period. 

Your objective is to use difference-in-differences to estimate the effect of the Massachusetts mandate on health insurance premiums, costs, and enrollment.

## Instructions

Write a script that accomplishes the following tasks:

1. Show how the average of log premium, log average cost, and log enrollment changes over time for plans in Massachusetts vs plans in other states. Show that there are no differential pre-trends between Massachusetts and other states and that starting in 2006 there is a divergence.

    - Hint 1: You will need to make three graphs, one for log premium, one for log average cost, and one for log enrollment.
    
    - Hint 2: Each graph should show two lines. One for the "treated" group, i.e. Massachusetts, and one for the "control" group, i.e. all other states. 
    
    - Hint 3: Make sure you title the plot with `ggtitle` and that you give the plot appropriate axes labels with `ylab` and `xlab`.
    
2. Run regressions of log premium, log average cost, and log enrollment on a `TREATED_X_POST` indicator and include `STATE`, `YEAR`, `PLAN_ID`, and `COMPANY_ID` as dummies. Then show the results on one table.

    - Hint 1: You should be running three regressions. The only difference in each regression is the left-hand-side variable.
    
    - Hint 2: The code pattern for including multiple variables as dummies is: `felm(Y ~ X1 | F1 + F2 + F3, data=df)` 
    
    - Hint 3: The resulting table should have one row and three columns. Use `stargazer` to create this table.
    
Submit your code to the assignment called "Midterm 2 Grade" on Canvas.

