rm(list=ls())
library(dplyr)
library(lubridate)

df <- read.csv("lab6_assignment_data_raw.csv")

df1 <- df %>% filter(RELATE==1) %>%
  select(
    YEAR,
    SERIAL,
    HHWT,
    STATEFIP,
    COUNTYFIP,
    OWNERSHP, 
    HHINCOME,
    SEX, 
    AGE, 
    MARST, 
    RACHSING,
    EDUC, 
    EMPSTAT,
    OCC,
    IND
  )
  
write.csv(df1, "lab6_assignment_data.csv", row.names=FALSE)

