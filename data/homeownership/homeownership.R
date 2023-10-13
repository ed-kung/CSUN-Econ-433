rm(list=ls())
library(dplyr)
library(ggplot2)
library(lfe)
library(stargazer)

# Read in the data
df <- read.csv("usa_00020.csv")

# Keep only household head (since homeownership is measured at the level of the household)
df <- filter(df, PERNUM==1)

# Focus on household heads aged between 20 and 90
df <- filter(df, AGE>=20 & AGE<=90)

# Create a boolean variable for homeownership
df$OWN <- df$OWNERSHP==1

# Calculate homeownership rate by AGE, YEAR
df_own_by_age <- df %>%
  group_by(AGE, YEAR) %>%
  summarize(
    HOMEOWNERSHIP_RATE = weighted.mean(OWN, HHWT)
  )

# Plot Homeownership Rate by Age, Year
df_own_by_age$YEAR <- as.factor(df_own_by_age$YEAR)

ggplot(data=df_own_by_age) + 
  geom_line(aes(x=AGE, y=HOMEOWNERSHIP_RATE, color=YEAR)) +
  xlab("Age") + 
  ylab("Homeownership Rate") + 
  ggtitle("Homeownership Rate by Age, 1980 vs 2021")


# Create dummy variables for age bands
df$AGE_20_29 <- df$AGE>=20 & df$AGE<30
df$AGE_30_39 <- df$AGE>=30 & df$AGE<40
df$AGE_40_49 <- df$AGE>=40 & df$AGE<50
df$AGE_50_59 <- df$AGE>=50 & df$AGE<60
df$AGE_60_69 <- df$AGE>=60 & df$AGE<70
df$AGE_70_79 <- df$AGE>=70 & df$AGE<80
df$AGE_80_90 <- df$AGE>=80 & df$AGE<=90

# Clean up the income variable
df$HHINCOME <- ifelse(df$HHINCOME==9999999, NA, df$HHINCOME)
df$HHINCOME <- ifelse(df$HHINCOME<1, 1, df$HHINCOME)

# Create other useful variables
df$AGE_SQ <- df$AGE*df$AGE/100
df$MARRIED <- df$MARST==1
df$MALE <- df$SEX==1
df$COLLEGE <- df$EDUC>=10
df$WHITE <- df$RACE==1 

# Create some other demographic variables

r1980 <- felm(
  OWN ~ AGE + AGE_SQ + log(HHINCOME) + MARRIED + MALE + COLLEGE + WHITE,
  data=filter(df, YEAR==1980),
  weights=filter(df, YEAR==1980)$HHWT
)


r2021 <- felm(
  OWN ~ AGE + AGE_SQ + log(HHINCOME) + MARRIED + MALE + COLLEGE + WHITE,
  data=filter(df, YEAR==2021),
  weights=filter(df, YEAR==2021)$HHWT
)

stargazer(r1980, r2021, type="text")

