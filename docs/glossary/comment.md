---
layout: default
title: comment
parent: Glossary
---

# comment

A comment is a line of code, or segment of code, that is ignored by R.

Programmers use comments to add notes and other documentation to their code.

You can create a comment in R by adding a hashtag `#` before the text that you want R to ignore.

## Example

```r
rm(list=ls())   # Clear the workspace (this is a comment)

# Read in my data (this is also a comment)
df <- read.csv("my_data.csv")
```


