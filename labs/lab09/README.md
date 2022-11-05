# ECON 433 - Lab Session 9
## Difference-in-differences Analysis

In this lab you will conduct difference-in-differences analysis using both graphical and regression-based methods.

### Setup
For this lab you will need the `dplyr`, `lfe`, `ggplot2`, and `lfe` packages. Make sure these are installed and loaded using `install.packages` and `library`. You will also need the file `airbnb.csv` which is on Canvas.

### Data Description

You will be using simulated data from a hypothetical world. In this hypothetical world, four cities passed Airbnb regulations in 2015 and four cities did not. The cities that passed Airbnb regulations were Los Angeles, New York, Las Vegas, and San Francisco. The four cities that did not are Raleigh, Tucson, Phoenix, and Columbus.

You have data on the number of Airbnb listings in each of these cities from 2008 to 2022, along with some demographic information.

`airbnb.csv`: Each row represents a city/year. The number of Airbnb listings in that year is recorded, as well as the population, the average household income, and the number of tourists. 

### Objective

Your goal is to use difference-in-differences to estimate the causal effect of the regulations on the number of Airbnb listings.

### Instructions

Start a new script. You can use `lab09_starter.R` as a base for the script.

1. Start by loading `airbnb.csv`. Check the list of cities in the dataset and the list of years using the `unique` function.

2. With many economic variables it's often better to work in logs, because log-differences are approximately equal to percent-differences. Define new variables for the log of `airbnb_listings`, `population`, `avg_hh_income`, and `tourists`.

3. Plot log Airbnb listings over time for each city on the same graph. The starter script shows you how to do this: you just have to fill in the blanks. Add a vertical line to indicate the treatment year. This is good practice when doing diff-in-diff analysis to highlight the effect of policy.

4. The plot is a bit messy since there are many cities and they have different baseline levels of Airbnb. It might be good to plot the average of log Airbnb over time by the treatment/control groups. (The treatment group is the group of cities that passed Airbnb regulations and the control group is the group of cities that did not.) 

5. To make this plot, you first need to define a variable called `treatment` that equals 1 if the city passed regulations in 2015 and 0 otherwise.

6. Then, you need to group the data by (`treatment`, `year`) and calculate the average of `log_airbnb` within those groups. Call the collapsed dataframe `df2`.

7. With `df2`, plot the average of `log_airbnb` over time by treatment/control groups. What do you notice about the treatment group relative to the control group? Do they look like they are trending differently prior to treatment? What about after treatment?

8. We can formalize the results using regression analysis. The standard approach for conducting diff-in-diff analysis with a regression is to estimate the model:

$$Y_{it} = \beta_0 + \beta_1 Treatment_{i} + \beta_2 Post_{t} + \beta_3 Treatment_{i} \times Post_{t} + \epsilon_{it}$$

    Here $i$ is a city and $t$ is a year. $Treatment_{i}$ is equal to 1 if the city is in the treatment group and 0 otherwise. $Post_{t}$ is equal to 1 if the year is greater than 2015 and 0 otherwise. $\beta_3$ is the coefficient of interest, as it tells us how the outcome variable changes for the treatment group after treatment occurs.






