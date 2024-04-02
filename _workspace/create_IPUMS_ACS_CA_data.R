rm(list=ls())

library(dplyr)

df <- read.csv("IPUMS_ACS2019_CA_raw.csv")

df1 <- df %>% select(
  YEAR,
  SERIAL,
  PERNUM,
  PERWT,
  STATEFIP,
  COUNTYFIP,
  AGE,
  SEX,
  MARST,
  RACHSING,
  EMPSTAT,
  INCWAGE
)

df2 <- df %>% select(
  YEAR,
  SERIAL,
  PERNUM,
  EDUC,
  DEGFIELD,
  OCC, 
  IND,
  UHRSWORK
)

write.csv(df1, "IPUMS_ACS2019_CA_1.csv", row.names=FALSE)
write.csv(df2, "IPUMS_ACS2019_CA_2.csv", row.names=FALSE)




df <- read.csv("IPUMS_ACS2014_CA_raw.csv")

df1 <- df %>% select(
  YEAR,
  SERIAL,
  PERNUM,
  PERWT,
  STATEFIP,
  COUNTYFIP,
  AGE,
  SEX,
  MARST,
  RACHSING,
  EMPSTAT,
  INCWAGE
)

df2 <- df %>% select(
  YEAR,
  SERIAL,
  PERNUM,
  EDUC,
  DEGFIELD,
  OCC, 
  IND,
  UHRSWORK
)

write.csv(df1, "IPUMS_ACS2014_CA_1.csv", row.names=FALSE)
write.csv(df2, "IPUMS_ACS2014_CA_2.csv", row.names=FALSE)





