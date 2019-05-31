# 4 - Exercises

Here you find the material for the chapter "Exercises".

### Packages
For this chapter you need the following packages:

```{r, include=TRUE, message=FALSE, warning=FALSE}
options(encoding = 'UTF-8')

#Loading all the necessary packages
if (!require("CASdatasets")) install.packages("CASdatasets", repos = "http://cas.uqam.ca/pub/R/", type="source")
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("caret")) install.packages("caret")
if (!require("plyr")) install.packages("plyr")
if (!require("mgcv")) install.packages("mgcv")
if (!require("gridExtra")) install.packages("gridExtra")
if (!require("visreg")) install.packages("visreg")
if (!require("MASS")) install.packages("MASS")

require("CASdatasets")
require("tidyverse")
require("plyr")
require("caret")
require("mgcv")
require("gridExtra")
require("visreg")
require("MASS")

```

### References
The training material in this chapter closely follows:
- "CASdatasets Package Vignette", Reference Manual (http://cas.uqam.ca/)
- "Computational Actuarial Science with R", A. Charpentier, CRC Press
