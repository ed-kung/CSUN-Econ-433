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

r1 <- felm(LOGWAGE ~ FEMALE, data=df, weights=df$PERWT)
r2 <- # YOUR INPUT HERE
r3 <- # YOUR INPUT HERE
r4 <- # YOUR INPUT HERE
r5 <- # YOUR INPUT HERE

stargazer(
    # YOUR INPUT HERE,
    type="text", 
    keep = # YOUR INPUT HERE,
    add.lines=list(
        c("Industry FE", "N", "N", "Y", "Y", "Y"), 
        c("Occupation FE", "N", "N", "N", "N", "Y"), 
        c("College Major FE", "N", "N", "N", "N", "Y"), 
        c("Race FE", "N", "N", "N", "N", "Y"), 
        c("County FE", "N", "N", "N", "N", "Y") 
    )
)



