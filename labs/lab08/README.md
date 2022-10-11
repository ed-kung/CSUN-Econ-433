# ECON 433 - Lab Session 8
## Regression Analysis II

In this lab you will conduct regression analysis on your own using a simulated dataset of student test scores.

### Setup
For this lab you will need the `dplyr`, `lfe`, and `stargazer` packages. Make sure these are installed and loaded using `install.packages` and `library`. You will also need the files:

- `students.csv`
- `classes.csv`

These files are availalbe in this repository's [data directory](https://github.com/ed-kung/CSUN-Econ-433/tree/main/data).


### Data Description

`students.csv` is a csv file where each row represents a student. Each student is assigned to a class and a school as indicated by `class_id` and `school_id`. The standardized test score of each student is recorded in the dataset, as is basic demographic information about their family income and their race.

`classes.csv` is a csv file where each row represents a classroom. The class size is recorded as well as an indicator for whether it is considered a small or a large classroom. Each classroom also has a single teacher. Whether or not the teacher has a master's degree is recorded.

`students.csv` can be merged to `classes.csv` using the columns `class_id` and `school_id`.

Students are in one of two cohorts: the regular cohort and the experimental cohort. In the regular cohort, assignment of students to classes is not random. That is, students in the regular cohort and their families have some influence over whether the student is assigned to a small or a large classroom. In the experimental cohort, assignment of students to classrooms is random. In the experimental cohort, students and their families have no control over whether the student is assigned to a small or large classroom.

### Objective

You will this data to examine the factors which affect test score. You are particularly interested in the effect of small class size on test scores. You will conduct analysis using both the regular cohort and the experimental cohort and you will document the biases that exist when using non-experimental cohort.

### Instructions


