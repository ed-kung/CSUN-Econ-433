# ECON 433 - Lab Session 2
## Introduction to R

In this lab you will be introduced to R, a programming language designed specifically for statistical analysis. 

**Why R?**

- Working with data can involve a complex series of steps. Writing a set of instructions as code makes the process more reproducible and easier to share with others. 

- R is open source software, meaning it is free for anyone to use. It also has a large and active community of developers.

- Data science is an in-demand skill. R is one of the most commonly used tools among data scientists (along with Python). A tech company manager once told me that they're only looking for interns who can work in R or Python. Excel was not sufficient. 

**Data science? I thought this was an economics class.**

Yes, it is an economics class. But the study of economics (including public economics) is becoming more and more data driven. Economists, if they are equipped with the right empirical skill set, are well positioned to make impactful contributions to their organizations by combining solid economic theory with compelling statistical evidence.

## Lab Work 

In this lab, you will download a data file that I have downloaded in advance from IPUMS. You will load the data file into R and conduct some basic data exploration tasks. 

### R Studio Cloud

1. First, you will need to create a R Studio Cloud account. Go to https://posit.co/products/cloud/cloud and sign up for a "Cloud Free" account.

2. Log in and click on "Your Workspace" on the left. Click on "New Project" -> "New RStudio Project".  

3. Name the project whatever you want. Suggestion: "Econ 433".

### Upload the data

4. Download `IPUMS_ACS2019_CA_1.csv` from Canvas. This is an IPUMS data extract containing data from the 2019 ACS for the state of California, similar to what you extracted in Lab 01.

5. In R Studio, click the "Upload" button under the "Files" tab, as shown in the screenshot, and upload `IPUMS_ACS2019_CA_1.csv`. You should now see it in your files list.

    ![Upload screenshot](screenshot1.png)

### Playing around with R

Now you have the data inside your R Studio Cloud account and you can begin exploring!

6. First, we have to load the data into the current session's work environment. Do so by typing `df <- read.csv("IPUMS_ACS2019_CA_1.csv")` into the console and hitting enter. 

    This loads the CSV file into your session's work environment as a **data frame**. A data frame is a type of object in R that can be referenced by name and manipulated. A data frame is essentially a table with rows and columns. A data frame is like an Excel worksheet. By typing `df <- read.csv("IPUMS_ACS2019_CA_1.csv")`, you are telling R to read the file `IPUMS_ACS2019_CA_1.csv` and store in a data frame called `df`. 
    
    The choice of the name `df` is arbitrary. If you had typed `my_data <- read.csv("IPUMS_ACS2019_CA_1.csv")` instead, you would have loaded the data into a data frame named `my_data`. A data frame's name is like the name of an Excel worksheet. It doesn't really matter what you call it, but you can use the name to refer to it in later commands.
    
7. You should now see your data frame called `df` listed in the "Environment" tab, as shown in the screenshot below.

    ![Environment screenshot](screenshot2.png)
    
    Click on the little blue arrow next to `df` and it should expand to show you the list of columns in `df`. Columns are also called **variables**, **fields**, or **features**. You can go to the IPUMS website to look up the definitions for each of these variables.
    
    You can click the little blue arrow a second time to collapse this view.
    
8. To browse the data in table form, you can type `View(df)` in the console. A viewing window will appear showing the contents of `df`. You can use the arrow keys and scroll bar to navigate and look at the data.

9. Another useful command is to ask R to show you the number of rows and number of columns of the data. Type `nrow(df)` to get the number of rows in `df`. Type `ncol(df)` to get the number of columns in `df`.

10. To ask R to list all the columns (a.k.a. variables) by name, type `names(df)`. This is useful if you forgot the column names and need a reminder.

### Getting help

11. You may have noticed that operations on `df` take the form `f(df)`, where `f` is the name of the operation. Operations that take one or more inputs and return one or more outputs are called **functions**. `read.csv()` is a function takes as input a file name and outputs a data frame. `nrow()` is a function takes as input a dataframe and outputs the number of rows. `names()` is a function takes as input a dataframe and outputs the names of the columns.

    Sometimes, you may forget what a function does or forget what inputs it requires. To get help about a specific function in R, you can type `?function`. This will open up a help page for that function. Try it now by typing `?read.csv`. The help page will show you the usage syntax of the `read.csv()` function.

