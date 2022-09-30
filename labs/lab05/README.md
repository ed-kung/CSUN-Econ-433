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

According to 





