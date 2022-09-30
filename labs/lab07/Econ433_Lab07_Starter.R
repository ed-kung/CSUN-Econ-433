rm(list=ls()) # clear the workspace

# Load required libraries
library(dplyr)
library(lfe)
library(stargazer)

# Load the data and merge
df1 <- read.csv("IPUMS_ACS2019_CA_1.csv")
df2 <- read.csv("IPUMS_ACS2019_CA_2.csv")
df <- inner_join(df1, df2, by=c("YEAR","SERIAL","PERNUM"))

# Deal with missing values in INCWAGE
df$INCWAGE <- ifelse(df$INCWAGE>=999998, NA, df$INCWAGE)

# Focus on employed individuals aged 25 to 65
# that make positive wage income
df <- filter(df, AGE>=25, AGE<=65, EMPSTAT==1, INCWAGE>0)

# Create female variable
df$FEMALE <- df$SEX==2

# Create log wage variable
df$LOGWAGE <- log(df$INCWAGE)

# Create log hours variable
df$LOGHRS <- log(df$UHRSWORK)

# Create college variable
df$COLLEGE <- df$EDUCD>=101 & df$EDUCD<=116

# Create marriage variable
df$MARRIED <- df$MARST>=1 & df$MARST<=2

r1 <- ##
r2 <- ##
r3 <- ##
r4 <- ##
r5 <- ##

stargazer(##
)


