---
layout: default
title: variable
parent: Glossary
---

# variable

You can think of a variable as a column in a [dataframe](/docs/glossary/dataframe). 

If you have a dataframe named `df`, you can refer to a variable called `var` inside it using `df$var`.

**Example**:

To tabulate a variable called `RACHSING` in a dataframe called `mydf`:

```r
table(mydf$RACHSING)
```

