rm(list=ls())

# We only need one function (wtd.var) from Hmisc
# If we load the whole thing, we'll have conflicts with dplyr
library(Hmisc, include.only="wtd.var")  

# Load the rest of the libraries
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
  ggtitle("Figure 1: Homeownership Rate by Age, 1980 vs 2021") + 
  theme_bw()

# Clean up the income variable
df$HHINCOME <- ifelse(df$HHINCOME==9999999, NA, df$HHINCOME)
df$HHINCOME <- ifelse(df$HHINCOME<1, 1, df$HHINCOME)


# Create other regression variables
df$AGE_SQ <- df$AGE*df$AGE/100
df$MARRIED <- df$MARST==1
df$MALE <- df$SEX==1
df$COLLEGE <- df$EDUC>=10
df$WHITE <- df$RACE==1 

# Create a summary table
# Note: This is not an efficient way to do it, but I want to use a 
# method that the students would already have had exposure to

# SUMMARIZE OWN
df %>% group_by(YEAR) %>% summarize(
  MEAN = weighted.mean(OWN, HHWT)
)

# SUMMARIZE AGE
df %>% group_by(YEAR) %>% summarize(
  MIN = min(AGE),
  MAX = max(AGE),
  MEAN = weighted.mean(AGE, HHWT),
  STD = sqrt(wtd.var(AGE,HHWT))
)

# SUMMARIZE HHINCOME
df %>% group_by(YEAR) %>% summarize(
  MIN = min(HHINCOME,na.rm=T),
  MAX = max(HHINCOME,na.rm=T),
  MEAN = weighted.mean(HHINCOME,HHWT,na.rm=T),
  STD = sqrt(wtd.var(HHINCOME,HHWT,na.rm=T))
)

# SUMMARIZE MARRIED
df %>% group_by(YEAR) %>% summarize(
  MEAN = weighted.mean(MARRIED, HHWT)
)

# SUMMARIZE MALE
df %>% group_by(YEAR) %>% summarize(
  MEAN = weighted.mean(MALE, HHWT)
)

# SUMMARIZE COLLEGE
df %>% group_by(YEAR) %>% summarize(
  MEAN = weighted.mean(COLLEGE, HHWT)
)

# SUMMARIZE WHITE
df %>% group_by(YEAR) %>% summarize(
  MEAN = weighted.mean(WHITE, HHWT)
)

# Run the regressions
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

stargazer(r1980, r2021, type="text",
          column.labels=c("1980", "2021"))

