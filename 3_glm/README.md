# 3 - Fitting a GLM in R

Here you find the material for the chapter "Data manipulation and visualizations".

### Packages
For this chapter you need the following packages:

```{r, include=TRUE, message=FALSE, warning=FALSE}
options(encoding = 'UTF-8')

#Loading all the necessary packages
if (!require("caret")) install.packages("caret")
if (!require("visreg")) install.packages("visreg")
if (!require("MASS")) install.packages("MASS")

library("caret")
library("visreg")
library("MASS")
```

### References
The training material in this chapter is taken from (with minor changes):
- "Insurance Analytics, A Primer", 31th International Summer School of the Swiss Association of Actuaries (2018)
  (https://github.com/fpechon/SummerSchool)

