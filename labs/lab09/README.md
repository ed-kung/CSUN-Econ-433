# ECON 433 - Lab Session 9
## Regression Discontinuity Analysis

In this lab you will conduct regression discontinuity analysis using simulated data.

## Background

### Regression Discontinuity

Regression discontinuity (RD) is a research design for estimating the effect of a treatment that only occurs for subjects above or below a certain threshold of a "running variable."

Example of RDs:

- How do house prices change as you go from one side of a school district boundary to another? (We might expect prices to jump as we move from the side with a bad school to the side with a good school.) In this case, the running variable is the distance to the boundary. 

- Suppose there is a national college entrance exam where only students who score above 70% are placed at a college. How do future earnings change for students who score just below 70% compared to those who scored just above 70%? The running variable here is the test score.

Regression discontinuity analysis can be conducted on cross-sectional data. All you need is data on the outcome variable of interest and the running variable.

### Graphical Analysis

RD analysis usually occurs in at least two steps. First, a graphical analysis is performed to see whether it looks like there is a jump in the outcome at the threshold. Below is an example of a RD analysis graph.

![RD Graph](image01.png)

### Regression Analysis

The second step is to conduct a regression analysis so that the numerical size of the jump can be estimated.  A RD regression usually has the following form:

$$Y_i = \beta_0 + \beta_1 TREAT_i + f(r_i) + \epsilon_i$$

Here, $r_i$ is the running variable for subject $i$, and $TREAT_i$ is a binary variable indicating whether or not $r_i$ is above or below the threshold for treatment.







