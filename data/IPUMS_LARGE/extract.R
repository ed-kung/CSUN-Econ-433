# Extract state-by-year data for simulating student datasets

if (!require("ipumsr")) stop("Reading IPUMS data into R requires the ipumsr package. It can be installed using the following command: install.packages('ipumsr')")

library(spatstat)
library(dplyr)

ddi <- read_ipums_ddi("usa_00015.xml")
data <- read_ipums_micro(ddi)

# Total population
df0 <- data %>%
  group_by(STATEFIP, YEAR) %>% 
  summarize(
    total_population = sum(PERWT, na.rm=T)
  )

# Median Household Income
df1 <- data %>%
  filter(PERNUM==1) %>%
  group_by(STATEFIP, YEAR) %>% 
  summarize(
    median_hh_income = weighted.median(HHINCOME, HHWT, na.rm=T)
  )

# Unemployment Rate
df2 <- data %>%
  filter(EMPSTAT>=1 & EMPSTAT<=2) %>%
  group_by(STATEFIP, YEAR) %>% 
  summarize(
    unemployment_rate = weighted.mean(EMPSTAT==2, PERWT, na.rm=T)
  )

# Poverty Rate
df3 <- data %>%
  filter(POVERTY>0) %>%
  group_by(STATEFIP, YEAR) %>%
  summarize(
    poverty_rate = weighted.mean(POVERTY<100, PERWT, na.rm=T)
  )

# College Share
df4 <- data %>%
  filter(AGE>=25, AGE<=65) %>%
  group_by(STATEFIP, YEAR) %>% 
  summarize(
    college_pct = weighted.mean(EDUC>=10, PERWT, na.rm=T)
  )

df <- df0 %>% 
  inner_join(df1, by=c("STATEFIP","YEAR")) %>%  
  inner_join(df2, by=c("STATEFIP","YEAR")) %>%  
  inner_join(df3, by=c("STATEFIP","YEAR")) %>%  
  inner_join(df4, by=c("STATEFIP","YEAR"))

write.csv(df, "ipums_state_by_year.csv", row.names=F)

