# ECON 433 - Lab Session 6
## Data Visualization

In this lab you will learn how to create some simple graphs in R.

- Line plot. Use a line plot to show how two a numerical variable Y changes when a numerical variable X changes. Use when there is only one value of Y for each value of X. Example: How does average income change with age?

- Bar chart. Use a bar chart to show the values of a numerical variable Y for each value of a categorical variable X. Example: Fraction of population with each degree type.

- Scatter plot. Use a scatter plot to visualize each record in your dataset along two dimensions. Good for finding patterns in the data, but can get messy if you have too many points. 

### Setup

For this lesson you will need the `dplyr` and `ggplot2` packages. Make sure they are installed with `install.packages("dplyr")` and `install.packages("ggplot2")` and loaded with `library(dplyr)` and `library(ggplot2)`. You will also need the files:

- `IPUMS_ACS2014_CA_1.csv`
- `IPUMS_ACS2014_CA_2.csv`
- `DEGFIELD_CODES.csv`

Make sure these files are in your working directory before beginning.

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

### Bar charts

Now you will make a horizontal bar chart showing the percentage of the college-educated population in each degree field.

2. Add the following to your script and execute:

        # Keep only people with a bachelors degree or higher, 
        # group by degree field, and calculate total pop for each field
        pop_by_deg <- filter(df, EDUCD>=101, EDUCD<=116) %>% 
          group_by(DEGFIELD) %>% 
          summarize(
            POP = sum(PERWT)
          )
        
        # Calculate population shares
        pop_by_deg$POPSHARE <- pop_by_deg$POP / sum(pop_by_deg$POP)
        
        # Merge degree field names
        dcodes <- read.csv("DEGFIELD_CODES.csv")
        pop_by_deg <- inner_join(pop_by_deg, dcodes, by="DEGFIELD")
        
        # Bar chart
        ggplot(data=pop_by_deg) + 
          geom_col(aes(x=DegreeField, y=POPSHARE)) + 
          coord_flip()
         
You should see a bar chart showing the share of college-educated population with each degree field. Bar charts are useful for visualizing numerical values against non-numerical categories. `coord_flip()` in the code above changes the bar chart from vertical to horizontal. We did that so that the degree fields are more readable. Try running the code without `coord_flip()` to see what happens.

### Scatter plots

Now you will make a scatter plot showing average wage income in a county on the Y axis and the share of college-educated individuals in the county on the X axis. 

4. Add the following code to your script and execute:

        # Make a college variable (BA or higher)
        df$COLLEGE <- df$EDUCD>=101 & df$EDUCD<=116
        
        # Keep only working individuals aged 25 to 65, 
        # group by county, and calculate average income 
        # and share of college-educated
        county_df <- filter(df, EMPSTAT==1, AGE>=25, AGE<=65) %>% 
          group_by(STATEFIP, COUNTYFIP) %>% 
          summarize(
            MEAN_WAGE = weighted.mean(INCWAGE, PERWT, na.rm=TRUE), 
            COL_SHARE = weighted.mean(COLLEGE, PERWT, na.rm=TRUE), 
            POP = sum(PERWT)
          )
        
        # Scatter plot
        ggplot(data=county_df) + 
          geom_point(aes(x=COL_SHARE, y=MEAN_WAGE, size=POP))
          
You should see a scatter plot showing average income on the Y axis and college share on the X axis. Each dot is a county. The size of the dot represents the population of the county. 

The plot shows that there's a tight, but not perfect, relationship between education and income at the county level.

### Assignment

Your assignment is to write a script that creates a scatter plot showing unemployment rate in a county on the Y axis and college share on the X axis. The size of the dot should represent the population of the county. For the population to calculate on, please use individuals aged 25 to 65 that are in the labor force.

### Takeaways

- You can create line plots, scatter plots, and bar charts in R.
- You know where to look if you want to generate more complex charts and graphs.












