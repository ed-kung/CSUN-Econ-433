# ECON 433 - Lab Session 8
## Panel Data and Difference-in-Differences Analysis

In this lab you will conduct difference-in-differences analysis using panel data.

## Background

**Panel Data** 

Panel data refers to data in which the same subject is observed repeatedly over multiple time periods. Difference-in-differences analysis can only be performed on panel data. Obervations in panel data are indexed by $i$, which indexes the subject, and $t$, which indexes the time period. 

Example: You have panel data where you observe the number of Airbnb listings in a group of cities over multiple time periods. The cities are the subjects and they are indexed by $i$. The time periods are indexed by $t$. The variable $Airbnb_{it}$ would refer to the number of Airbnb listings in city $i$ at time $t$.

**Difference-in-differences**

Difference-in-differences (DID) is a research design for estimating the effect of an intervention, or treatment. In Public Economics, the intervention is often a policy of some kind. For example, we might use DID to study the effect of Airbnb regulations on the number of Airbnb listings.

DID works when there is a group of subjects affected by the intervention (called the **treatment group**) and a group of subjects not affected by the intervention (called the **control group**). In DID, we compare the **change** in outcomes for the treatment group to the **change** in outcomes for the control group, over the time period in which the intervention happens.

The table below shows a schematic of the most basic DID. The treatment happens between times $T_0$ and $T_1$. $Y_{00}$ is the outcome in the control group at time $T0$ and $Y_{01}$ is the outcome in the control group at time $T_1$. $Y_{10}$ is the outcome in the treatment group at time $T_0$ and $Y_{11}$ is the outcome in the treatment group at time $T_1$.

|                   | $T_0$    | $T_1$    |
| ----------------- | -------- | -------- |
| Control Group     | $Y_{00}$ | $Y_{01}$ |
| Treatment Group   | $Y_{10}$ | $Y_{11}$ |

The DID treatment effect estimator is:

$$\text{DID Estimated Treatment Effect} = \underbrace{(Y_{11} - Y_{10})}_{\text{Change in outcome for} \atop \text{control group}} - (Y_{01} - Y_{00})$$


