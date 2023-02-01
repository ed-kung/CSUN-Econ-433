# ECON 433 - Lab Session 3
## Basic Data Operations and Scripts

In this lab you will learn how to perform some basic data operations in R and how to work with scripts.

## Lab Work

### Setup

For today's lab, you will need the following files which can be downloaded from Canvas.

- `IPUMS_ACS2014_CA_1.csv`
- `IPUMS_ACS2014_CA_2.csv`
- `IPUMS_ACS2019_CA_1.csv`
- `IPUMS_ACS2019_CA_2.csv`

These files contain ACS data extracts downloaded from IPUMS for the state of California in 2014 and 2019. The files labeled `_1` and `_2` contain different information. In the lab, we will learn how to combine these separate files together into one dataframe.

For today's lab, you will also need to install a **package** in R called `dplyr`. To do so, type `install.packages("dplyr")` in your R console. (You might be asked to restart R, simply say no.) This step installs the package called `dplyr` to R, but you still have to load it into your current work environment. To do so, type `library(dplyr)` in the console.

**Packages** - A *package* in R is a collection of functions and tools that expands R's baseline functionality. Packages are written by authors and developers from all over the world and made available for free on [CRAN](https://cran.r-project.org/) (the Comprehensive R Archive Network). 

**dplyr** - `dplyr` is one of the most popular and important packages in R. It stands for "data pliers" and contains many tools to make data processing tasks easier. Many of the functions we use in this lab are from `dplyr`.

### Scripts

A **script** is simply a file that contains a set of instructions. When R "runs a script", it simply executes the instructions contained in the file one-by-one, starting at the top and moving line-by-line to the bottom. R scripts are designed with the file extension `.R`.

To start a new R script, click the button with the green plus on the top-left corner, as shown in the screenshot below. Then select "R Script" from the dropdown menu. A script editor window should appear. You will write your script in this window.

![Starting a new script](screenshot1.png)

To write your first script, enter the following into the script editor. Then save it by hitting `CTRL+S` or by using the icons or menus. You can name the script anything you like, but the filename should end in `.R`. Suggested filename: `my_script.R`. 

    rm(list=ls())  # Resets the workspace so you can start fresh
    library(dplyr) # Loads the dplyr library
    
    df <- read.csv("IPUMS_ACS2019_CA_1.csv")  # Load the data
    
    df$MARST <- as.factor(df$MARST) # Change MARST to a factor variable
    
    table(df$MARST) # Show a frequency table for the MARST variable

Once you've entered this script into the script editor and saved it, hit `CTRL+SHIFT+ENTER` to run the entire script. 









