---
layout: default
title: microdata
parent: Glossary
---

# microdata

## Definition

**Microdata** refers to data about individual survey units, often individual companies or individual people. The opposite of microdata is **aggregate data**, which presents data on *groups* of individual survey units calculated from the microdata.

## Example 

You work at Panda Express and you have data on customer satisfaction surveys. The table below shows data from 9 surveys from 3 restaurants:

| Survey_ID     | Restaurant_ID  | Satisfaction |
| ------------: | -------------: | -----------: |
|           1   | A              | 4            |
|           2   | A              | 4            |
|           3   | A              | 3            |
|           4   | B              | 4            |
|           5   | B              | 5            |
|           6   | B              | 4            |
|           7   | C              | 3            |
|           8   | C              | 2            |
|           9   | C              | 3            |

This is an example of **microdata**, since it records the satisfaction of each individual survey.

Suppose you want to calculate the average satisfaction score for each restaurant, as well as the number of surveys coming from each restaurant. See this vignette for a tutorial on how. 

If you did that, the resulting data would like this:

| Restaurant_ID | Avg_Satisfaction | Num_Surveys |
| ------------: | ---------------: | ----------: |
|             A |             3.67 |           3 |
|             B |             4.33 |           3 |
|             C |             2.67 |           3 |

This is an example of **aggregate data**, since it presents data on groups of surveys (grouped by restaurants) and it is calculated from the underlying microdata.
