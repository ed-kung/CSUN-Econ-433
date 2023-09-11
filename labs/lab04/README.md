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

### Saving a Dataframe

In Lab 03, you created a script that (1) Loads and merges the two 2014 ACS files, (2) Loads and merges the two 2019 ACS files, and (3) appends them together. 

Suppose you want to re-use the merged and appended data. You could rewrite the merging and appending code everytime you wanted to re-use that data. **OR** you could save the merged and appended data as a new csv file.

The latter is the better option if you plan to re-use the data many times. 

To save the merged and appended data as a new file, create a new script that contains the following code:

	rm(list=ls())   # Clear the workspace
	library(dplyr)  # Load the dplyr library

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
    
    # Save the file to csv
	write.csv(df, "IPUMS_ACS_CA_2014_2019.csv", row.names=FALSE)
    
Save this script as `create_ACS_2014_2019.R` and execute it. `write.csv` is the command that writes the dataframe to a CSV file.

A file named `IPUMS_ACS_CA_2014_2019.csv` should now appear in the file browser.  You can now re-use this file without having to write all the above code to merge and append the smaller datasets.

Now try loading your newly created data file!  Type `rm(list=ls())` to clear the workspace, then type `df <- read.csv("IPUMS_ACS_CA_2014_2019.csv")` and see if you can read your data file.

### Calculating Group-Based Summary Statistics

A common task in data analysis is to compute summary statistics for different groups within your data. 

For example, we may be interested in calculating the average income for college and non-college educated workers. We may further want to break that down by male and female, or by year, or by geographic location. There are many different ways to cut the data, each of which can yield different insights. 

The following script shows an example for how we calculate average income of employed workers by college education, year, and sex, using our ACS data from California in 2014 and 2019.

    rm(list=ls())    # Clear the workspace
    library(dplyr)   # Load dplyr
    
    df <- read.csv("IPUMS_ACS_CA_2014_2019.csv")   # Load the data
    
    # Keep only employed, working-age adults
    df <- filter(df, EMPSTAT==1 & AGE>=25 & AGE<=65)
    
    # Create a variable for whether the person has bachelors degree or higher
    df$COLLEGE <- (df$EDUCD>=101 & df$EDUCD<999)
    
    # Calculate average income by college education, year, and sex
    grouped_df <- df %>% 
      group_by(COLLEGE, YEAR, SEX) %>%
      summarize(
        AVERAGE_INCOME = weighted.mean(INCWAGE, PERWT)
      )
    
    # View the table
    View(grouped_df)

You should get output that looks like the following image. What do you notice about the relative income of the college vs. non-college educated? What do you notice about the differences between men and women? How about between the years 2014 and 2019?

![screenshot](screenshot1.png)

Now let's walk through the script to see what each line of code does.

1. The first few lines of code are boilerplate. `rm(list=ls())` clears the workspace, which we should do at the start of every new task. `library(dplyr)` loads the required `dplyr` library.

2. `df <- read.csv("IPUMS_ACS_CA_2014_2019.csv")` loads the data we created into a dataframe named `df`.

3. `df <- filter(df, EMPSTAT==1 & AGE>=25 & AGE<=65)` filters the data on employed individuals (`EMPSTAT==1`) and working-age individuals (`AGE>=25` and `AGE<=65`).

