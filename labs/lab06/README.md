# ECON 433 - Lab Session 6
## Data Visualization

In this lab you will learn how to create some simple graphs in R.

- Line plot. Use a line plot to show how two a numerical variable Y changes when a numerical variable X changes. Use when there is only one value of Y for each value of X. Example: How does average income change with age?

- Bar chart. Use a bar chart to show the values of a numerical variable Y for each value of a categorical variable X. Example: Fraction of population with each degree type.

- Scatter plot. Use a scatter plot to visualize each record in your dataset along two dimensions. Good for finding patterns in the data, but can get messy if you have too many points. 

### Line Plots

In this example, you will create a line plot that shows the average wage income of employed people in California for each age level.

1. Create the following script and execute:

        rm(list=ls()) # clear the workspace
        
        # Load required packages
        library(ggplot2)
        library(dplyr)
        
        # Load the datasets
        df1 <- read.csv("IPUMS_ACS2019_CA_1.csv")
        df2 <- read.csv("IPUMS_ACS2019_CA_2.csv")
        df <- inner_join(df1, df2, by=c("YEAR","SERIAL","PERNUM"))
        
        # Deal with missing values for INCWAGE
        df$INCWAGE <- ifelse(df$INCWAGE>=999998, NA, df$INCWAGE)
        
        # Keep only employed individuals between ages of 25 and 65, 
        # group by age, and calculate average income
        inc_by_age <- filter(df, EMPSTAT==1, AGE>=25, AGE<=65) %>%
          group_by(AGE) %>% 
          summarize(
            MEAN_WAGE = weighted.mean(INCWAGE, PERWT, na.rm=TRUE)
          )
         
        # Plot income by age
        ggplot(data=inc_by_age) + 
          geom_line(aes(x=AGE, y=MEAN_WAGE))

You should see a line plot of average income by age in the Plots window. The inverted-U shape is a well-known pattern to economists. Income generally rises from youth to middle age, but decline towards retirement age. 

The graph is not very pretty. R has a robust set of tools for sprucing up your graphics. The code block below shows an example of how to make the graph look nicer. 

    ggplot(data=inc_by_age) +
      geom_line(aes(x=AGE, y=MEAN_WAGE)) + 
      ggtitle("Average Wage Income by Age: California 2019") + 
      xlab("Age") + 
      ylab("Average Income") + 
      theme_bw()

Don't worry about learning everything `ggplot` right now. There are plenty of books and online resources avialable if you need to dive deeper. Sometimes a quick google search for what you're trying to do is enough to find a solution.