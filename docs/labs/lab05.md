---
layout: default
title: 5. Data Visualization
parent: Labs
nav_order: 5
---

# Lab 5
{: .no_toc }

## Data Visualization
{: .no_toc }

Data visualization is the practice of presenting data in a visually appealing way, so that interesting patterns can be easily spotted.

In this lab you will learn how to create three basic types of data visualization in R:
- [Line plots](/docs/vignettes/line-plots){:target="_blank"}
- [Scatter plots](/docs/vignettes/scatter-plots){:target="_blank"}
- [Bar charts](/docs/vignettes/bar-charts){:target="_blank"}

---

## Preparation

You should already have `IPUMS_ACS_CA_2014_2019.csv` in your R Studio Cloud files directory. If you don't have this file, check the instructions for [Lab 4](/docs/labs/lab04).

You'll also need `DEGFIELD_CODES.csv` and `RACE_CODES.csv`. Download these from Canvas and upload them to your R Studio Cloud files directory.

You'll also need the packages `dplyr` and `ggplot2`. `dplyr` should already be installed, but not `ggplot2`. Go ahead and install `ggplot2` by typing this into the console:

```r
install.packages("ggplot2")
```

---







