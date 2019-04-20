# 2 - Data manipulation and visualizations

Here you find the material for the chapter "Data manipulation and visualizations".

### Packages
For this chapter you need the following packages:

```{r, include=TRUE, message=FALSE, warning=FALSE}
options(encoding = 'UTF-8')
#Loading all the necessary packages
if (!require("CASdatasets")) install.packages("CASdatasets", repos = "http://cas.uqam.ca/pub/R/", type="source")
if (!require("caret")) install.packages("caret")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("mgcv")) install.packages("mgcv")
if (!require("plyr")) install.packages("plyr")
if (!require("gridExtra")) install.packages("gridExtra")
if (!require("visreg")) install.packages("visreg")
if (!require("MASS")) install.packages("MASS")
if (!require("plotrix")) install.packages("plotrix")
if (!require("rgeos")) install.packages("rgeos", type="source")
if (!require("rgdal")) install.packages("rgdal", type="source")
if (!require("xtable")) install.packages("xtable")
if (!require("formatR")) install.packages("formatR")
if (!require("maptools")) install.packages("maptools")

library("CASdatasets")
library("ggplot2")
library("mgcv")
library("caret")
library("gridExtra")
library("plyr")
library("visreg")
library("MASS")
library("plotrix")
library("rgdal")
library("rgeos")
library("xtable")
library("formatR")
library("maptools")
```

### References
The training material in this chapter is taken from (with minor changes):
- "Insurance Analytics, A Primer", 31th International Summer School of the Swiss Association of Actuaries (2018)
  (https://github.com/fpechon/SummerSchool)
