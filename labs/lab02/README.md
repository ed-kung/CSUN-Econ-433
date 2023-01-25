# ECON 433 - Lab Session 2
## Introduction to R

In this lab you will be introduced to R, a programming language designed specifically for statistical analysis. 

**Why R?**

- Working with data can involve a complex series of steps. Writing a set of instructions as code makes the process more reproducible and easier to share with others. 

- R is open source software, meaning it is free for anyone to use. It also has a large and active community of developers.

- Data science is an in-demand skill. R is one of the most commonly used tools among data scientists (along with Python). A tech company manager once told me that they're only looking for interns who can work in R or Python. Excel was not sufficient. 

**Data science? I thought this was an economics class.**

Yes, it is an economics class. But the study of economics (including public economics) is becoming more and more data driven. Economists, if they are equipped with the right empirical skill set, are well positioned to make impactful contributions to organizations by combining theory and evidence.

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

    This loads the CSV file into your session's work environment as a **data frame**. A data frame is a type of object in R that can be referenced by name and manipulated. A data frame is essentially a table with rows and columns containing data. Think of a data frame like an Excel worksheet. By typing `df <- read.csv("IPUMS_ACS2019_CA_1.csv")`, you are telling R to read the file `IPUMS_ACS2019_CA_1.csv` and store the data in a data frame that you've decided to name `df`. 
    
    The choice of the name `df` is arbitrary. If you had typed `my_data <- read.csv("IPUMS_ACS2019_CA_1.csv")` instead, you would have loaded the data into a data frame named `my_data`. Think of the name of the data frame like the name of an Excel worksheet. It doesn't really matter what you call it, but you can use the name to reference data from it.
    
7. You should now see your data frame called `df` listed in the "Environment" tab, as shown in the screenshot below.

    ![Environment screenshot](screenshot2.png)
    
    Click on the little blue arrow next to `df` and it should expand to show you the list of columns in `df`. These columns are sometimes called **variables**. You can go to the IPUMS website to look up the definitions for each of these variables.
    
    You can click the little blue arrow a second time to collapse this view.
    
8. To browse the data in table form, you can type `View(df)` in the console. A viewing window showing the tabular data in `df` should pop up. You can use the arrow keys and scroll bar to navigate and look at the data.

9. Another useful command is to ask R to show you the number of rows and number of columns of the data. Type `nrow(df)` to get the number of rows in `df`. Type `ncol(df)` to get the number of columns in `df`.

10. To ask R to list all the columns (a.k.a. variables) by name, type `names(df)`. This is useful if you forgot the column names and need a reminder.

### Getting help

11. You may have noticed that operations on `df` take the form `f(df)`, where `f` is the name of the operation. Operations that take one or more inputs and return one or more outputs are called **functions**. For example, the `read.csv()` function takes as input a file name and outputs a dataframe read from that file. The `nrow()` function takes as input a dataframe and outputs the number of rows. The `names()` function takes as input a dataframe and outputs the names of the columns.

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
    - The value of the first rows in that column
    For example, `str(df)` shows us that the variable `INCWAGE` has a numeric datatype (`num`), and its first few values are `23100`, `0`, and `6000`.
    
### Data Types

Now I will take a brief moment to explain **data types**. **Data type** is an extremely important concept in data science. Each column (or variable) has its own data type. The data type tells you what kind of the data the variable is meant to represent. Column data types include:

- Numeric

- Dates

- Strings

- Categorical (or factors)



### Summarizing variables

11. In R, you can reference a specific column in a specific data frame using `$`. For example, to reference the column `INCWAGE` in dataframe `df`, 



    

