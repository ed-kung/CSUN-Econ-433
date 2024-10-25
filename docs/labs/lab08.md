---
layout: default
title: 8. Linear Regressions III
parent: Labs
nav_order: 8
---

# Lab 8
{: .no_toc }

## Linear Regressions III
{: .no_toc }

In this lab, you will continue practicing your data skills. You will run some regressions to learn the relationship between class size and student test performance. You will also see the difference between observational data that suffers from endogneity and experimental data which does not.

---

## Background

Today, you will run some regressions to learn the relationship between class size and student test performance. You will also see the difference between observational data that suffers from endogeneity and experimental data which does not.

For this lab, you will need the following files:

- `students.csv`
- `classes.csv`

Download these filse from Canvas and upload them to your R Studio Cloud.

---

## Data Description

`students.csv` is a CSV file where each row represent a student. It contains the following variables:

- `student_id`: A unique id number for the student.
- `class_id`: A unique id number for the classroom that the student is in.
- `school_id`: A unique id number for the school that the student is in.
- `test_score`: A numeric variable indicating the student's test score on a standardized test.
- `family_income`: A numeric variable indicating the annual income of the student's family.
- `race`: A string variable indicating the student's race. The possible values are `"WHITE"`, `"BLACK"`, `"HISPANIC"`, and `"ASIAN"`.
- `cohort`: A string variable indicating for whether the student was part of an experimental cohort. (See below.) Possible values are `"REGULAR"` and `"EXPERIMENTAL"`.

`classes.csv` is a CSV file where each row represents a classroom. The file has the following columns:

- `class_id`: A unique id number for the classroom. This matches to `class_id` from `students.csv`.
- `school_id`: A unique id number for the school the classroom is in. This matches to `school_id` from `students.csv`.
- `class_size`: A string variable indicating whether the classroom is a large or small classroom. The possible values are `"LARGE"` and `"SMALL"`.
- `teacher_has_ma`: A boolean variable indicating whether the classroom's teacher has a masters degree.

`students.csv` and `classes.csv` can be merged using the variables `class_id` and `school_id`.

Each student can be in one of two cohorts: `"EXPERIMENTAL"` or `"REGUALR"`.

- In the experimental cohort, students were randomly assigned to their classrooms. These students and their families had no control over whether they got assigned to a large or small classroom. Their classroom assignment is entirely random.

- In the regular cohort, the assignment of students to classrooms was not random. This subset of the data is therefore observational and not experimental. The students and their families could have had some influence in whether they got assigned to a large or a small classroom.

---

## Preparation

Download the required data files and upload them to R Studio Cloud. Make sure `dplyr`, `lfe`, and `stargazer` are installed in your R Studio Cloud workspace.

---

## Assignment

Create a new script that accomplishes the following tasks:

1. Load the data from `students.csv` and `classes.csv`. Merge the two datasets together on `class_id` and `school_id`. Call the merged dataframe `df`.

2. Create a boolean variable called `small` which is `TRUE` if the student is assigned a small classroom.

3. Create a filtered dataset containing only the experimental cohort students. Call this dataframe `df_exp`.

4. Create a filtered dataset containing only the regular cohort students. Call this dataframe `df_reg`.

5. Use the experimental cohort to run a regression of `small` on `log(family_income)` and `as.factor(race)`. Call this regression `r0exp`. 

    - *Note*: Since the data do not come from a stratified survey, you do not need to use any weights in the regression.

6. Use the regular cohort to run a regression of `small` on `log(family_income)` and `as.factor(race)`. Call this regression `r0reg`. 

7. Combine the results of `r0exp` and `r0reg` using `stargazer`. Comment on the results. What is this table trying to show?

8. Use the experimental cohort to run the following regressions:

    - Regress `test_score` on `small`. Call this regression `r1exp`.
    - Regress `test_score` on `small` and `teacher_has_ma`. Call this regression `r2exp`.
    - Regress `test_score` on `small`, `teacher_has_ma`, `as.factor(race)`, and `log(family_income)`. Call this regression `r3exp`.
    - Regress `test_score` on `small`, `teacher_has_ma`, `as.factor(race)`, `log(family_income)`, with `school_id` as a set of dummies. Call this regression `r4exp`.

9. Combine the regressions `r1exp`-`r4exp` together into one table using `stargazer`. What do you learn about the effect of class size on student test scores?

10. Repeat steps 8 and 9 with the regular cohort, calling the regressions `r*reg`. Why are the estimated coefficients different in the regular cohort?

