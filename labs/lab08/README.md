# ECON 433 - Lab Session 8
## Panel Data and Difference-in-Differences Analysis

In this lab you will conduct difference-in-differences analysis using panel data.

## Background


### Difference-in-differences

Difference-in-differences (DID) is a research design for estimating the effect of an intervention, or treatment. In Public Economics, the intervention is often a policy of some kind. For example, we might use DID to study the effect of Airbnb regulations on the number of Airbnb listings.

DID works when there is a group of subjects affected by the intervention (called the **treatment group**) and a group of subjects not affected by the intervention (called the **control group**). In DID, we compare the **change** in outcomes for the treatment group to the **change** in outcomes for the control group, over the time period in which the intervention happens.

The table below shows a schematic of the most basic DID with two subjects and two time periods. The treatment happens between times $T_0$ and $T_1$. $Y_{00}$ is the outcome in the control subject at time $T0$ and $Y_{01}$ is the outcome in the control subject at time $T_1$. $Y_{10}$ is the outcome in the treatment subject at time $T_0$ and $Y_{11}$ is the outcome in the treatment subject at time $T_1$.

|                     | $T_0$    | $T_1$    |
| ------------------- | -------- | -------- |
| Control Subject     | $Y_{00}$ | $Y_{01}$ |
| Treatment Subject   | $Y_{10}$ | $Y_{11}$ |

The DID treatment effect estimator is:

$$\text{DID Estimated Treatment Effect} = \underbrace{(Y_{11} - Y_{10})}_{\text{Change in outcome for} \atop \text{treatment subject}} - \underbrace{(Y_{01} - Y_{00})}_{\text{Change in outcome for} \atop \text{control subject}}$$

Notice how the DID estimator takes the difference of two differenecs, hence the name "difference-in-differences".

### Panel Data

Panel data refers to data in which the same subjects are observed repeatedly over multiple time periods. DID analysis can only be performed on panel data. Obervations in panel data are indexed by $i$, which indexes the subject, and $t$, which indexes the time period. So, $Y_{it}$ would refer to the outcome variable for subject $i$ in time $t$.

With panel data, DID analysis can be conducted using linear regressions. Suppose the intervention happens between time $T_{0}$ and $T_{1}$. Define $Post_{t}$ as a binary variable equal to 1 if $t \geq T_{1}$ and 0 otherwise.  Define $Treated_{i}$ as a binary variable equal to 1 if subject $i$ is in the treatment group and 0 otherwise. Then the DID treatment effect estimator is equal to the estimated coefficient $\beta_{1}$ in the following regression:

$$Y_{it} = \beta_0 + \beta_1 Treated_{i} \times Post_{t} + \delta_{i} + \gamma_{t} + \epsilon_{it}$$

Here, $\delta_{i}$ are dummy variables for each subject and $\gamma_{t}$ are dummy variables for each time period.  

If you had a dataframe called `df` in R with the following structure:

| Subject | Time | Outcome | Treated | Post |
| ------- | ---- | ------- | ------- | ---- |
| ...     | ...  | ...     | ...     | ...  |

Then the DID treatment effect can be estimated with the following R code:

    felm(Outcome ~ Treated*Post | Subject + Time, data=df)

### Graphical Analysis of Pre-Trends

DID is only valid if the treatment and control groups have similar time trends prior to the intervention happening. To verify this, you can plot the average outcomes in the treatment and control groups over time and show that prior to the intervention they had similar trends.

If you had a dataframe called `df` in R with the same structure as above, you can accomplish this plot with the following code:

    plot_df <- df %>%
	  group_by(Treated, Time) %>%
      summarize(MeanOutcome = mean(Outcome)) 
    
    ggplot(data=df) + 
      geom_line(aes(x=Time, y=MeanOutcome, color=Treated)) 	

This would give you a plot with two lines. One line shows the path of outcomes over time for the treatment group and the other line shows the path of outcomes over time for the control group. You can then verify that prior to the intervention the two lines had similar time trends.








