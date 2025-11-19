rm(list=ls())

library(dplyr)

for (yr in c("2018", "2023")) {
  inputfile <- paste0("IPUMS_ACS", yr, "_CA_raw.csv")
  outputfile1 <- paste0("IPUMS_ACS", yr, "_CA_1.csv")
  outputfile2 <- paste0("IPUMS_ACS", yr, "_CA_2.csv")
  
  df <- read.csv(inputfile)

  df1 <- df %>% select(
    YEAR, SERIAL, PERNUM, PERWT, STATEFIP, COUNTYFIP, 
    AGE, SEX, MARST, RACAMIND, RACASIAN, RACBLK,
    RACPACIS, RACWHT, HISPAN, EMPSTAT, INCWAGE
  )
  
  df2 <- df %>% select(
    YEAR, SERIAL, PERNUM, EDUC, DEGFIELD,
    OCC, IND, UHRSWORK
  )

  write.csv(df1, outputfile1, row.names=FALSE)
  write.csv(df2, outputfile2, row.names=FALSE)
}
