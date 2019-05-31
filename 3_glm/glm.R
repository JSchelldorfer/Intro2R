## ---- include=TRUE, warning=FALSE, message=FALSE-------------------------
options(encoding = 'UTF-8')

# install packages if needed
if (!require("CASdatasets")) install.packages("CASdatasets", repos = "http://cas.uqam.ca/pub/R/", type="source")
if (!require("caret")) install.packages("caret")
if (!require("visreg")) install.packages("visreg")
if (!require("MASS")) install.packages("MASS")

# Load packages
library("CASdatasets")
library("caret")
library("visreg")
library("MASS")


## ---- tidy=TRUE----------------------------------------------------------
## 1) If "CASdatasets" package can be loaded, then as follows:
data("freMTPLfreq")
freMTPLfreq = subset(freMTPLfreq, Exposure<=1 & Exposure >= 0 & CarAge<=25)
# Subsample of the whole dataset

set.seed(85)
folds = createDataPartition(freMTPLfreq$ClaimNb, 0.5)
df_freMTPLfreq = freMTPLfreq[folds[[1]], ]
#save(df_freqMTPLfreq, file="../dataset.RData")

## 3) If not, then download the file "freMTPLfreq.RData" from the GitHub repository and run the following:
#data_path <- "C:/Users/juerg/AktuarDataScience/Varia/2019_SSA/"
#load(file=paste(data_path,"df_freMTPLfreq.RData",sep=""))
dataset <- df_freMTPLfreq


## ---- tidy=TRUE----------------------------------------------------------
set.seed(21)
in_training = createDataPartition(df_freMTPLfreq$ClaimNb, times = 1, p = 0.8, list=FALSE)
training_set = df_freMTPLfreq[in_training,]
testing_set  = df_freMTPLfreq[-in_training,]


## ---- tidy=TRUE----------------------------------------------------------
m0 = glm(ClaimNb ~ offset(log(Exposure)), 
         data = training_set,
         family=poisson())
summary(m0)


## ---- eval=FALSE, tidy=TRUE----------------------------------------------
## exp(m0$coefficients)


## ---- tidy=TRUE----------------------------------------------------------
m1 = glm(ClaimNb ~ offset(log(Exposure)) + Power  + Gas + Brand + Region,
         data = training_set,
         family=poisson(link = log))
summary(m1)


## ---- tidy=TRUE, fig.align='center', dpi=500-----------------------------
visreg(m1, type="contrast", scale="response")


## ---- tidy=TRUE----------------------------------------------------------
anova(m0, m1, test="Chisq")


## ---- tidy=TRUE----------------------------------------------------------
training_set$Brand_merged = training_set$Brand
testing_set$Brand_merged = testing_set$Brand
levels(training_set$Brand_merged) <- list("A" = c("Fiat","Mercedes, Chrysler or BMW",
                                                  "Opel, General Motors or Ford",
                                                  "other",
                                                  "Volkswagen, Audi, Skoda or Seat"),
                                          "B" = "Japanese (except Nissan) or Korean",
                                          "C" = "Renault, Nissan or Citroen")
levels(testing_set$Brand_merged) <- list("A" = c("Fiat","Mercedes, Chrysler or BMW",
                                                  "Opel, General Motors or Ford",
                                                  "other",
                                                  "Volkswagen, Audi, Skoda or Seat"),
                                          "B" = "Japanese (except Nissan) or Korean",
                                          "C" = "Renault, Nissan or Citroen")
table(training_set$Brand_merged, useNA = "always")


## ---- tidy=TRUE----------------------------------------------------------
m2 = glm(ClaimNb ~ offset(log(Exposure)) + Power  + Gas + Brand_merged + Region,
         data = training_set,
         family=poisson(link = log))
summary(m2)


## ---- tidy=TRUE----------------------------------------------------------
anova(m2, m1, test="Chisq")


## ---- tidy=TRUE, dpi=500, fig.align='center'-----------------------------
visreg(m2, xvar="Power", type="contrast", scale="response")


## ---- tidy=TRUE----------------------------------------------------------
training_set$Power_merged = training_set$Power
levels(training_set$Power_merged) = list("A"= "d",
                                         "B" = c("e","f", "g", "h"),
                                         "C" = c("i","j", "k", "l", "m", "n", "o"))
testing_set$Power_merged = testing_set$Power
levels(testing_set$Power_merged) = list("A"= "d",
                                         "B" = c("e","f", "g", "h"),
                                         "C" = c("i", "j",  "k", "l", "m", "n", "o"))
m3 = glm(ClaimNb ~ offset(log(Exposure)) + Power_merged  + Gas + Brand_merged + Region,
         data = training_set,
         family=poisson(link = log))
summary(m3)
anova(m3, m2, test="Chisq")


## ----tidy=TRUE, dpi=500, fig.align='center'------------------------------
visreg(m3, xvar="Region", type="contrast", scale="response")


