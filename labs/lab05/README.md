# ECON 433 - Lab Session 5
## Data Visualization

In this lab you will learn how to create some simple charts in R. You will learn about how to create line plots, bar charts, and scatter plots. 

In the process, you will also learn about missing values and factor labels.

## Lab Work

### Setup

For today's lab you will need the following files. They should already be uploaded to the cloud from previous labs. If they aren't, you should download these files from Canvas and upload them. 

- `IPUMS_ACS2014_CA_1.csv`
- `IPUMS_ACS2014_CA_2.csv`
- `IPUMS_ACS2019_CA_1.csv`
- `IPUMS_ACS2019_CA_2.csv`

You will also need a new file:

- `DEGFIELD_CODES.csv`

Download this file from Canvas and upload it to the cloud.

For today's lab you will also need the packages `dplyr`, `ggplot2`, and `scales`. `dplyr` should already be installed from previous labs. If it isn't, install it with `install.packages("dplyr")`. Also install `ggplot2` and `scales` with `install.packages("ggplot2")` and `install.packages("scales")`. `ggplot2` is the standard library for creating charts in R. `scales` adds some useful functionality for making charts prettier.

Finally, you should have the script `dataload.R` from Lab 04.

Make sure all these files are in your working directory before beginning.

### Line Plots

A line plot is used to show the relationship between two numerical variables. Use line plots when there is only one value of Y for each value of X. Example: How does average income change with age?

The following script creates a line plot showing how average income changes with age, using the 2019 ACS data.

    rm(list=ls())    # Clear the workspace
	library(dplyr)   # Load libraries
	library(ggplot2) 
	library(scales)
	
	# Load the data
	source("dataload.R")  
	
	# Let R know about missing values for INCWAGE 
	df$INCWAGE[ df$INCWAGE>=999998] <- NA
	
	# Keep only data from 2019
	df <- filter(df, YEAR==2019)
	
	# Create a new dataframe that contains the average income for each age 
	df_inc_by_age <- df %>% 
	  group_by(AGE) %>% 
	  summarize(
	    AVG_INCOME = weighted.mean(INCWAGE, PERWT, na.rm=TRUE)
	  )

    # Plot average income by age 
    ggplot(data=df_inc_by_age) + 
      geom_line(aes(x=AGE, y=AVG_INCOME)) + 
      ggtitle("Average Income by Age, California 2019") +
      xlab("Age") + 
      ylab("Average Wage Income") + 
	  scale_y_continuous(labels=comma)
	  
Run the script from the top (`CTRL+SHIFT+ENTER`) and you should see a line plot in the "Plots" window as shown in the screenshot below:

![Screenshot of line plot](screenshot1.png)

Let's walk through each element of this script.

1. The first few lines of code are boilerplate. We clear the workspace, load the required libraries, and load the data using `dataload.R` which we wrote in Lab 04.

