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

### My First Script

To write your first script, enter the following into the script editor. Then save it by hitting `CTRL+S` or by using the icons or menus. You can name the script anything you like, but the filename should end in `.R`. Suggested filename: `my_script.R`. 

    rm(list=ls())  # Resets the workspace so you can start fresh
    library(dplyr) # Loads the dplyr library
    
    df <- read.csv("IPUMS_ACS2019_CA_1.csv")  # Load the data
    
    df$MARST <- as.factor(df$MARST) # Change MARST to a factor variable
    
    table(df$MARST) # Show a frequency table for the MARST variable

Once you've entered this script into the script editor and saved it, hit `CTRL+SHIFT+ENTER` to run the entire script. You should see the following output in your console window:

         1      2      3      4      5      6 
    148220   9460   5230  29945  17136 170100 

Instead of running the whole script at once, you can also execute lines of code one at a time. This is useful when developing a new script or when debugging. To execute a single line of code, click on that line of code in the editor window so that the cursor shows up on that line. Then hit `CTRL+ENTER`. R will run that single line of code. Try it by clicking on the `rm(list=ls())` line then hitting `CTRL+ENTER`. It should reset your workspace.

You can continue to hit `CTRL+ENTER` to continue excuting your code line-by-line. This is known as "stepping through" your code and it's very helpful for debugging.

### Anatomy of a Script

Let's take a look at a few important elements of the script.

The first line of the script is

    rm(list=ls())   # Resets the workspace so that you can start fresh
    
The command `rm(list=ls())` deletes everything in your current workspace. (It doesn't delete files, only objects which have been temporarily loaded into R's memory.) It's a good idea to start every script with `rm(list=ls())` so that you start with a fresh working environment. If you don't start fresh, then objects currently existing in R's temporary memory may affect the processing of your script, leading to unexpected behavior.

`rm(list=ls())` is followed by `# Resets the workspace so that you can start fresh`. This is known as a **comment**. Programmers put comments in their code to help explain what a particular piece of code does. To make a comment in R, put the comment at the end of a line of code and precede it with the hashtag symbol `#`.









