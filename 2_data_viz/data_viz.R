## ---- include=TRUE, message=FALSE, warning=FALSE-------------------------
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

require("CASdatasets")
require("ggplot2")
require("mgcv")
require("caret")
require("gridExtra")
require("plyr")
require("visreg")
require("MASS")
require("plotrix")
require("rgdal")
require("rgeos")
require("xtable")
require("formatR")
require("maptools")


## ----set-options, echo=FALSE, cache=FALSE--------------------------------
options(width = 75)


## ---- tidy=TRUE----------------------------------------------------------
## 1) If "CASdatasets" package can be loaded, then as follows:
data("freMTPLfreq")
freMTPLfreq = subset(freMTPLfreq, Exposure<=1 & Exposure >= 0 & CarAge<=25)
# Subsample of the whole dataset
set.seed(85)
folds = createDataPartition(freMTPLfreq$ClaimNb, 0.5)
df_freqMTPLfreq = freMTPLfreq[folds[[1]], ]
#save(df_freqMTPLfreq, file="../dataset.RData")

## 3) If not, then download the file "freMTPLfreq.RData" from the GitHub repository and run the following:
#data_path <- "C:/Users/juerg/AktuarDataScience/Varia/2019_SSA/"
#load(file=paste(data_path,"df_freMTPLfreq.RData",sep=""))
dataset <- df_freqMTPLfreq


## ---- tidy=TRUE----------------------------------------------------------
head(dataset)


## ---- tidy=TRUE----------------------------------------------------------
str(dataset)


## ---- tidy=TRUE----------------------------------------------------------
summary(dataset)


## ---- eval=FALSE, tidy=FALSE---------------------------------------------
## ?head


## ---- tidy=TRUE----------------------------------------------------------
length(unique(dataset$PolicyID)) == nrow(dataset)


## ---- fig.align='center', tidy=TRUE--------------------------------------
table(cut(dataset$Exposure, breaks = seq(from = 0, to = 1,by = 1/12), labels = 1:12))


## ---- fig.align='center', tidy=TRUE--------------------------------------
round(prop.table(table(cut(dataset$Exposure, breaks = seq(from = 0, to = 1,by = 1/12), labels = 1:12))), 4)


## ----fig.align='center', cache=TRUE, tidy=TRUE, dpi=500------------------
Exposure.summary = cut(dataset$Exposure, breaks = seq(from = 0, to = 1,by = 1/12))
levels(Exposure.summary) = 1:12
ggplot()+geom_bar(aes(x=Exposure.summary)) + xlab("Number of months") + ggtitle("Exposure in months")


## ----fig.align='center', cache=TRUE, tidy=TRUE, dpi=500------------------
ggplot(dataset, aes(x=ClaimNb))+geom_bar()+
geom_text(stat='count', aes(label=..count..), vjust=-1)+ylim(c(0,210000))+
  ylab("")+ xlab("Number of Claims")+  ggtitle("Proportion of policies by number of claims")


## ---- results='asis',eval=FALSE, tidy=TRUE-------------------------------
## sum(dataset$ClaimNb) / sum(dataset$Exposure)


## ---- echo=TRUE, cache=TRUE, tidy=TRUE-----------------------------------
levels(dataset$Power)


## ---- tidy=TRUE----------------------------------------------------------
table(dataset$Power)


## ---- tidy=TRUE----------------------------------------------------------
require(plyr)
Power.summary = ddply(dataset, .(Power), summarize, totalExposure = sum(Exposure), Number.Observations = length(Exposure))


## ---- fig.align='center', dpi=500, tidy=TRUE-----------------------------
ggplot(Power.summary, aes(x=Power, y=totalExposure, fill=Power)) + 
  geom_bar(stat="identity")+
  ylab("Exposure in years")+
  geom_text(stat='identity', aes(label=round(totalExposure, 0), color=Power), vjust=-0.5)+
  guides(fill=FALSE, color=FALSE)


## ---- tidy=TRUE, results='hide', message=FALSE---------------------------
Power.summary = ddply(dataset, .(Power), summarize, totalExposure = sum(Exposure), Number.Observations = length(Exposure), Number.Claims = sum(ClaimNb), Obs.Claim.Frequency = sum(ClaimNb)/sum(Exposure))
Power.summary

## ---- results='asis', warning=FALSE, echo=FALSE, message=FALSE-----------
require(xtable)
print(xtable(Power.summary, digits=c(0,1,2,0,0,5)), type = "html", include.rownames=FALSE)


## ---- fig.align='center', dpi=500, tidy=TRUE-----------------------------
portfolio.cf = sum(dataset$ClaimNb)/ sum(dataset$Exposure)
ggplot(Power.summary) + geom_bar(stat="identity", aes(x=Power, y=Obs.Claim.Frequency, fill=Power)) + 
  geom_line(aes(x = as.numeric(Power),y=portfolio.cf), color="red") + guides(fill=FALSE)


## ---- fig.align='center', cache=TRUE, tidy=TRUE, dpi=500-----------------
ggplot(dataset, aes(x=CarAge)) + geom_bar()  + xlab("Age of the Car")


