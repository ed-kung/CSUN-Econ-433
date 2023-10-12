# ECON 433 - Lab Session 8
## Panel Data and Difference-in-Differences Analysis

In this lab you will conduct difference-in-differences analysis using panel data.

## Background


### Difference-in-differences

Difference-in-differences (DID) is a research design for estimating the effect of an intervention, or treatment. In Public Economics, the intervention is often a policy of some kind. For example, we might use DID to study the effect of Airbnb regulations on the number of Airbnb listings or the number of housing permits.[^1]

DID works when there is a group of subjects affected by the intervention (called the **treatment group**) and a group of subjects not affected by the intervention (called the **control group**). In DID, we compare the **change** in outcomes for the treatment group to the **change** in outcomes for the control group, over the time period in which the intervention happens.

The table below shows a schematic of the most basic DID with two subjects and two time periods. The treatment happens between times $T_0$ and $T_1$. $Y_{00}$ is the outcome in the control subject at time $T0$ and $Y_{01}$ is the outcome in the control subject at time $T_1$. $Y_{10}$ is the outcome in the treatment subject at time $T_0$ and $Y_{11}$ is the outcome in the treatment subject at time $T_1$.

|                     | $T_0$    | $T_1$    |
| ------------------- | -------- | -------- |
| Control Subject     | $Y_{00}$ | $Y_{01}$ |
| Treatment Subject   | $Y_{10}$ | $Y_{11}$ |

We can thus write:

$$\text{Change in the outcome for the control subject} = Y_{01} - Y_{00}$$

$$\text{Change in the outcome for the treated subject} = Y_{11} - Y_{10}$$

The **difference-in-differences** treatment effect estimator is:

$$
\begin{align}
\text{DID Estimated Treatment Effect} &= \text{Change in outcome for treated} - \text{Change in outcome for control} \\
&= (Y_{11} - Y_{10}) - (Y_{01} - Y_{00})
\end{align}
$$

Notice how the DID estimator takes the difference of two differenecs, hence the name "difference-in-differences".

### Panel Data

Panel data refers to data in which the same subjects are observed repeatedly over multiple time periods. DID analysis can only be performed on panel data. Obervations in panel data are indexed by $i$, which indexes the subject, and $t$, which indexes the time period. So, $Y_{it}$ would refer to the outcome variable for subject $i$ in time $t$.

With panel data, DID analysis can be conducted using linear regressions. Suppose the intervention happens between time $T_{0}$ and $T_{1}$. Define $Post_{t}$ as a binary variable equal to 1 if $t \geq T_{1}$ and 0 otherwise.  Define $Treated_{i}$ as a binary variable equal to 1 if subject $i$ is in the treatment group and 0 otherwise. Then the DID treatment effect estimator is equal to the estimated coefficient $\beta_{1}$ in the following regression:

$$Y_{it} = \beta_0 + \beta_1 Treated_{i} \times Post_{t} + \delta_{i} + \gamma_{t} + \epsilon_{it}$$

Here, $\delta_{i}$ are dummy variables for each subject and $\gamma_{t}$ are dummy variables for each time period.  

If you had a dataframe called `df` in R with the following structure:

| Subject | Time | Outcome | Treated | Post |
| ------- | ---- | ------- | ------- | ---- |
| ...     | ...  | ...     | ...     | ...  |

Then the DID treatment effect can be estimated with the following R code:

    felm(Outcome ~ Treated*Post | Subject + Time, data=df)

### Graphical Analysis of Pre-Trends

DID is only valid if the treatment and control groups have similar time trends prior to the intervention happening. To verify this, you can plot the average outcomes in the treatment and control groups over time and show that prior to the intervention they had similar trends.

If you had a dataframe called `df` in R with the same structure as above, you can accomplish this plot with the following code:

    plot_df <- df %>%
	  group_by(Treated, Time) %>%
      summarize(MeanOutcome = mean(Outcome)) 
    
    ggplot(data=plot_df) + 
      geom_line(aes(x=Time, y=MeanOutcome, color=Treated)) 	

