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
        
### Recoding Missing Values

The goal for this lab session is to compute average wage income by county/year. Wage income is contained in the variable `INCWAGE`.

Unfortunately, the income data has some missing values that we need to take care of first. According to [IPUMS](https://usa.ipums.org/usa-action/variables/INCWAGE#description_section), special numerical codes are used to designate not applicable / missing values for the income variable, `INCWAGE`. According to the IPUMS website:

- 999999 = N/A
- 999998 = Missing

So before we take averages, we need to transform `INCWAGE` to a missing value whenever we see the values 999999 or 999998. If we don't, R will think that these people make $999,999 a year!

2. Add the following lines to your script and execute:

        df$INCWAGE <- ifelse(df$INCWAGE>=999998, NA, df$INCWAGE)  # encode missing values for INCWAGE
        
R has a special value for missing data called NA. This line of code makes it so that `INCWAGE` gets a value of NA if INCWAGE is 999999 or 999998. Later, when calculating statistics for `INCWAGE`, you can tell R how it should treat the missing values.

### Grouping and Summarizing

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

### Making the county codes human-readable

If you looked at `dfg`, you would have seen that the county codes are still numerical. Let's change that by merging on the names of the counties, which are contained in the file `COUNTY_CODES.csv`.

4. Add these lines to the your script and execute:

        # Merge on county names
        ccodes <- read.csv("COUNTY_CODES.csv")
        dfg <- inner_join(dfg, ccodes, by=c("STATEFIP", "COUNTYFIP"))

Now type `View(dfg)` in the console and you can see which counties are the largest, have the highest wages, and grew the fastest from 2014 to 2019.














