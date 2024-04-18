---
layout: default
title: Installing packages
parent: Vignettes
nav_order: 6
---

# Installing packages
{: .no_toc }

A package is a collection of functions and tools that expands R's baseline functionality. Packages are written by authors and developers from around the world, and are made available for free on [CRAN](https://cran.r-project.org/){:target="_blank"} (the Comprehensive R Archive Network).

- TOC
{:toc}

---

## Installing packages

To install a package with the name `package_name`, type the following into your console and hit `ENTER`:

```r
install.packages("package_name")
```

Don't forget to put the package name in double quotation marks.

{: .note}
> You only need to install a package in your R Studio Cloud workspace once. Therefore, it's best not to include `install.packages` in your scripts, but instead run it from the console.

---

## Loading packages

To load an installed package with the name `package_name`, include the following line of code at the top of your script:

```r
library(package_name)
```

You don't need to put the package name in double quotation marks here.

{: .note}
> As a best practice, load all your packages at the top of your script, after `rm(list=ls())` but before any other commands.

---

## Packages in this class

These are the packages we'll make use of in this class:

- `dplyr`: A package containing many useful data management tools. Stands for "data pliers".
- `ggplot2`: A package containing many useful data visualization tools.
- `lfe`: A package containing many useful regression tools, specifically for running regressions with a large number of dummy variables.
- `stargazer`: A package for reporting the output of regressions in a nicely formatted way.