## ---- tidy=TRUE, results='hide'------------------------------------------
CarAge.summary = ddply(dataset, .(CarAge), summarize, totalExposure = sum(Exposure), Number.Observations = length(Exposure))
CarAge.summary

## ---- results='asis', warning=FALSE, echo=FALSE--------------------------
require(xtable)
print(xtable(CarAge.summary,  digits=c(0,0,2,0)), type = "html", include.rownames=FALSE)


## ---- fig.align='center', dpi=500, tidy=TRUE-----------------------------
ggplot(CarAge.summary, aes(x=CarAge, y=totalExposure)) + geom_bar(stat='identity') + ylab("Exposure in years")


## ---- fig.align='center', dpi=500, tidy=TRUE-----------------------------
ggplot(dataset[dataset$CarAge==0,], aes(x="Exposure", y=Exposure)) + geom_boxplot() +ggtitle("Exposure of new cars")


## ---- tidy=TRUE, results='hide'------------------------------------------
CarAge.summary = ddply(dataset, .(CarAge), summarize, totalExposure = sum(Exposure), Number.Observations = length(Exposure), Number.Claims = sum(ClaimNb), Obs.Claim.Freq = sum(ClaimNb)/sum(Exposure))
CarAge.summary

## ---- results='asis', warning=FALSE, echo=FALSE--------------------------
require(xtable)
print(xtable(CarAge.summary,  digits=c(0,1,2,0,0,5)), type = "html",include.rownames=FALSE)


## ---- fig.align='center', dpi=500, tidy=TRUE-----------------------------
ggplot(CarAge.summary, aes(x=CarAge, y=Obs.Claim.Freq)) + geom_point() + ylab("Observed Claim Frequency")+xlab("Age of the Car") +ylim(c(0,0.08))


## ---- fig.align='center', cache=TRUE, tidy=TRUE, dpi=500, results='hide'----
DriverAge.summary = ddply(dataset, .(DriverAge), summarize, totalExposure = sum(Exposure), Number.Observations = length(Exposure), Number.Claims = sum(ClaimNb), Obs.Claim.Freq = sum(ClaimNb)/sum(Exposure))
head(DriverAge.summary,9)


## ---- results='asis', warning=FALSE,echo=FALSE---------------------------
require(xtable)
print(xtable(head(DriverAge.summary,9), digits=c(0,1,2,0,0,5)), type = "html",include.rownames=FALSE)


## ---- fig.align='center', dpi=500, tidy=TRUE-----------------------------
ggplot(DriverAge.summary, aes(x=DriverAge, y=totalExposure)) + geom_bar(stat='identity', width=0.8) + ylab("Exposure in years")+xlab("Age of the Driver")


## ---- fig.align="center", dpi=500, tidy=TRUE-----------------------------
ggplot(DriverAge.summary, aes(x=DriverAge, y=Obs.Claim.Freq)) + geom_point()+ylab("Observed Claim Frequency") + xlab("Age of the Driver")


## ---- tidy=TRUE----------------------------------------------------------
levels(dataset$Brand)


## ---- echo=TRUE, tidy=TRUE, results='hide'-------------------------------
Brand.summary = ddply(dataset, .(Brand), summarize, totalExposure = sum(Exposure), Number.Observations = length(Exposure), Number.Claims = sum(ClaimNb), Obs.Claim.Freq = sum(ClaimNb)/sum(Exposure))
Brand.summary


## ---- results='asis', warning=FALSE, echo=FALSE--------------------------
require(xtable)
print(xtable(Brand.summary,  digits=c(0,1,2,0,0,5)), type = "html", include.rownames=FALSE)


## ---- fig.align='center', dpi=500, tidy=TRUE-----------------------------
require(ggplot2)
ggplot(Brand.summary, aes(x=reorder(Brand,totalExposure), y=totalExposure, fill=Brand)) +
  geom_bar(stat='identity') +
  coord_flip()+guides(fill=FALSE)+xlab("")+ylab("Exposure in years")


## ---- fig.align='center', dpi=500, tidy=TRUE-----------------------------
ggplot(Brand.summary, aes(x=reorder(Brand,Obs.Claim.Freq), y=Obs.Claim.Freq, fill=Brand)) +
  geom_bar(stat='identity') +
  coord_flip()+guides(fill=FALSE)+ ggtitle("Observed Claim Frequencies by Brand of the car")+xlab("")+ylab("Observed Claim Frequency")


## ---- echo=TRUE, cache=TRUE, tidy=TRUE-----------------------------------
levels(dataset$Gas)


## ---- echo=TRUE, fig.align='center', dpi=500, tidy=TRUE------------------
Gas.summary = ddply(dataset, .(Gas), summarize, totalExposure = sum(Exposure), Number.Observations = length(Exposure), Number.Claims = sum(ClaimNb), Obs.Claim.Freq = sum(ClaimNb)/sum(Exposure))
ggplot(Gas.summary, aes(x=Gas, y=totalExposure, fill=Gas)) + geom_bar(stat="identity") + guides(fill=FALSE)


