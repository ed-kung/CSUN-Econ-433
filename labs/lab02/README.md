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

### Load the data into the work environment

6. In the console, type `df <- read.csv("IPUMS_ACS2019_CA_1.csv")` and hit enter. This loads the CSV file into a dataframe called `df`. You should see it appear in the "Environment" tab.

    ![Environment screenshot](screenshot2.png)

### Check the column names and data types

7. Click the blue arrow next to `df` on the "Environment" tab. This opens up a list of all the columns in the dataframe. It shows you the name of each column, the data type, and the first few rows of that column. (More on data types later).

    *Note: We sometimes also refer to columnns as variables.*

    ![Blue arrow screenshot](screenshot3.png)

### View the data

8. Click on the words `df` in the "Environment" tab. This opens up a table viewer. You can scroll around and look at the data like you would in Excel. You can exit the Viewer by clicking the little "x" on the Viewer tab.

    ![View screenshot](screenshot4.png)

### A brief discussion on data types

**Data type** is a very important concept in data science. Each column (or variable) has its own data type. The data type tells R what kind of data the variable is meant to represent.

Common data types include:

| Data Type                | Meaning                                                             | Examples                             |
| ------------------------ | ------------------------------------------------------------------- | ------------------------------------ |
| Integer                  | Positive or negative number, but no decimals                        | -5, 0, 4, 100                        |
| Numeric                  | Numbers that may include decimals                                   | 3.1415, 2.27, 65000, -130            |
| Boolean (aka Logical)    | `TRUE` or `FALSE` (`TRUE` can be represented by 1 and `FALSE` by 0) | `TRUE`, `FALSE`, 1, 0                |
| String                   | Text                                                                | "Edward", "Economics", "Los Angeles" |
| Date                     | A date or time                                                      | `1/1/2024`, `4/15/1984 13:45:00`     |
| Categorical (aka Factor) | A variable that can be one of a fixed number of possibilities       | `WHITE`, `BLACK`, `HISPANIC`, `ASIAN`, or `OTHER` |

   

    
    