This would give you a plot with two lines. One line shows the path of outcomes over time for the treatment group and the other line shows the path of outcomes over time for the control group. You can then verify that prior to the intervention the two lines had similar time trends.


## Lab Work

### Setup

For this lab you will need the file `airbnb.csv` which can be downloaded from Canvas.

You will also need the packages `dplyr`, `stargazer`, `lfe`, and `ggplot2`. These should be already installed from previous labs, but if they are not you can install them with `install.packages`.

### Data Description

`airbnb.csv` is a csv file where each row represents a city-year. It is therefore panel data where the subjects are the cities and the time period is a year. The file has the following columns:

- `city`: the name of the city
- `year`: the year of the data
- `airbnb_listings`: the number of Airbnb listings in that city-year
- `population`: the total population in that city-year
- `avg_hh_income`: the average household income in that city-year
- `tourists`: the number of tourists who visited the city in that year

### Objective 

Between 2015 and 2016, four cities passed regulations restricting Airbnb: New York, Los Angeles, San Francisco, and Las Vegas. The four other cities in the data, Raleigh, Tucson, Phoenix, and Columbus, did not pass any Airbnb regulations.

Your objective is use DID to estimate the effect of passing Airbnb regulations on the number of Airbnb listings. You will conduct both a graphical and a regression analysis.

### Instructions

Write a script that accomplishes the following tasks:

1. Show that there are no differential pre-trends in the number of Airbnb listings between the cities that passed Airbnb regulations and those that didn't. [Hint: Calculate the average of `log(airbnb_listings)` for both by group and by year, then plot the averages.]

    - For this plot, label the X axis "Year", the Y axis "log(Airbnb Listings)" and give it a title of "Log Airbnb Listings by Treatment/Control".
	
	- Bonus: Add a fancy dotted line to the plot to show where the intervention occurred. You can do so by adding `geom_vline(xintercept=2015.5, linetype="dashed")` to your ggplot code

2. Report the results from the following regressions:
	- Regress `log(airbnb_listings)` on `treatedXpost` and dummies for `city` and `year`.
	- Regress `log(airbnb_listings)` on `treatedXpost`, `log(population)`, `log(avg_hh_income)`,  `log(tourists)`, and dummies for `city` and `year`.

Here is the skeleton of a script to get you started:

	rm(list=ls())      # Clear the workspace
	library(dplyr)     # Load required libraries
	library(lfe)
	library(stargazer)
	library(ggplot2)

	# Load airbnb.csv into a dataframe called df
	df <- read.csv("airbnb.csv")

	# Create a variable called treated which is TRUE if the city 
	# passed an Airbnb regulation between 2015 and 2016
	df$treated <- df$city %in% c('New York', 'Los Angeles', 'San Francisco', 'Las Vegas')

	# Create a variable called post which is TRUE if the year is
	# 2016 or later
	# YOUR CODE HERE
	
	# Create a variable that is equal to treated times post and 
	# call it treatedXpost
	# YOUR CODE HERE

	# Create a DID analysis plot showing the trends in log(airbnb_listings) 
	# for the treatment and the control groups
	# YOUR CODE HERE

	# Run the DID regressions
	# YOUR CODE HERE

	stargazer(r1, r2, type="text")

Show me your code and output and take the lab quiz to be dismissed.

## Takeaways

- You understand what panel data is
- You can conduct DID analysis using both graphs and regressions

 
[^1] Ron Bekkerman, Maxime Cohen, Edward Kung, John Maiden, and Davide Proserpio (2023). "The Effect of Short-Term Rentals on Residential Investment." *Marketing Science* 42(4):819-834. [Link](https://pubsonline.informs.org/doi/abs/10.1287/mksc.2022.1409)















