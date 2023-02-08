# Econ 433 - Lab Session 4
## Computing Group Summary Statistics

In this lab you will learn how to calculate summary statistics based on different groups in your data. This would allow you to calculate, for example, average income for college vs. non-college educated workers in California in 2014 and 2019.

## Lab Work

### Setup

For today's lab you will need the following files. They should already be uploaded to the cloud from the last lab. If they aren't, you should download these files from Canvas and upload them.

- `IPUMS_ACS2014_CA_1.csv`
- `IPUMS_ACS2014_CA_2.csv`
- `IPUMS_ACS2019_CA_1.csv`
- `IPUMS_ACS2019_CA_2.csv`

For today's lab you will also need the package `dplyr`. This should already be installed from the last lab so you shouldn't need to install it again. If you do need to install it again, you can install it with the command `install.packages("dplyr")` from the console.

### Creating a Data Load Script

In Lab 03, you created a script that (1) Loads and merges the two 2014 files, (2) Loads and merges the two 2019 files, and (3) appends them together. Today, we will see how we can re-use scripts that you wrote previously.

Create a new script that contains the following code:

    # Load and merge the two data files for 2014
    df2014_1 <- read.csv("IPUMS_ACS2014_CA_1.csv")
    df2014_2 <- read.csv("IPUMS_ACS2014_CA_2.csv")
    df2014 <- inner_join(df2014_1, df2014_2, by=c("YEAR","SERIAL","PERNUM"))
    
    # Load and merge the two data files for 2019
    df2019_1 <- read.csv("IPUMS_ACS2019_CA_1.csv")
    df2019_2 <- read.csv("IPUMS_ACS2019_CA_2.csv")
    df2019 <- inner_join(df2019_1, df2019_2, by=c("YEAR","SERIAL","PERNUM"))
    
    # Append the dataframes from 2014 and 2019
    df <- rbind(df2014, df2019)
    
    # Clean up no longer needed dataframes
    rm(df2014_1, df2014_2, df2014, df2019_1, df2019_2, df2019)
    
Save this script as `dataload.R`.




