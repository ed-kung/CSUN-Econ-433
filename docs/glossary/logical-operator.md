---
layout: default
title: logical operator
parent: Glossary
---

# logical operator
{: .no_toc }

A **logical operator** is something that applies to one or more variables and returns a TRUE/FALSE variable (a.k.a. a boolean variable).

## Common logical operators

- `>` and `>=`: greater than / greater than or equal to (applies to numerical values)
- `<` and `<=`: less than / less than or equal to (applies to numerical values)
- `==`: exactly equal to (can apply to non-numerical values as well)
- `!=`: not equal to (can apply to non-numerical values)
- `&`: and (applies to boolean values)
- `|`: or (applies to boolean values)

## Example

Suppose we have the following data in `df`:

|ID | AGE  | EMPSTAT |
| - | ---- | ------- |
| 1 | 18   |       3 |
| 2 | 25   |       1 |
| 3 | 30   |       2 |
| 4 | 40   |       1 |
| 5 | 50   |       1 |
| 6 | 65   |       2 |
| 7 | 70   |       3 |
| 8 | 80   |       3 |

Suppose we ran the following code:

```r
df$EMPLOYED <- df$EMPSTAT==1
df$OLDER_THAN_25 <- df$AGE>=25
df$YOUNGER_THAN_65 <- df$AGE<=65
df$WORKING_AGE <- (df$OLDER_THAN_25==TRUE) & (df$YOUNGER_THAN_65==TRUE)
```

The resulting dataframe would look like:

|ID | AGE  | EMPSTAT | EMPLOYED | OLDER_THAN_25 | YOUNGER_THAN_65 | WORKING_AGE |
| - | ---- | ------- | -------- | ------------- | --------------- | ----------- |
| 1 | 18   |       3 | FALSE    | FALSE         | TRUE            | FALSE       |
| 2 | 25   |       1 | TRUE     | TRUE          | TRUE            | TRUE        |
| 3 | 30   |       2 | FALSE    | TRUE          | TRUE            | TRUE        |
| 4 | 40   |       1 | TRUE     | TRUE          | TRUE            | TRUE        |
| 5 | 50   |       1 | TRUE     | TRUE          | TRUE            | TRUE        |
| 6 | 65   |       2 | FALSE    | TRUE          | TRUE            | TRUE        |
| 7 | 70   |       1 | TRUE     | TRUE          | FALSE           | FALSE       |
| 8 | 80   |       3 | FALSE    | TRUE          | FALSE           | FALSE       |