### Understanding your data further

12. A very useful command in R is the function `str()`. Type `str(df)` to show important information about the structure of the dataframe `df`. You should get output that looks like this:

        'data.frame':	380091 obs. of  14 variables:
         $ YEAR     : int  2019 2019 2019 2019 2019 2019 2019 2019 2019 2019 ...
         $ SERIAL   : num  70293 70294 70295 70296 70297 ...
         $ PERNUM   : int  1 1 1 1 1 1 1 1 1 1 ...
         $ HHWT     : int  21 34 28 127 103 6 4 81 16 58 ...
         $ PERWT    : int  21 34 28 127 103 6 4 81 16 58 ...
         $ STATEFIP : int  6 6 6 6 6 6 6 6 6 6 ...
         $ COUNTYFIP: int  37 73 59 71 89 37 111 37 111 29 ...
         $ AGE      : int  58 66 18 58 18 65 21 54 82 38 ...
         $ SEX      : int  2 1 2 1 2 1 1 2 2 1 ...
         $ MARST    : int  6 4 6 6 6 6 6 6 2 6 ...
         $ RACE     : int  2 1 1 1 1 2 7 1 1 1 ...
         $ HISPAN   : int  0 0 0 0 0 0 1 0 1 4 ...
         $ EMPSTAT  : int  2 3 3 3 3 3 1 3 3 3 ...
         $ INCWAGE  : num  23100 0 6000 0 2000 0 9800 0 0 0 ...
         
    The output shows a wealth of important information. First, it shows that `df` is a `data.frame` object. Second, it shows the number of rows (a.k.a. observations) and the number of columns (a.k.a. variables). Third, it lists important information for each of the variables in the data. For each variable it shows the:
    - Name
    - Data Type
    - The first few rows of the column
    
    For example, `str(df)` shows us that the variable `INCWAGE` has a numeric datatype (`num`), and its first few values are `23100`, `0`, and `6000`.
    
### Data Types

Now I will take a brief moment to explain **data types**. **Data type** is an extremely important concept in data science. Each column (or variable) has its own data type. The data type tells you what kind of the data the variable is meant to represent. Common data types include:

- Integer
- Numeric
- Dates
- Strings (i.e. text)
- Categorical (a.k.a. factors)

Data types are important because it tells you how the data should be interpreted. It also tells you what you can and can't do with the data. For example, numbers (integers and numeric) can be added, subtracted, multiplied, and divided. Dates can only be subtracted to get the number of days between two dates, but they cannot be added, multiplied, or divided. Strings (meaning text data) cannot be added, subtracted, multiplied, or divided at all. 

Categorical data (or factor data) are data in which the values can be one of a set of categories. Marital status is a good example of categorical data. People can be married, separated, divorced, widowed, or never married. State of residence is another example of categorical data. People can be located in one of 50 states. Categorical data shouldn't be added, subtracted, multiplied, or divided.

### Changing Data Types

Notice that in `df`, the data type for both `STATEFIP` and `MARST` is integer when really they should be categorical. In fact, `SERIAL`, `PERNUM`, `STATEFIP`, `COUNTYFIP`, `SEX`, `MARST`, `RACE`, `HISPAN`, and `EMPSTAT` are all integers when they should be categorical. 

When using `read.csv`, R loaded these variables as integers because R can't tell by looking at the CSV file that these variables are meant to be categorical. When R read from `IPUMS_ACS2019_CA_1.csv`, all it could see is that there were integers in the column for `MARST` (since IPUMS codes all its categorical variables in integers). Since R saw that there were integers in the `MARST` column, it loaded `MARST` with the integer data type.
    
13. Fortunately, it is easy for us to change the data type of a variable. To change the data type of `MARST` from integer to categorical, type `df$MARST <- as.factor(df$MARST)`. 

14. Now type `str(df)` again. `MARST` now has the data type of `factor`, which is what we want.

