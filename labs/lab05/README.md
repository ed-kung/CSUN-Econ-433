# ECON 433 - Lab Session 5
## Data Wrangling II - Grouping and Summarizing, Reshaping

In this lab session you will learn how to collapse data and compute summary statistics by groups. You will also learn how to reshape data--from long form to wide form and back.

### Setup

For this lesson you will need the `dplyr` package. Make sure it is installed with `install.packages("dplyr")` and loaded with `library(dplyr)`. You will also need the files:
- `IPUMS_ACS2014_CA_1.csv`
- `IPUMS_ACS2014_CA_2.csv`
- `IPUMS_ACS2019_CA_1.csv`
- `IPUMS_ACS2019_CA_2.csv`
- `COUNTY_CODES.csv`
- `DEGFIELD_CODES.csv`

Make sure these files are in your working directory before beginning.

### Lab Work

You will start by calculating the average income in California counties in the years 2014 and 2019. You should work with a script for this lab because some of the commands are long and complex. Working in a script ensures that you can keep track of your commands in the order they are to be executed and that your work can be saved for later.

1. Spin up RStudio and start a new script. Write the following code into the script editor and execute the script. (Reminder: Use CTRL+SHIFT+ENTER to run the script from the top, or use CTRL+ENTER to run one line.)

        rm(list=ls())  # clear the workspace
        library(dplyr) # load dplyr
        
        df1 <- read.csv("IPUMS_ACS_2019_CA_1.csv")  # load the 2019 ACS data
        df2 <- read.csv("IPUMS_ACS_2014_CA_1.csv")  # load the 2014 ACS data
        
        df <- rbind(df1, df2)         # append the two datasets vertically
        df <- filter(df, EMPSTAT==1)  # focus on employed individuals only
        
#### Recoding missing values

The goal for this lab session is to compute average wage income by county/year. Wage income is contained in the variable `INCWAGE`.