11. *Extra Credit.* A critic argues that the study has no external validity because families that signed up for the experimental cohort are different than families who did not sign up for the experimental cohort.  Run a regression to show that this critique is not well founded.

Upload the script to the Lab 08 Script assignment.

---

## Expected output

Table at step 7:

```
============================================================
                                    Dependent variable:     
                                ----------------------------
                                           small            
                                     (1)            (2)     
------------------------------------------------------------
log(family_income)                  0.030        0.237***   
                                   (0.025)        (0.023)   
                                                            
as.factor(race)BLACK                -0.008       -0.261***  
                                   (0.022)        (0.021)   
                                                            
as.factor(race)HISPANIC             0.012        -0.258***  
                                   (0.020)        (0.019)   
                                                            
as.factor(race)WHITE                -0.017        -0.004    
                                   (0.016)        (0.014)   
                                                            
Constant                            0.178        -2.082***  
                                   (0.281)        (0.262)   
                                                            
------------------------------------------------------------
Observations                        10,000        10,000    
R2                                  0.001          0.114    
Adjusted R2                         0.0002         0.113    
Residual Std. Error (df = 9995)     0.500          0.465    
============================================================
Note:                            *p<0.1; **p<0.05; ***p<0.01
```

Table at step 9:

```
===============================================================================================
                                                  Dependent variable:                          
                        -----------------------------------------------------------------------
                                                      test_score                               
                               (1)               (2)               (3)               (4)       
-----------------------------------------------------------------------------------------------
small                       9.145***          5.143***          5.147***          5.287***     
                             (0.197)           (0.217)           (0.215)           (0.205)     
                                                                                               
teacher_has_maTrue                            7.738***          7.681***          7.370***     
                                               (0.217)           (0.215)           (0.206)     
                                                                                               
as.factor(race)BLACK                                             -0.206            -0.500      
                                                                 (0.404)           (0.384)     
                                                                                               
as.factor(race)HISPANIC                                          -0.211            -0.439      
                                                                 (0.375)           (0.356)     
                                                                                               
as.factor(race)WHITE                                             -0.133            -0.257      
                                                                 (0.286)           (0.272)     
                                                                                               
log(family_income)                                              4.822***          4.559***     
                                                                 (0.460)           (0.437)     
                                                                                               
Constant                    59.711***         57.969***           5.397                        
                             (0.139)           (0.140)           (5.160)                       
                                                                                               
-----------------------------------------------------------------------------------------------
Observations                 10,000            10,000            10,000            10,000      
R2                            0.177             0.270             0.284             0.358      
Adjusted R2                   0.177             0.270             0.284             0.357      
Residual Std. Error     9.856 (df = 9998) 9.284 (df = 9997) 9.196 (df = 9993) 8.713 (df = 9974)
===============================================================================================
Note:                                                               *p<0.1; **p<0.05; ***p<0.01
```

Table at step 10:

```
===============================================================================================
                                                  Dependent variable:                          
                        -----------------------------------------------------------------------
                                                      test_score                               
                               (1)               (2)               (3)               (4)       
-----------------------------------------------------------------------------------------------
small                       14.903***         10.765***         10.652***         10.814***    
                             (0.191)           (0.208)           (0.218)           (0.205)     
                                                                                               
teacher_has_maTrue                            8.002***          7.994***          7.614***     
                                               (0.207)           (0.206)           (0.195)     
                                                                                               
as.factor(race)BLACK                                            1.317***          1.307***     
                                                                 (0.394)           (0.370)     
                                                                                               
as.factor(race)HISPANIC                                         1.455***          1.462***     
                                                                 (0.367)           (0.344)     
                                                                                               
as.factor(race)WHITE                                              0.187             0.214      
                                                                 (0.274)           (0.256)     
                                                                                               
log(family_income)                                              3.526***          3.444***     
                                                                 (0.445)           (0.417)     
                                                                                               
Constant                    57.451***         55.651***         16.560***                      
                             (0.125)           (0.125)           (4.978)                       
                                                                                               
-----------------------------------------------------------------------------------------------
Observations                 10,000            10,000            10,000            10,000      
R2                            0.377             0.458             0.462             0.529      
Adjusted R2                   0.377             0.458             0.462             0.528      
Residual Std. Error     9.458 (df = 9998) 8.823 (df = 9997) 8.795 (df = 9993) 8.232 (df = 9974)
===============================================================================================
Note:                                                               *p<0.1; **p<0.05; ***p<0.01
```

---

## Takeaways

- You can read and interpret regression results.
- You understand the difference between experimental and observational data.
- You can recognize endogeneity in regression models.






