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
df$log_airbnb <- 'your input'
df$log_pop <- 'your input'
df$log_inc <- 'your input'
df$log_tourists <- 'your input'

# Plot log airbnb over time for each city
ggplot(data='your input') +
  geom_line(aes(x='your input', y='your input', color=city)) +  
  geom_vline(xintercept='your input', linetype='dashed') +     # this adds a vertical line at the treatment date!
  theme_bw()

# Plot averaged log airbnb by treatment and control
df$treatment <- df$city %in% c('your input', 'your input', 'your input', 'your input')

df2 <- df %>%
  group_by('your input') %>%
  summarize(
    avg_log_airbnb = 'your input'
  )

ggplot(data='your input') + 
  geom_line(aes(x='your input', y='your input', color='your input')) + 
  geom_vline(xintercept='your input', linetype='dashed') + 
  theme_bw()


# Regressions
df$post <- 'your input'         # this variable should be equal to 1 if the year>2015, 0 otherwise
df$treatXpost <- 'your input'   # this variable should equal 1 if year>2015 AND the city is treated, 0 otherwise

r1 <- felm('your input', data=df) 
r2 <- felm('your input', data=df)
r3 <- felm('your input', data=df)

stargazer(r1, r2, r3, type="text")