## ---- fig.align='center', dpi=500, tidy=TRUE-----------------------------
ggplot(Gas.summary, aes(x=Gas, y=Obs.Claim.Freq, fill=Gas)) + geom_bar(stat="identity") + guides(fill=FALSE)


## ---- echo=TRUE, cache=TRUE, tidy=TRUE-----------------------------------
levels(dataset$Region)


## ---- tidy=TRUE, results='hide'------------------------------------------
Region.summary = ddply(dataset, .(Region), summarize, totalExposure = sum(Exposure), Number.Observations = length(Exposure), Number.Claims = sum(ClaimNb), Obs.Claim.Freq = sum(ClaimNb)/sum(Exposure))
Region.summary


## ---- results='asis', echo=FALSE-----------------------------------------
print(xtable(Region.summary, digits=c(0,1,2,0,0,5)), type="html", include.rownames=FALSE)


## ---- fig.align='center', dpi=500, tidy=TRUE-----------------------------
twoord.plot(1:10,Region.summary$totalExposure,1:10,Region.summary$Obs.Claim.Freq,xlab="Region",
rylim=c(0,0.1),type=c("bar","p"), xticklab = Region.summary$Region, ylab = "Exposure", rylab = "Observed Claim Frequency")


## ---- message=FALSE, fig.align='center', warning=FALSE, dpi=500, tidy=TRUE----
# Download shapefile from  http://www.diva-gis.org/gData
# Extract all the files from the zip files, in a directory called shapefiles in your working directory
area <- rgdal::readOGR("C:/Users/juerg/AktuarDataScience/Varia/2019_SSA/shapefiles/FRA_adm2.shp") # From http://www.diva-gis.org/gData
Region.summary$id = sapply(Region.summary$Region, substr, 2, 3)
area.points = fortify(area, region="ID_2") #Convert to data.frame
area.points = merge(area.points, Region.summary[,c("id","totalExposure","Obs.Claim.Freq")], by.x = "id", by.y = "id", all.x=TRUE)
area.points = area.points[order(area.points$order),] #Has to be ordered correctly to plot.
ggplot(area.points, aes(long, lat, group=group)) + ggtitle("Observed Claim Frequencies")+
  geom_polygon(aes(fill = area.points$Obs.Claim.Freq))+
  scale_fill_gradient(low = "green", high = "red", name="Obs. Claim Freq.", limits= c(0.061,0.085))+
xlab("Longitude") + ylab("Latitude")


## ---- fig.align='center', dpi=500, tidy=TRUE-----------------------------
ggplot(area.points, aes(long, lat, group=group)) + ggtitle("log Exposures in years")+
  geom_polygon(aes(fill = log(area.points$totalExposure)))+
  scale_fill_gradient(low = "blue", high = "red", name="log Exposure")+
xlab("Longitude") + ylab("Latitude")


## ---- fig.align='center', dpi=500, tidy=TRUE-----------------------------
summary(dataset$Density)
ggplot(dataset, aes(Density)) + geom_histogram(bins=200)


## ---- eval=FALSE, tidy=TRUE----------------------------------------------
## length(unique(dataset$Density))


## ---- tidy=TRUE, results='hide'------------------------------------------
Density.summary = ddply(dataset, .(Density), summarize, totalExposure = sum(Exposure), Number.Observations = length(Exposure), Number.Claims = sum(ClaimNb), Obs.Claim.Freq = sum(ClaimNb)/sum(Exposure))
head(Density.summary)


## ---- results='asis', echo=FALSE, fig.align='center'---------------------
print(xtable(head(Density.summary), digits=c(0,1,2,0,0,5)), type="html", include.rownames=FALSE)


## ---- fig.align='center', dpi=500, tidy=TRUE-----------------------------
ggplot(Density.summary, aes(x=Density, y=Obs.Claim.Freq)) + geom_point()


## ---- tidy=TRUE----------------------------------------------------------
dataset$DensityCAT = cut(dataset$Density, breaks = quantile(dataset$Density, probs = seq(from = 0, to = 1, by=0.1)),
                         include.lowest = TRUE)
table(dataset$DensityCAT)
levels(dataset$DensityCAT) <- LETTERS[1:10]


## ---- tidy=TRUE, results='hide'------------------------------------------
Density.summary = ddply(dataset, .(DensityCAT), summarize, totalExposure = sum(Exposure), Number.Observations = length(Exposure), Number.Claims = sum(ClaimNb), Obs.Claim.Freq = sum(ClaimNb)/sum(Exposure))
Density.summary


## ---- results='asis', echo=FALSE-----------------------------------------
print(xtable(Density.summary, digits=c(0,1,2,0,0,5)), type="html", include.rownames=FALSE)


## ---- fig.align='center', dpi=500, tidy=TRUE-----------------------------
twoord.plot(1:10,Density.summary$totalExposure,1:10,Density.summary$Obs.Claim.Freq,xlab="Density (categorized)", lylim=c(0,15000),
rylim=c(0,0.15),type=c("bar","p"), xticklab = Density.summary$Density, ylab = "Exposure", rylab = "Observed Claim Frequency", lytickpos=seq(0,15000,5000), rytickpos=seq(0,0.15,0.03))

