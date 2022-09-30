rm(list=ls())  # Clear workspace
library(dplyr) # Load dplyr

df1 <- read.csv("IPUMS_ACS2019_CA_1.csv")  # Load 2019 ACS data (1)
df2 <- read.csv("IPUMS_ACS2014_CA_1.csv")  # Load 2014 ACS data (1)
df3 <- read.csv("IPUMS_ACS2019_CA_2.csv")  # Load 2019 ACS data (2)
df4 <- read.csv("IPUMS_ACS2014_CA_2.csv")  # Load 2014 ACS data (2)
dcodes <- read.csv("DEGFIELD_CODES.csv")

# Merge the two 2019 ACS dataframes
df2019 <- 

# Merge the two 2014 ACS dataframes
df2014 <- 

# Append the 2019 and 2014 dataframes
df <- 

# Filter to employed individuals with bachelors degrees
df <- 
df <- 

# Deal with missing values for INCWAGE
df$INCWAGE <- 

# Calculate the weighted mean of INCWAGE by DEGFIELD, YEAR
dfg <- df %>%
  group_by( #INPUT HERE ) %>%
  summarize(
    # INPUT HERE
  )

# Merge human readable DEGFIELD codes
dfg <- 

# Pivot long to wide
dfg_wide <- pivot_wider(
  dfg, 
  id_cols = # YOUR INPUT HERE, 
  names_from = # YOUR INPUT HERE, 
  values_from = #YOUR INPUT HERE"
)

View(dfg_wide)