Unfortunately, the income data has some missing values that we need to take care of first. According to [IPUMS](https://usa.ipums.org/usa-action/variables/INCWAGE#description_section), special numerical codes are used to designate not applicable / missing values for the income variable, `INCWAGE`. According to the IPUMS website:

- 999999 = N/A
- 999998 = Missing

So before we take averages, we need to transform `INCWAGE` to a missing value whenever we see the values 999999 or 999998. If we don't, R will think that these people make $999,999 a year!

2. Add the following lines to your script and execute:

        df$INCWAGE <- ifelse(df$INCWAGE>=999998, NA, df$INCWAGE)  # encode missing values for INCWAGE
        
R has a special value for missing data called NA. This line of code makes it so that `INCWAGE` gets a value of NA if INCWAGE is 999999 or 999998. Later, when calculating statistics for `INCWAGE`, you can tell R how it should treat the missing values.

#### Calculating statistics by group

Our goal is to calculate average wage income by county/year. Counties are defined by `STATEFIP` and `COUNTYFIP`. See [here](https://www.nrcs.usda.gov/wps/portal/nrcs/detail/national/home/?cid=nrcs143_013697) for more information about how counties are coded in the US.

To calculate average wage income by county/year, we need to first group the variables by `STATEFIP`, `COUNTYFIP`, and `YEAR`. Then we need to calculate the average wage income for each of these groups. Thankfully, R `dplyr` has a convenient way to calculate summary statistics by groups. 

3. Add the following lines to your script and execute:

        # Compute summary statistics by county and year
        dfg <- df %>%
          group_by(STATEFIP, COUNTYFIP, YEAR) %>% 
          summarize(
            EMPLOYED_POP = sum(PERWT),
            MEAN_WAGE = weighted.mean(INCWAGE, PERWT, na.rm=TRUE)
          )

This code block collapses df down to a dataset where each row is a unique combination of `STATEFIP`, `COUNTYFIP`, and `YEAR`. For each such combination, it calculates two variables, `EMPLOYED_POP` and `MEAN_WAGE`, where:

- `EMPLOYED_POP` is the sum of `PERWT` within each group. Remember, `PERWT` is the number of people each row in the data approximately represents.
- `MEAN_WAGE` is the mean of `INCWAGE`, weighted by `PERWT`, within each group.

Type `View(dfg)` in the console or click on `dfg` in the Environment tab to take a look at the new data frame. 

Note: The above code block makes use of the `%>%` pipe operator. The pipe operator feeds the result of the current line into the first argument of the next line. It is useful for chaining together multiple commands in which the output of one command is used as input for the next command. Don't worry if you don't fully understand it yet. You can copy the code and make modifications to achieve the desired results. With more practice you will start to build an understanding of how the pipe operator works.

#### Making the county codes human-readable

If you looked at `dfg`, you would have seen that the county codes are still numerical. Let's change that by merging on the names of the counties, which are contained in the file `COUNTY_CODES.csv`.

4. Add these lines to the your script and execute:

        # Merge on county names
        ccodes <- read.csv("COUNTY_CODES.csv")
        dfg <- inner_join(dfg, ccodes, by=c("STATEFIP", "COUNTYFIP"))

Now type `View(dfg)` in the console and you can see the statistics for the different counties in the different years.

Note: Not all counties are shown because IPUMS only labels the most populous counties. This is to prevent someone from finding out private information about an individual using the IPUMS data.

#### Reshaping long to wide

When dealing with a time dimension, it's often useful to reshape the data so that the time value is on the columns. This lets us more easily see the evolution of a unit of observation over time.

5. Add these lines to your script and execute:

        # Reshape long to wide
        dfg_wide <- pivot_wider(
          dfg, 
          id_cols = c("STATEFIP", "COUNTYFIP", "COUNTY"), 
          names_from = "YEAR", 
          values_from = "MEAN_WAGE"
        )

`pivot_wider` reshapes a dataset from long to wide format. The rows will be unique combinations of the values you specify in `is_cols`. The columns will be the values that you specify in `names_from`. And the value in the cells will be taken from the value you specify in `values_from`. In this example, unique combinations of `STATEFIP`, `COUNTYFIP`, `COUNTY` will be on the rows, `YEAR` will be on the columns, and the `MEAN_WAGE` for each county/year will be in the table cells.

Inspect the resulting dataframe with `View(dfg_wide)` in the console to get a sense of what the new data looks like. Reshaping from long to wide is especially useful for calculating changes over time. For example, enter these lines into your script:

6.

        # Calculate percent change in mean wage from 2014 to 2019
        dfg_wide$pct_chg <- log(dfg_wide$'2019') - log(dfg_wide$'2014') 
        
and inspect the dataframe again with `View(dfg_wide)`. You will see a new column calculating the percent change from 2014 to 2019.

#### Reshaping wide to long

Sometimes you find datasets in wide format and you want to make it into long format. 

7. Add the following lines of code to your script and execute:

        # Reshape wide to long
        dfg_long <- pivot_longer(
          dfg_wide, 
          cols = c("2014", "2019"), 
          names_to = "YEAR", 
          values_to = "MEAN_WAGE"
        )
        
This reverses the wide format data to long format data. Type `View(dfg_long)` in the console to see what it looks like. Long format can be more useful than wide format depending on the task. Long format is often required for panel regressions, which we'll cover later.

### Assignment

Write a script to calculate the average wage by the field of a persons Bachelor's degree by year. Focus only on individuals with Bachelor's degrees (`EDUCD>=101 & EDUCD<=116`) and those that are employed (`EMPSTAT==1`). Hint: You'll need to use the `filter` command that you learned in Lab 4. Make sure the degree codes are human readable. Reshape the data so that the years are on the columns.

Good luck!

### Takeaways

- You can compute grouped summary statitics in R.
- You can reshape tables from long to wide format and from wide to long.

















