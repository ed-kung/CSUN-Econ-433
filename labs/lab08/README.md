# ECON 433 - Lab Session 8
## Regression Analysis II

In this lab you will conduct regression analysis on your own using a simulated dataset of student test scores.

### Setup
For this lab you will need the `dplyr`, `lfe`, and `stargazer` packages. Make sure these are installed and loaded using `install.packages` and `library`. You will also need the files `students.csv` and `classes.csv` which are on Canvas.

### Data Description

`students.csv` is a csv file where each row represents a student. Each student is assigned to a class and a school as indicated by `class_id` and `school_id`. The standardized test score of each student is recorded in the dataset, as is basic demographic information about their family income and their race.

`classes.csv` is a csv file where each row represents a classroom. The class size is recorded as well as an indicator for whether it is considered a small or a large classroom. Each classroom also has a single teacher. Whether or not the teacher has a master's degree is recorded.

`students.csv` can be merged to `classes.csv` using the columns `class_id` and `school_id`.

Students are in one of two cohorts: the regular cohort and the experimental cohort. In the regular cohort, assignment of students to classes is not random. That is, students in the regular cohort and their families have some influence over whether the student is assigned to a small or a large classroom. In the experimental cohort, assignment of students to classrooms is random. In the experimental cohort, students and their families have no control over whether the student is assigned to a small or large classroom.

### Objective

You will use this data to examine the factors which affect test score. You are particularly interested in the effect of small class size on test scores. You will conduct analysis using both the regular cohort and the experimental cohort and you will document the biases that exist when using non-experimental cohort.

### Instructions

Start a new script. You can use `lab08_starter.R` as a base for your script.

1. Start by loading `students.csv` and `classes.csv` and joining them together to create a student-level dataframe that contains classroom information as well.

2. Create two new dataframes, one for the regular cohort of students and one for the experimental cohort.

3. Show that in the non-experimental cohort, class size is related to demographics. You can do this by regressing class size on demographics (log family income and race) and showing that the estimated coefficients are large and statistically significant. Remember to include race as a factor variable in the regression.

4. Show that in the experimental cohort, class size is not related to demographics.

5. Using the non-experimental cohort, regress student test scores on small class size. What do you find?

6. Run three additional regressions using the non-experimental cohort. Each time you will be adding additional controls. First add log family income and race. Then add whether the teacher has a master's degree. Then add school level fixed effects. As a reminder, you can include fixed effects using the syntax `felm(Y ~ X | Z, data=df)` where Z is the variable you want to include fixed effects for.

7. Put the four regressions together using `stargazer`. What do you notice about the estimated coefficient on class size as more variables are included? 

8. Now repeat the four above regressions, but using the experimental cohort. Compare your results using the experimental cohort to your results using the non-experimental cohort. Which set of results is more reliable? What do you think the true effect of a small classroom is on test scores?

9. A skeptic critiques the validity of your results. He says that the results using the experimental cohort cannot be generalized, because people who sign up to be part of an experiment are different from the people who don't. While this is normally true, what can you do to convince the skeptic that this criticism does not apply to your results here?

10. There is a Canvas quiz with questions related to this assignment. Don't forget to do that before finishing this lab session.

### Takeaways

- You can conduct meaningful regression analysis on your own
- You can design supplementary exercises meant to demonstrate the validity of your regression analysis and address alternative explanations

 