15. Type `summary(df$MARST)` to show a summary of the variable `MARST`. You will see that 148,220 rows have a value of 1, 9,460 rows have a value of 2, and so on. You can check the [IPUMS website](https://usa.ipums.org/usa-action/variables/MARST#codes_section) for the definitions of these numerical codes.

16. Type `summary(df$INCWAGE)` to show a summary of the variable `INCWAGE`. `INCWAGE` is a numeric variable, so `summary()` gives a different kind of output. When summarizing a categorical variable, `summary()` shows a frequency table. When summarizing a numeric variable, `summary()` shows the minimum, 25th percentile, median, mean, 75th percentile, and maximum.

    Note that in this data, the 25th percentile of `INCWAGE` (i.e. salary and wage income) is zero. This is because the dataset contains both working adults and non-working adults and children. So it is not surprising that over 25 percent of the data has zero wage and salary income.

### Referencing variables 

To change the data type of `MARST` from integer to categorical, we used the code `df$MARST <- as.factor(df$MARST)`. Let's dissect this code.

First, let's discuss the use of `df$MARST`. The `$` symbol is used to reference a variable in a dataframe . Usage: `<Name of dataframe>$<Name of variable>`. For example, `df$MARST` referes to the variable `MARST` inside the dataframe `df`. To reference a variable called `HEIGHT` in a dataframe called `my_data`, we would use `my_data$HEIGHT`.

Second, let's discuss the use of `<-`. The `<-` symbol is used to assign the object on the right hand side of `<-` to the object on the left hand side of `<-`. If the object on the left hand side already exists, it is replaced.

So now let's look back at `df$MARST <- as.factor(df$MARST)`. This line of code assigns `as.factor(df$MARST)` to `df$MARST`. Since `df$MARST` already exists (as an integer column), it is replaced by `as.factor(df$MARST)` (a categorical column). Any future references to `df$MARST` will return the categorical column.

17. Let's put what we learned into practice. Type `df$INC_DIV_AGE <- df$INCWAGE / df$AGE`. This line of code creates a new variable called `INC_DIV_AGE` which is equal to `INCWAGE` divided by `AGE`. Type `summary(df$INC_DIV_AGE)` to show some summary statistics about this new variable.

**Row-by-row operations**: By default, operations on columns occur row-by-row. So `df$INCWAGE / df$AGE` goes row-by-row, taking the value of `INCWAGE` in each row and dividing by the value of `AGE` in that row.

### Logical operators

In analytics, we frequently have to work with logical operator. A **logical expression** is a statement that can be either `TRUE` or `FALSE`, and a **logical operator** is something that combines one or more logical expressions into a new `TRUE` or `FALSE` expression.

Examples:

- `AGE>=25` is a logical expression that is `TRUE` if `AGE` is greater than or equal to 25, and `FALSE` otherwise.  
- `AGE<=65` is a logical expression that is `TRUE` if `AGE` is less than or equal to 65, and `FALSE` otherwise.
- `(AGE>=25) & (AGE<=65)` is a logical expression that is `TRUE` if both `AGE>=25` and `AGE<=65` are true. `&` is the "and" logical operator.

The logical operators you should know are:

- `>` and `>=`: greater than / greater than or equal to
- `<` and `<=`: less than / less than or equal to
- `==`: exactly equal to
- `&`: and
- `|`: or

18. Let's create a variable called `WORKING_ADULT` that is `TRUE` if the person is employed and is over the age of 25. Type `df$WORKING_ADULT <- (df$EMPSTAT==1) & (df$AGE>=25)` to create this variable. Then type `summary(df$WORKING_ADULT)` to take a look at a summary of this new variable.

## Assignment

To be dismissed and earn your grade for this lab, do the following.

1. Change the following variables in `df` from integers to categorical: `SERIAL`, `PERNUM`, `STATEFIP`, `COUNTYFIP`, `SEX`, `MARST`, `RACE`, `HISPAN`, `EMPSTAT`.

2. Create a new variable in `df` called `INC_TIMES_AGE` which is equal to `INCWAGE` multiplied by `AGE`.

3. Create a new variable in `df` called `UNEMPLOYED_ADULT` which is `TRUE` if the person is 25 or older and is unemployed (but in the labor force), and `FALSE` otherwise.

4. Show me a summary of your data with `str(df)` and `summary(df)`.

5. Take the lab quiz.


## Takeaways

- You can use R Studio Cloud.
- You can do basic tasks in R, including:
    - Load data from files
    - View data
    - Summarize data
    - Change data types
    - Reference  variables with `$`
    - Create new variables with `<-`
	- Use logical operators to make `TRUE`/`FALSE` variables
- You understand the concept of data types.
- You can use R's help system.




    

