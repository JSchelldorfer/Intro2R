## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ------------------------------------------------------------------------
# Calculate 3 + 4
sqrt(2)
x <- 3
y <- x^2
x + y
sin(2*pi)


## ------------------------------------------------------------------------
c(1, 5, 80)
2:11
a <- c(1, 6, 10, 22, 7, 13)
mean(a)
sum(a)


## ------------------------------------------------------------------------
matrix()
m <- matrix(1:6, nrow=3, ncol=2, byrow = TRUE)
m


## ------------------------------------------------------------------------
data.frame()
df <- data.frame(Name = c("I","You","He"),Gender = as.factor(c(0,1,0)), Age = c(21,47,33))
df


## ------------------------------------------------------------------------
temp_a <- 3 * (4 + 2)
temp_b <- temp_a + 2.5


## ------------------------------------------------------------------------
temp_a


## ------------------------------------------------------------------------
mean(c(temp_a,temp_b))
mn <- mean(c(temp_a,temp_b))


## ------------------------------------------------------------------------
temp_a <- 3 * (4 + 2)


## ------------------------------------------------------------------------
temp_a <- temp_b^2
temp_a


## ------------------------------------------------------------------------
# ?foo
?lm


## ------------------------------------------------------------------------
library(MASS)
#library(CASdatasets)
#library(insuranceData)


## ------------------------------------------------------------------------
data("Insurance")
?Insurance
head(Insurance)


## ------------------------------------------------------------------------
data_path <- "C:/Users/juerg/AktuarDataScience/Varia/2019_SSA/"
df <- read.table(paste(data_path,"dataCar.csv",sep=""), header = TRUE,sep=",")
# ?read.csv and many other specific loading packages available


## ------------------------------------------------------------------------
getwd()  ## print the current working directory
#setwd("yourpath")


## ------------------------------------------------------------------------
data_path <- "C:/Users/juerg/AktuarDataScience/Varia/2019_SSA/"
df <- read.table(paste(data_path,"dataCar.csv",sep=""), header = TRUE,sep=",")
str(df)


## ------------------------------------------------------------------------
#write.table(df, file = "xy.txt", sep = " ")


## ------------------------------------------------------------------------
str(Insurance)


## ------------------------------------------------------------------------
Age <- Insurance$Age
str(Age)


## ------------------------------------------------------------------------
Insurance[ , ]
c(1, 3, 7)
1:10
Insurance[1:10 , ]
Insurance[-c( 1, 3, 7), ] # negative indices are excluded> d.sport[ , 2:3]
Insurance[c(1, 3, 6), 2:3]


## ------------------------------------------------------------------------
mean(Insurance$Claims)
quantile(Insurance$Claims)
quantile(Insurance$Claims, probs = c(0.75, 0.9))


## ------------------------------------------------------------------------
mean(x = Insurance$Claims, na.rm = TRUE)


## ------------------------------------------------------------------------
mean(Insurance$Claims, ,TRUE)


## ------------------------------------------------------------------------
#install.packages("MASS") # install onto computer once
require(MASS) # for every R session.
library(MASS)

