# ECON 433 - Lab Session 7
## Linear Regressions II

In this lab you will conduct regression analysis on your own using a simulated dataset of student test scores. 

## Lab Work

### Setup

For this lab you will need the following files:

- `students.csv`
- `classes.csv`

You can download these files from Canvas.

You will also need the packages `dplyr`, `stargazer`, and `lfe`. These should already be installed from previous labs, but if they are not you can install them with `install.packages`.

### Data Description

`students.csv` is a csv file where each row represents a student. The file has the following columns:

- `student_id`: the unique id number of the student
- `class_id`: the id number of the classroom the student is in
- `school_id`: the id number of the school the student is in
- `test_score`: the student's standardized test score
- `family_income`: the student's annual family income
- `race`: the student's race; possible values are "BLACK", "WHITE", "HISPANIC", and "ASIAN".
- `cohort`: whether the student was assigned to the experimental or regular cohort (more information below.)

`classes.csv` is a csv file where each row represents a classroom. The file has the following columns:

- `class_id`: the unique id number of the classroom
- `school_id`: the unique id number of the school
- `n_students`: the number of students in the classroom
- `class_size`: an indicator for whether the class is considered small or large
- `teacher_has_ma`: an indicator for whether the classroom's teacher has a Master's degree.

`students.csv` and `classes.csv` can be merged using the columns `class_id` and `school_id`.

Students are in one of two cohorts: regular or experimental.

- In the regular cohort, the assignment of students to classrooms is not random. That is, families of students in the regular cohort have some influence over whether the student is assigned to a large or small classroom. 

- In the experimental cohort, students are randomly assigned to small or large classrooms. These students and their families have no control over whether the student gets assigned to a small or large classroom.

### Objective

You will use this data to examine the factors which affect test score. You are particularly interested in the effect of small class size on test scores. You will conduct the study using both the regular cohort and the experimental cohort. You will document the biases that exist when using the non-experimental cohort.

### Instructions

Use the following script to get started. Some of the boilerplate work is done for you, but you will have to do most of the programming on your own.

    rm(list=ls())   # Clear the workspace
	library(dplyr)  # Load required libraries
	library(stargazer)
	library(lfe)
	
	# Load the data files
	stu_df <- read.csv("students.csv")
	cls_df <- read.csv("classes.csv")
	
	# Merge the student data to the classroom data
	# YOUR CODE HERE
	
	# Recode race as a factor variable
	# YOUR CODE HERE
	
	# Create a boolean variable called SMALL that is True if 
	# class_size=="SMALL" and False otherwise
	# YOUR CODE HERE
	
	# Show that in the non-experimental cohort, class size is related to  
	# demographics. Do this by regressing SMALL on log(family_income) and race
	# and show that the coefficients statistically significant.
	
	# REGRESSION CODE HERE (Call the regression mod1)
	
	stargazer(mod1, type="text", keep.stat=c("n","rsq"))

Hints:

- The dataset is not a stratified sample so you do not have to use any weights when running the regressions.

- The formula for `mod1` should be `SMALL ~ log(family_income) + race`. And the output should be:

        ==============================================
                               Dependent variable:    
                           ---------------------------
                                      SMALL           
        ----------------------------------------------
        log(family_income)          0.085***          
                                     (0.014)          
                                                      
        raceBLACK                   0.179***          
                                     (0.022)          
                                                      
        raceHISPANIC                0.232***          
                                     (0.021)          
                                                      
        raceWHITE                     0.028           
                                     (0.018)          
                                                      
        Constant                    -0.662***         
                                     (0.159)          
                                                      
        ----------------------------------------------
        Observations                  6,000           
        R2                            0.042           
        ==============================================
        Note:              *p<0.1; **p<0.05; ***p<0.01
