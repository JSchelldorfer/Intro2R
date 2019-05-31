## ---- include=TRUE, message=FALSE, warning=FALSE-------------------------
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


## ---- tidy=TRUE----------------------------------------------------------
## If CASdatasets package can be loaded, run the following
## Loading the dataset
# require("CASdatasets")
# data("ausprivauto0405")
# 
## split the data set for analysis
# set.seed(85)
# folds = createDataPartition(ausprivauto0405$ClaimNb, 0.5)
# df_ausprivauto0405 = ausprivauto0405[folds[[1]], ]
# save(df_ausprivauto0405, file="../df_ausprivauto0405.RData")

## If CASdatasets package can not be loaded, run the following:
load("df_ausprivauto0405.RData") # load(file="path to the file df_ausprivauto0405")
dataset <- df_ausprivauto0405 # store as dataset for easier re-use of previous code


## ---- tidy=TRUE----------------------------------------------------------
head(dataset)


## ---- tidy=TRUE----------------------------------------------------------
str(dataset)


## ---- tidy=TRUE----------------------------------------------------------
summary(dataset)


## ---- tidy=TRUE----------------------------------------------------------
#


## ---- tidy=TRUE----------------------------------------------------------
#


## ---- tidy=TRUE----------------------------------------------------------
#

