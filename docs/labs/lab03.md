---
layout: default
title: 3. Using Population Weights
parent: Labs
nav_order: 3
---

# Lab 3
{: .no_toc }

## Using Population Weights
{: .no_toc }

In the previous lab, you learned how to tabulate and summarize variables with `table` and `summary`.

Unfortunately, the statistics provided by `table` and `summary` in the previous lab were not accurate, because they ignored **population weights**.

The American Community Survey is a [stratified sample](/docs/glossary/stratified-sample), meaning that not all individuals are surveyed with equal probability.

Thus, each surveyed individual represents a different number of people in the population. For example, if 1 in 1,000 white people are surveyed, then each white person in the data represents 1,000 people in the population; but if 1 in 500 black people are surveyed, then each black person in the data represents 500 people in the population.

In the IPUMS ACS, the population weight is given by the variable `PERWT`. `PERWT` tells us how many people that row of the data is meant to represent.

If we want to calculate population statistics accurately using a stratified sample, we need to use the population weights.


