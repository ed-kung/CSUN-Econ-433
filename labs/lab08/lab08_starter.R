rm(list=ls())

library(dplyr)
library(lfe)
library(stargazer)

# Read in the two datasets, students.csv and classes.csv
stu_df <- 'YOUR INPUT'
cls_df <- 'YOUR INPUT'

# Join the two datasets on class_id, school_id
df <- 'YOUR INPUT'

# Create a small class size variable that is true if class_size is SMALL
df$small_class <- df$class_size=='SMALL'

# Get the regular cohort students
dfreg <- filter('YOUR INPUT')

# Get the experimental cohort students
dfexp <- filter('YOUR INPUT')


#---- Show that in the non-experimental cohort, class size is related to demographics
r0reg <- felm(small_class ~ log(family_income) + as.factor(race), data=dfreg)
stargazer(r0reg, type="text")


#---- Show that in the experimental cohort, class size is not related to demographics
r0exp <- felm('YOUR INPUT')
stargazer(r0exp, type="text")


#---- Regressions on the non-experimental cohort

# Regress test score on small class 
r1 <- felm(test_score ~ small_class, data=dfreg)

# Add race and log family income to the regression (use race as a factor variable)
r2 <- felm('YOUR INPUT')

# Add teacher_has_ma to the regression
r3 <- felm('YOUR INPUT')

# Add school fixed effects
r4 <- felm('YOUR INPUT')

# Report the regression results 
stargazer(r1, r2, r3, r4, type="text", title="Table 1: Non-Experimental Cohort", 
          add.lines=list(c("School Fixed Effects", "N", "N", "N", "Y")))



#---- Regressions on the experimental cohort

# Regress test score on small class 
r5 <- felm('YOUR INPUT')

# Add race and log family income to the regression (use race as a factor variable)
r6 <- felm('YOUR INPUT')

# Add teacher_has_ma to the regression
r7 <- felm('YOUR INPUT')

# Add school fixed effects
r8 <- felm('YOUR INPUT')

# Report the regression results 
stargazer(r5, r6, r7, r8, type="text", title="Table 2: Experimental Cohort", 
          add.lines=list(c("School Fixed Effects", "N", "N", "N", "Y")))



#---- Show that being in the experimental cohort is unrelated to demographics
'YOUR INPUT'





