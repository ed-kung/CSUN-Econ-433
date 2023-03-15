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
- `class_size`: an indicator for whether the class is small or large
- `teacher_has_ma`: an indicator for whether the classroom's teacher has a Master's degree.

`students.csv` and `classes.csv` can be merged using the columns `class_id` and `school_id`.

Students are in one of two cohorts: regular or experimental.

- In the regular cohort, the assignment of students to classrooms is not random. That is, families of students in the regular cohort have some influence over whether the student is assigned to a large or small classroom. 

- In the experimental cohort, students are randomly assigned to small or large classrooms. These students and their families have no control over whether the student gets assigned to a small or large classroom.

### Objective

You will use this data to examine the factors which affect test score. You are particularly interested in the effect of small class size on test scores. You will conduct the study using both the regular cohort and the experimental cohort. You will document the biases that exist when using the non-experimental cohort.

### Instructions

Write a script that accomplishes the following tasks:

1. Show that family income and race predict class size in the regular cohort but not in the experimental cohort. Show that `teacher_has_ma` is related to `small` in both cohorts.

2. Show how test score depends on different covariates using data from the regular cohort. You should run the following five regressions and show their output in one table:
     - Regress `test_score` on `small`
	 - Regress `test_score` on `small` and `teacher_has_ma`
	 - Regress `test_score` on `small`, `teacher_has_ma`, and `race`
	 - Regress `test_score` on `small`, `teacher_has_ma`, `race`, and `log(family_income)`
	 - Regress `test_score` on `small`, `teacher_has_ma`, `race`, `log(family_income)`, and `school_id` as a large factor variable
	 
3. Show how test score depends on different covariates using data from the experimental cohort. You should run the same regressions as above, but using data from the experimental instead of regular cohort.

4. Bonus: A critic argues that the study has no external validity because families that signed up for the experimental cohort are different than the families that did not sign up. Run a regression to show that this critique is not well founded.

Hints:

- You will need to merge `students.csv` with `classes.csv` on the primary keys `class_id, school_id`
- You should create a boolean variable named `small` that is true when `class_size=="SMALL"`
- You should recode `race` as a factor variable
- You should create two new dataframes using `filter`, one which contains the regular cohort students and one which contains the experimental cohort students
- When running regressions, you do not need to use any weights because the dataset is not a stratified sample
- When running regressions separately for the regular and experimental cohorts, pay attention to the `data` argument in `felm` and make sure you are using the correct dataframe
- When you run regressions with `race`, keep `race` on the left side of `|` in the regression formula, so that the dummy variables are included in the Stargazer output
- When you run regressions with `school_id`, keep `school_id` on the right side of `|` in the regression formula, because `school_id` is a large factor variable
- To show that family income and race predict class size in the regular cohort, you can regress `small` on `teacher_has_ma`, `log(family_income)` and `race` and show that the coefficients on `log(family_income)` and `race` are statistically significant.
- To show that family income and race do not predict class size in the experimental cohort, you can regress `small` on `teacher_has_ma`, `log(family_income)`, and `race` and show that the coefficients on `log(family_income)` and `race` are not statistically significant (i.e. statistically indistinguishable from zero).
- Not including the bonus, you should be running a total of 12 regressions and producing 3 tables.
- The bonus can be accomplished with 1 regression.

Here is the skeleton of a script to get you started:

    rm(list=ls())     # Clear the workspace
	library(dplyr)    # Load required libraries
	library(stargazer)
	library(lfe)
	
	# Load the data files
	stu_df <- read.csv("students.csv")
	cls_df <- read.csv("classes.csv")
	
	# Merge stu_df to cls_df
	# YOUR CODE HERE
	
	# Recode race as a factor variable
	# YOUR CODE HERE
	
	# Create a boolean variable called small that is true if
	# class_size=="SMALL" and false otherwise
	# YOUR CODE HERE
	
	# Create a dataframe with only the regular cohort
	# YOUR CODE HERE
	
	# Create a dataframe with only the experimental cohort
	# YOUR CODE HERE
	
	#---------------------------------------------------------------------
	# Show that family income and race predict class size in the regular
	# cohort but not in the experimental cohort
	
	# regress small on teacher_has_ma, log(family_income), race using data
	# from the regular cohort
	# YOUR CODE HERE (call the regression reg_m0)
	
	# regress small on teacher_has_ma, log(family_income), race using data
	# from the experimental cohort
	# YOUR CODE HERE (call the regression exp_m0)
	
	# Show the results
	stargazer(reg_m0, exp_m0, type="text", keep.stat=c("n","rsq"),
	          title="Predictors of Class Size by Cohort")
	#---------------------------------------------------------------------
	
	
	#---------------------------------------------------------------------
	# Run test score regressions for the regular cohort
	
	# YOUR CODE HERE (call the regressions reg_m1, reg_m2, reg_m3, reg_m4,
	# and reg_m5)
	
	# Show the results
	stargazer(reg_m1, reg_m2, reg_m3, reg_m4, reg_m5, type="text",
	          keep.stat=c("n", "rsq"), 
			  title="Predictors of Test Score (Regular Cohort)")
	#---------------------------------------------------------------------		  

	
	#---------------------------------------------------------------------
	# Run test score regressions for the experimental cohort
	
	# YOUR CODE HERE (call the regressions exp_m1, exp_m2, exp_m3, exp_m4,
	# and exp_m5)
	
	# Show the results
	stargazer(exp_m1, exp_m2, exp_m3, exp_m4, exp_m5, type="text",
	          keep.stat=c("n", "rsq"), 
			  title="Predictors of Test Score (Experimental Cohort)")
	#---------------------------------------------------------------------		  
	
	
	#---------------------------------------------------------------------
	# Bonus: Show that demographics do not predict whether or not the 
	# student is in the experimental cohort
	
	# YOUR CODE HERE
	
	# Show the results
	
	#----------------------------------------------------------------------

Show me your code and output and take the lab quiz to be dismissed.

## Takeaways

- You can use regression analysis to validate the assumptions of an experimental study
- You can interpret regression results in experimental studies
- You can explain endogeneity and sources of bias in non-experimental studies
- You can conduct regression analysis for linear models independently	