2. The next line of code is `df$INCWAGE[ df$INCWAGE>=999998] <- NA`. This line of code is rather complex to understand, so let's walk through it slowly.

    Overall, the purpose of this line of code is to tell R how to deal with missing values for the variable `INCWAGE`. The [IPUMS codebook](https://usa.ipums.org/usa-action/variables/INCWAGE#codes_section) tells us that when `INCWAGE` is 999998 or 999999, that means `INCWAGE` is either not applicable or unknown. Since we are going to be computing the average income by age, we don't want to include these values of 999998 or 999999 in our averages. We need to tell R that these values shouldn't be treated as numbers, but rather missing values.

    `df$INCWAGE[ df$INCWAGE>=999998] <- NA` accomplishes this. First, let's look at `df$INCWAGE[ df$INCWAGE>=999998]`. This part of the code uses the pattern `df$X[CONDITION]`, which selects only the rows of `df$X` for which `CONDITION` is true. So `df$INCWAGE[df$INCWAGE>=999998]` selects the rows of `df$INCWAGE` for which `df$INCWAGE>=999998`. If you typed `length(df$INCWAGE[df$INCWAGE>=999998])` in the console, you would get an output of `66593` showing that there are 66,593 rows with `INCWAGE>=999998`. 
	
	`df$INCWAGE[df$INCWAGE>=999998]` selects the rows of `df$INCWAGE` for which `df$INCWAGE>=999998`. Then, the part of the code that says `<- NA` assigns the value of `NA` to those rows. `NA` is the symbol that R uses to denote missing values. We therefore replace any values of `999998` and `999999` in `INCWAGE` with the symbol `NA`. Later, when we compute the group-based averages, we can tell R to ignore the missing values. 
	
	The practice of selecting certain rows of a variable is known as **indexing**. It is useful when you want to apply an operation to only a subset of the rows, but you don't want to filter the entire dataset. 
	
3. The next line of code, `df <- filter(df, YEAR==2019)` keeps only the data from 2019.

4. The next few lines of code are:

        df_inc_by_age <- df %>% 
		  group_by(AGE) %>% 
		  summarize(
		    AVG_INCOME = weighted.mean(INCWAGE, PERWT, na.rm=TRUE)
		  ) 
		  
    This command creates a new dataframe called `df_inc_by_age` where `AGE` is the primary key and there's a column called `AVG_INCOME` which is equal to the weighted mean of `INCWAGE` averaged over people of a specific age. The `na.rm=TRUE` argument in `weighted.mean` tells R to ignore all values of `NA` when calculating the weighted mean of `INCWAGE`. 
	
5. The last few lines of code are:

        ggplot(data=df_inc_by_age) + 
		  geom_line(aes(x=AGE, y=AVG_INCOME)) + 
          ggtitle("Average Income by Age, California 2019") +
          xlab("Age") + 
          ylab("Average Wage Income") + 
		  scale_y_continuous(labels=comma)
	
	This command makes the line plot and displays it to the "Plots" pane. Let's take a look at each element of this command:

    `ggplot(data=df_inc_by_age)`: In `ggplot2`, plots are started by calling `ggplot` with the dataframe containing the data to plot as the `data` argument. This initializes an empty chart. 
	
	To add elements to the chart, we use the `+` symbol. We can start a new line after the `+` symbol. R knows to look for the next element on the next line.
	
	The next element is the line plot itself: `geom_line(aes(x=AGE, y=AVG_INCOME))`. Calling `geom_line` initializes a line plot. `aes(x=AGE, y=AVG_INCOME)` is passed to `geom_line` as an argument, and it tells `geom_line` to use the values for `AGE` on the X axis and the values for `AVG_INCOME` on the Y axis. The dataframe you passed into `ggplot` must contain these variables for it to work. 
	
	The next elements are decorative elements. `ggtitle` lets us tell R what to use for the title of the plot. `xlab` tells R what to use for the X axis label and `ylab` tells R what to use for the Y axis label. `scale_y_continuous` controls the look and feel of the Y axis scale. In this case, we are telling it to format the numbers with a comma. You can play around with these commands to change the labels as you desire.
	
There's a lot more that you can control about the look and feel of the chart. However, the example above is enough for you to make basic line plots in R. 

### Multiple Color Coded Line Plots 

One of the powerful features of `ggplot2` is that it allows you to quickly and automatically create completed plots. In the example below, we create *two* line plots on the same axis. The first plot shows average income by age for males and the second shows it for females. We don't have to change much of the code to make this happen. Simply take the previous script and make the following changes:

- Add `df$SEX <- as.factor(df$SEX)` after `source("dataload.R")`. This tells R to treat `SEX` as a factor variable.

- Change `group_by(AGE)` to `group_by(SEX, AGE)` so that we are creating a dataframe that calculates average income by sex and age.

- Change `geom_line(aes(x=AGE, y=AVG_INCOME))` to `geom_line(aes(x=AGE, y=AVG_INCOME, color=SEX))`. When you specify a variable name for `color` in `aes`, R automatically knows to create separate color coded plots, one for each value of the variable you told it to color by.

Run your modified script from the top using `CTRL+SHIFT+ENTER`. You should see the following result:

![Screenshot of multiple color coded line pltos](screenshot2.png)

### Bar Charts

A bar chart shows the relationship between a numerical variable and a categorical variable. Example: Average income for each type of college degree. Average income is numeric but type of college degree is categorical.

The following script creates a bar chart showing the average income by field of college degree (`DEGFIELD`). To create a bar chart, we call `geom_col` from within a `ggplot` code block.

    rm(list=ls())    # Clear the workspace
	library(dplyr)   # Load libraries
	library(ggplot2) 
	library(scales)
	
	# Load the data
	source("dataload.R")  
	
	# Let R know about missing values for INCWAGE 
	df$INCWAGE[ df$INCWAGE>=999998] <- NA
	
	# Let R know about missing values for DEGFIELD 
	df$DEGFIELD[ df$DEGFIELD==0] <- NA
	
	# Keep only data from 2019 
	df <- filter(df, YEAR==2019)
	
	# Keep only working people with a valid college degree field 
	df <- filter(df, EMPSTAT==1 & !is.na(DEGFIELD))
	
	# Create a new dataframe that contains the average income for each DEGFIELD
	df_inc_by_degfield <- df %>% 
	  group_by(DEGFIELD) %>% 
	  summarize(
	    AVG_INCOME = weighted.mean(INCWAGE, PERWT, na.rm=TRUE)
	  )

    # Create the bar chart 
    ggplot(data=df_inc_by_degfield) + 
      geom_col(aes(x=DEGFIELD, y=AVG_INCOME)) + 
      ggtitle("Average Income by Degree Field, California 2019") +
      xlab("Degree Field") + 
      ylab("Average Wage Income") + 
	  scale_y_continuous(labels=comma)

Run the script from the top and you should see the following chart:

![Screenshot of bar chart](screenshot3.png)

### Improving the Bar Chart

Unfortunately, the chart is not very useful because the `DEGFIELD` values are still using their numerical codes! If we wanted to present this chart in an actual meeting, we would have to label the chart with `DEGFIELD`'s actual value labels as given in the [IPUMS codebook](https://usa.ipums.org/usa-action/variables/DEGFIELD#codes_section). 

How can we create a bar chart with the actual value labels? One idea is to create a new variable that contains the actual value labels and to use that in the bar chart instead of the numerical codes. But how can we create that new variable? One idea is to merge our current data to a dataset containing both the value code and the value label, using `DEGFIELD` as the merging key.

The file `DEGFIELD_CODES.csv` contains the necessary information. `DEGFIELD_CODES.csv` has two variables: `DEGFIELD`, which is the numerical code, and `DegreeField`, which is the human-readable label. The first few lines of `DEGFIELD_CODES.csv` are shown below:

| DEGFIELD | DegreeField                            |
| -------- | -------------------------------------- |
| 00       | NA                                     |
| 11       | Agriculture                            |
| 13       | Environmental and Natural Resources    |
| 14       | Architecture                           |
| 15       | Area, Ethnic, and Civilization Studies |
| ...      | ...                                    |

Let's now create a bar chart that uses `DegreeField` instead of `DEGFIELD`. To do so, modify the script from the previous section with the following changes:

- Place 
    
	    # Merge on the value labels for DEGFIELD
	    DEGFIELD_CODES <- read.csv("DEGFIELD_CODES.csv") 
	    df_inc_by_degfield <- inner_join(df_inc_by_degfield, DEGFIELD_CODES, by=c("DEGFIELD"))
	
    in between the code block that calculates the group-based averages and the code block that creates the bar chart. This merges on the `DegreeField` human-readable label for each value of `DEGFIELD`.
	
- Change `geom_col(aes(x=DEGFIELD, y=AVG_INCOME))` to `geom_col(aes(x=DegreeField, y=AVG_INCOME))`. This makes it so that our bar chart uses the human-readable variable `DegreeField` instead of the numerical codes `DEGFIELD`.

Now run the script from the top. Unfortunately, this still isn't useful because all the labels are smushed together! When you want to make a bar chart with a lot of categories, it's helpful to make a horizontal bar chart instead of a vertical bar chart. To do this, modify your code as follows:

- Add `+ coord_flip()` to the end of your bar chart code block. 

Run the script from the top. Your bar chart should now look like this:

![Screenshot of improved bar chart](screenshot5.png)

Success! This bar chart shows us the average wage income for employed people based on the degree they got in college.

### Scatter Plots

Scatter plots are used to visualize each observation in a dataset along two variables. Scatter plots are good for finding patterns in the data, but can get messy if there are too many points.

To create a scatter plot, call `geom_point` from within a `ggplot` code block. Run the following script to create a scatter plot that shows for each county in our data the share of the employed working-age population with college degrees and the average income of the employed working-age population:

    rm(list=ls())    # Clear the workspace
	library(dplyr)   # Load libraries
	library(ggplot2) 
	library(scales)
	
	# Load the data
	source("dataload.R")  
	
	# Let R know about missing values for INCWAGE 
	df$INCWAGE[ df$INCWAGE>=999998] <- NA
	
	# Keep only data from 2019 
	df <- filter(df, YEAR==2019)
	
	# Keep only employed working age adults
	df <- filter(df, EMPSTAT==1 & AGE>=25 & AGE<=65)
	
	# Create a variable indicating the person has a college education
	df$COLLEGE <- df$EDUCD>=101 & df$EDUCD<=116
	
	# Create a new dataframe that contains the average income and college share for each county
	df_counties <- df %>% 
	  group_by(COUNTYFIP) %>% 
	  summarize(
	    AVG_INCOME = weighted.mean(INCWAGE, PERWT, na.rm=TRUE), 
		COLLEGE_SHARE = weighted.mean(COLLEGE, PERWT, na.rm=TRUE)
	  )

    # Create the scatter plot
    ggplot(data=df_counties) + 
	  geom_point(aes(x=COLLEGE_SHARE, y=AVERAGE_INCOME)) + 
      ggtitle("Average Income vs. College Share, California Counties 2019") +
      xlab("College Share") + 
      ylab("Average Income") + 
	  scale_y_continuous(labels=comma)

You should see a result like this:

![Scatter plot](screenshot6.png)



	  
## Takeaways

- You can perform indexing operations in R. 
- You can create line plots, bar charts, and scatter plots in R. 
	