4. `df$COLLEGE <- (df$EDUCD>=101 & df$EDUCD<999)` creates a new variable called `COLLEGE` which is `TRUE` if the value of `EDUCD` is between 101 and 999, and `FALSE` otherwise. The IPUMS codes for the `EDUCD` variable is shown [here](https://usa.ipums.org/usa-action/variables/EDUC#codes_section) (under "detailed codes"). 

    From these codes, we see that a value of 101 indicates that the individual has achieved a bachelor's degree, and that higher values indicate higher levels of education, until the value of 999 which indicates that the data is missing. So `COLLEGE` is simply an indicator for whether the individual has attained a bachelor's degree or higher.

5. The next command is a single command spread out over multiple lines:

        grouped_df <- df %>%
          group_by(COLLEGE, YEAR, SEX) %>% 
          summarize(
            AVERAGE_INCOME = weighted.mean(INCWAGE, PERWT)
          )
          
    There is a lot to talk about in this command, so we will go over it slowly.
    
    **The Pipe Operator**
    
    First, let's talk about `%>%`. This is called the **pipe operator**. The pipe operator "pipes" the output of one command into the input of another command. For example, `x %>% g(y)` is equivalent to writing `g(x, y)`. Essentially, the pipe operator feeds the expression on the left into the first input on the right.
	
	Pipe operators are useful for chaining together operations. For example, `f(x) %>% g(y)` is equivalent to `g(f(x), y)`. But the former is a bit easier to read and understand!
    
    So when we write `df %>% group_by(...) %>% summarize(...)`, we are asking R to first take `df`, then feed it into `group_by(...)`, then take the result of `group_by(df, ...)` and feed it into `summarize(...)`.
    
    Piping allows us to string together a complex of series of commands. To keep the code readable, it is standard practice to start a new line after `%>%`. R understands that it will evaluate the expression on the left of `%>%` and then feed it into the command on the next line.
    
    **Grouping**
    
    Now let's talk about `group_by`. `group_by` is a command that takes a dataframe as input, and then creates groups based on the specified variables. So `df %>% group_by(COLLEGE, YEAR, SEX)` tells R to take `df` and define groups based on the combinations of values for `COLLEGE`, `YEAR`, and `SEX`. 
	
	By itself, grouping doesn't do much. All it does is tell R to define these groups. We have to combine the `group_by` command with other commands like `summarize` in order to do anything meaningful.
    
    **Summarizing**
    
    Now let's talk about `summarize`. `summarize` is a command that takes a grouped dataframe as input, then calculates user-defined summary statistics for each of the defined groups. The syntax is:
    
        grouped_df <- df %>% 
          group_by(X1, X2, ...) %>% 
          summarize(
            STAT1 = function(...), 
            STAT2 = function(...),
            ...
          )
        
    `X1`, `X2`, ..., are the variables to group by. `STAT1`, `STAT2`, ..., are the names of the summary variables you want to create (you can call them anything). 
	
	For example, to calculate the weighted mean of `INCWAGE` and the median of `AGE` by `SEX` and `YEAR` in our data, we could have used:
    
        grouped_df <- df %>%
          group_by(SEX, YEAR) %>% 
          summarize(
            FOO = weighted.mean(INCWAGE, PERWT), 
            BAR = median(AGE)          
          )
    
    Notice that we can call our summary variables anything we want. In this case, we called `FOO` the weighted mean of `INCWAGE` and we called `BAR` the median of `AGE`.
    
    Going back to our script, our script has:
    
        grouped_df <- df %>%
          group_by(COLLEGE, YEAR, SEX) %>% 
          summarize(
            AVERAGE_INCOME = weighted.mean(INCWAGE, PERWT)
          )
          
    So this section of code takes `df`, groups it by `COLLEGE`, `YEAR`, and `SEX`, then calculates the weighted mean of `INCWAGE` (using `PERWT` as weights), and stores it in a variable called `AVERAGE_INCOME`. 
	
	The result of this entire operation is itself a new dataframe with one row for each combination of `COLLEGE`, `YEAR`, and `SEX`, and we named this new dataframe `grouped_df`.
    
    **Weighted Statistics**
    
    The last thing to comment on is `weighted.mean`. The ACS data is a **stratified sample**, meaning not every individual in the data was surveyed with equal probability. The ACS **oversamples** some groups and **undersamples** others. The variable `PERWT` defines how many actual people an observation is meant to represent. So `PERWT=260` on row 2 implies that the person in row 2 is representative of 260 people in real life. You can read more about `PERWT` [here](https://usa.ipums.org/usa-action/variables/PERWT#description_section).
    
    Because the ACS is a stratified sample, summary statistics need to be properly weighted. The standard formula for calculating an average is:
    
    $$\text{Mean} = \frac{1}{N}\sum_{i=1}^{N} X_i $$
    
    The formula for calculating a weighted average is:
    
    $$\text{Weighted Mean} = \frac{\sum W_i X_i}{\sum W_i}$$
    
    where $W_i$ are the weights (in this case, `PERWT`).
    
    Because `PERWT` is the number of people a row represents, we can calculate total population by adding up `PERWT`. For example, to calculate total population in California by year, we would use:
    
        grouped_df <- df %>% 
          group_by(YEAR) %>% 
          summarize(
            TOTAL_POPULATION = sum(PERWT)
          )

    **Other Statistics**
    
    Besides the weighted mean, you can also calculate other statistics like the minimum, maximum, median, standard deviation, etc. The cheat sheet linked to below shows some of the statistics that can be calculated.    
    
### dplyr Cheat Sheet 

By now you have learned a number of important data operations in R. It can be difficult to remember how to do everything properly. This is where using a cheat sheet comes in handy. I have found this [cheat sheet](https://www.rstudio.com/wp-content%2Fuploads%2F2015%2F02%2Fdata-wrangling-cheatsheet.pdf%2F) useful for remembering how to perform common tasks.


## Assignment

To be dismissed and earn your grade for this lab, you have to create a script that calculates for each `COUNTYFIP` and `YEAR`:

1. The total population in the labor force (`POP_LF`)
2. The unemployment rate (`UNEMP_RATE`)
3. The percent of individuals in the labor force with bachelor's degrees or higher (`BA_RATE`)

Here is the skeleton of a script to get you started:

    rm(list=ls())    # Clear the workspace
    library(dplyr)   # Load dplyr
    
    # Load the ACS data
	# YOUR CODE HERE
    
    # Keep only people in the labor force
	# YOUR CODE HERE

    # Create a variable for whether the person is unemployed
	# YOUR CODE HERE
    
    # Create a variable for whether the person has a bachelors degree or higher
	# YOUR CODE HERE
    
    # Calculate total population, unemployment rate, and college rate by 
    # county and year
    
    # View the table
    View(grouped_df)

Hints:
- You'll first need to filter the data to contain only people in the labor force. Use a filter for `EMPSTAT`. You can read more about `EMPSTAT` on the [IPUMS codebook](https://usa.ipums.org/usa-action/variables/EMPSTAT#codes_section).
- Total population can be calculated by summing `PERWT`.
- To calculate the percent of individuals with a BA or higher, create a variable that is `TRUE` if the person has a BA or higher and `FALSE` otherwise. Then, calculate the weighted mean of this variable. (The mean of a boolean variable is equal to the percent of people with `TRUE`.)

Once you are done, show me your script and your output to receive your grade, then take the lab quiz.

If you aren't able to finish in time, you can submit your script late for 80% credit. See [Lab 03](https://github.com/ed-kung/CSUN-Econ-433/tree/main/labs/lab03) for instructions on how to download your script and upload it to Canvas.

## Takeaways

- You know how to save data in R to a file.
- You can calculate group-based summary statitics in R.
- You know how to calculate weighted means and percentages.
- You know how to use the pipe operator in R.