## ---- tidy=TRUE----------------------------------------------------------
training_set$Region_merged = training_set$Region
levels(training_set$Region_merged)[c(1,5, 10)] ="R11-31-74"
testing_set$Region_merged = testing_set$Region
levels(testing_set$Region_merged)[c(1,5, 10)] ="R11-31-74"
m4 = glm(ClaimNb ~ offset(log(Exposure)) + Power_merged  + Gas + Brand_merged + Region_merged,
         data = training_set,
         family=poisson(link = log))
summary(m4)
anova(m4, m3, test="Chisq")


## ---- tidy=TRUE----------------------------------------------------------
m5.1 = glm(ClaimNb ~ offset(log(Exposure)) + Power_merged  * Gas + Brand_merged + Region_merged,
         data = training_set,
         family=poisson(link = log))
summary(m5.1)
anova(m4, m5.1, test="Chisq")


## ---- tidy=TRUE----------------------------------------------------------
m5.2 = glm(ClaimNb ~ offset(log(Exposure)) + Power_merged  + Gas +  Power_merged *Brand_merged + Gas+Region_merged,
         data = training_set,
         family=poisson(link = log))
anova(m4, m5.2, test="Chisq")
m5.3 = glm(ClaimNb ~ offset(log(Exposure)) + Power_merged  + Gas +  Brand_merged + Gas + Power_merged *Region_merged,
         data = training_set,
         family=poisson(link = log))
anova(m4, m5.3, test="Chisq")


## ---- tidy=TRUE----------------------------------------------------------
m5.4 = glm(ClaimNb ~ offset(log(Exposure)) + Power_merged   +Brand_merged* Gas +Power_merged*Region_merged,
         data = training_set,
         family=poisson(link = log))
anova(m5.3, m5.4, test="Chisq")
m5.5 = glm(ClaimNb ~ offset(log(Exposure)) + Power_merged*Region_merged + Gas +Brand_merged + Gas+Region_merged* Gas,
         data = training_set,
         family=poisson(link = log))
anova(m5.3, m5.5, test="Chisq")


## ---- tidy=TRUE----------------------------------------------------------
m5.6 = glm(ClaimNb ~ offset(log(Exposure)) + Power_merged  * Region_merged +  Brand_merged + Gas+Region_merged* Brand_merged,
         data = training_set,
         family=poisson(link = log))
anova(m5.3, m5.6, test="Chisq")


## ---- tidy=TRUE, fig.align='center', dpi=500-----------------------------
visreg(m5.6, xvar="Power_merged", by="Region_merged", scale="response", type="contrast")


## ---- tidy=TRUE, fig.align='center', dpi=500-----------------------------
visreg(m5.6, xvar="Brand_merged", by="Region_merged", scale="response", type="contrast")


## ---- tidy=TRUE----------------------------------------------------------
results = rep(NA, 7)
results[1] = 2*(sum(dpois(x = testing_set$ClaimNb, lambda = testing_set$ClaimNb,log=TRUE))-
  sum(dpois(x = testing_set$ClaimNb, lambda = predict(m0, newdata=testing_set,  type="response"),log=TRUE)))
results[2] = 2*(sum(dpois(x = testing_set$ClaimNb, lambda = testing_set$ClaimNb,log=TRUE))-
  sum(dpois(x = testing_set$ClaimNb, lambda = predict(m1, newdata=testing_set,  type="response"),log=TRUE)))
results[3] = 2*(sum(dpois(x = testing_set$ClaimNb, lambda = testing_set$ClaimNb,log=TRUE))-
  sum(dpois(x = testing_set$ClaimNb, lambda = predict(m2, newdata=testing_set,  type="response"),log=TRUE)))
results[4] = 2*(sum(dpois(x = testing_set$ClaimNb, lambda = testing_set$ClaimNb,log=TRUE))-
  sum(dpois(x = testing_set$ClaimNb, lambda = predict(m3, newdata=testing_set,  type="response"),log=TRUE)))
results[5] = 2*(sum(dpois(x = testing_set$ClaimNb, lambda = testing_set$ClaimNb,log=TRUE))-
  sum(dpois(x = testing_set$ClaimNb, lambda = predict(m4, newdata=testing_set,  type="response"),log=TRUE)))
results[6] = 2*(sum(dpois(x = testing_set$ClaimNb, lambda = testing_set$ClaimNb,log=TRUE))-
  sum(dpois(x = testing_set$ClaimNb, lambda = predict(m5.3, newdata=testing_set,  type="response"),log=TRUE)))
results[7] = 2*(sum(dpois(x = testing_set$ClaimNb, lambda = testing_set$ClaimNb,log=TRUE))-
  sum(dpois(x = testing_set$ClaimNb, lambda = predict(m5.6, newdata=testing_set,  type="response"),log=TRUE)))
results

