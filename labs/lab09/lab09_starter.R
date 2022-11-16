rm(list=ls())  # clear the workspace

# Load the required libraries
library(lfe) 
library(dplyr)
library(stargazer)
library(ggplot2)

# Load the dataset
df <- read.csv("airbnb.csv")

# Show the list cities
unique(df$city)

# Show the years
unique(df$year)

# Define log variables
df$log_airbnb <- YOUR_INPUT
df$log_pop <- YOUR_INPUT
df$log_inc <- YOUR_INPUT
df$log_tourists <- YOUR_INPUT

# Plot log airbnb over time for each city
ggplot(data=YOUR_INPUT) +
  geom_line(aes(x=YOUR_INPUT, y=YOUR_INPUT, color=city)) +  
  geom_vline(xintercept=YOUR_INPUT, linetype='dashed') +     # this adds a vertical line at the treatment date!
  theme_bw()

# Define a variable that equals 1 if the city is treated and 0 otherwise
df$treatment <- df$city %in% c(YOUR_INPUT, YOUR_INPUT, YOUR_INPUT, YOUR_INPUT)

# Calculate the average of log_airbnb by treatment/year
df2 <- df %>%
  group_by(YOUR_INPUT) %>%
  summarize(
    avg_log_airbnb = YOUR_INPUT
  )

# Plot average of log_airbnb by treatment/year
ggplot(data=YOUR_INPUT) + 
  geom_line(aes(x=YOUR_INPUT, y=YOUR_INPUT, color=YOUR_INPUT)) + 
  geom_vline(xintercept=YOUR_INPUT, linetype='dashed') + 
  theme_bw()


# Regressions
df$post <- YOUR_INPUT         # this variable should be equal to 1 if the year>2015, 0 otherwise
df$treatXpost <- YOUR_INPUT   # this variable should equal 1 if year>2015 AND the city is treated, 0 otherwise

r1 <- felm(YOUR_INPUT, data=df) 
r2 <- felm(YOUR_INPUT, data=df)
r3 <- felm(YOUR_INPUT, data=df)

stargazer(r1, r2, r3, type="text")









