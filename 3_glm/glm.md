``` r
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
```

Load data
=========

``` r
## 1) If 'CASdatasets' package can be loaded, then as follows:
data("freMTPLfreq")
freMTPLfreq = subset(freMTPLfreq, Exposure <= 1 & Exposure >= 0 & CarAge <= 
    25)
# Subsample of the whole dataset

set.seed(85)
folds = createDataPartition(freMTPLfreq$ClaimNb, 0.5)
df_freMTPLfreq = freMTPLfreq[folds[[1]], ]
# save(df_freqMTPLfreq, file='../dataset.RData')

## 3) If not, then download the file 'freMTPLfreq.RData' from the GitHub
## repository and run the following: data_path <-
## 'C:/Users/juerg/AktuarDataScience/Varia/2019_SSA/'
## load(file=paste(data_path,'df_freMTPLfreq.RData',sep=''))
dataset <- df_freMTPLfreq
```

GLM
===

We are going to model the claim frequencies using a GLM. We will only consider the categorical variables in this part, as we will see later that other tools are available to treat the continuous variables without having to discretize them.

Let us first split out dataset in two parts: a training set and a testing set.

``` r
set.seed(21)
in_training = createDataPartition(df_freMTPLfreq$ClaimNb, times = 1, p = 0.8, 
    list = FALSE)
training_set = df_freMTPLfreq[in_training, ]
testing_set = df_freMTPLfreq[-in_training, ]
```

Intercept
---------

The main function is called *glm*. Let us run the function on our dataset.

``` r
m0 = glm(ClaimNb ~ offset(log(Exposure)), data = training_set, family = poisson())
summary(m0)
```

    ## 
    ## Call:
    ## glm(formula = ClaimNb ~ offset(log(Exposure)), family = poisson(), 
    ##     data = training_set)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.3740  -0.3740  -0.2645  -0.1496   6.5426  
    ## 
    ## Coefficients:
    ##             Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept) -2.66013    0.01246  -213.5   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for poisson family taken to be 1)
    ## 
    ##     Null deviance: 42075  on 164345  degrees of freedom
    ## Residual deviance: 42075  on 164345  degrees of freedom
    ## AIC: 54521
    ## 
    ## Number of Fisher Scoring iterations: 6

By default, the link function is the log (see help file *?poisson*).

We can find the average claim frequency of the portfolio. The average claim frequency is then given by *e**x**p*(*β*<sub>0</sub>) = *e**x**p*(−2.6601) = 0.0699.

``` r
exp(m0$coefficients)
```

All the variables
-----------------

In this whole session, we will only consider the discrete variables, namely *Power*, *Brand*, *Gas* and *Region*.

Let us include all these variables (without interactions) in the model.

``` r
m1 = glm(ClaimNb ~ offset(log(Exposure)) + Power + Gas + Brand + Region, data = training_set, 
    family = poisson(link = log))
summary(m1)
```

    ## 
    ## Call:
    ## glm(formula = ClaimNb ~ offset(log(Exposure)) + Power + Gas + 
    ##     Brand + Region, family = poisson(link = log), data = training_set)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.5204  -0.3495  -0.2644  -0.1469   6.6165  
    ## 
    ## Coefficients:
    ##                                           Estimate Std. Error z value
    ## (Intercept)                             -2.3471610  0.0764378 -30.707
    ## Powere                                   0.1508835  0.0443083   3.405
    ## Powerf                                   0.1467467  0.0435334   3.371
    ## Powerg                                   0.0375266  0.0438940   0.855
    ## Powerh                                   0.1179388  0.0617924   1.909
    ## Poweri                                   0.2179971  0.0682589   3.194
    ## Powerj                                   0.1804327  0.0701119   2.573
    ## Powerk                                   0.2750396  0.0896405   3.068
    ## Powerl                                   0.2253367  0.1294902   1.740
    ## Powerm                                   0.0733243  0.1995410   0.367
    ## Powern                                   0.2213301  0.2224475   0.995
    ## Powero                                   0.3557142  0.2122389   1.676
    ## GasRegular                              -0.0992720  0.0267054  -3.717
    ## BrandJapanese (except Nissan) or Korean -0.3356622  0.0713745  -4.703
    ## BrandMercedes, Chrysler or BMW          -0.0078477  0.0844304  -0.093
    ## BrandOpel, General Motors or Ford        0.0445679  0.0710981   0.627
    ## Brandother                               0.0360144  0.0941192   0.383
    ## BrandRenault, Nissan or Citroen         -0.1231281  0.0622897  -1.977
    ## BrandVolkswagen, Audi, Skoda or Seat     0.0214018  0.0731078   0.293
    ## RegionR23                               -0.4006216  0.1200341  -3.338
    ## RegionR24                               -0.3729908  0.0400816  -9.306
    ## RegionR25                               -0.2670039  0.0810248  -3.295
    ## RegionR31                                0.0003132  0.0593067   0.005
    ## RegionR52                               -0.2561023  0.0525417  -4.874
    ## RegionR53                               -0.3343147  0.0503412  -6.641
    ## RegionR54                               -0.3278368  0.0671222  -4.884
    ## RegionR72                               -0.2348811  0.0594539  -3.951
    ## RegionR74                               -0.0933579  0.1164587  -0.802
    ##                                         Pr(>|z|)    
    ## (Intercept)                              < 2e-16 ***
    ## Powere                                  0.000661 ***
    ## Powerf                                  0.000749 ***
    ## Powerg                                  0.392587    
    ## Powerh                                  0.056310 .  
    ## Poweri                                  0.001405 ** 
    ## Powerj                                  0.010068 *  
    ## Powerk                                  0.002153 ** 
    ## Powerl                                  0.081827 .  
    ## Powerm                                  0.713272    
    ## Powern                                  0.319747    
    ## Powero                                  0.093737 .  
    ## GasRegular                              0.000201 ***
    ## BrandJapanese (except Nissan) or Korean 2.57e-06 ***
    ## BrandMercedes, Chrysler or BMW          0.925944    
    ## BrandOpel, General Motors or Ford       0.530757    
    ## Brandother                              0.701982    
    ## BrandRenault, Nissan or Citroen         0.048076 *  
    ## BrandVolkswagen, Audi, Skoda or Seat    0.769718    
    ## RegionR23                               0.000845 ***
    ## RegionR24                                < 2e-16 ***
    ## RegionR25                               0.000983 ***
    ## RegionR31                               0.995787    
    ## RegionR52                               1.09e-06 ***
    ## RegionR53                               3.12e-11 ***
    ## RegionR54                               1.04e-06 ***
    ## RegionR72                               7.79e-05 ***
    ## RegionR74                               0.422761    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for poisson family taken to be 1)
    ## 
    ##     Null deviance: 42075  on 164345  degrees of freedom
    ## Residual deviance: 41855  on 164318  degrees of freedom
    ## AIC: 54355
    ## 
    ## Number of Fisher Scoring iterations: 6

Using the function *visreg* from the package of the same name, we can easily see plots related to the effect of the variables.

``` r
visreg(m1, type = "contrast", scale = "response")
```

<img src="glm_files/figure-markdown_github/unnamed-chunk-7-1.png" style="display: block; margin: auto;" /><img src="glm_files/figure-markdown_github/unnamed-chunk-7-2.png" style="display: block; margin: auto;" /><img src="glm_files/figure-markdown_github/unnamed-chunk-7-3.png" style="display: block; margin: auto;" /><img src="glm_files/figure-markdown_github/unnamed-chunk-7-4.png" style="display: block; margin: auto;" /><img src="glm_files/figure-markdown_github/unnamed-chunk-7-5.png" style="display: block; margin: auto;" />

We see some levels of some variables appear to be not significantly different from 0. Moreover, it could be that some levels appear to be significantly different from 0, but are not significantly different from each other and could be merged.

If we wish to perform a likelihood ratio test between the full model (*m*<sub>1</sub>) and the model without any explanatory variables (*m*<sub>0</sub>)

``` r
anova(m0, m1, test = "Chisq")
```

    ## Analysis of Deviance Table
    ## 
    ## Model 1: ClaimNb ~ offset(log(Exposure))
    ## Model 2: ClaimNb ~ offset(log(Exposure)) + Power + Gas + Brand + Region
    ##   Resid. Df Resid. Dev Df Deviance  Pr(>Chi)    
    ## 1    164345      42075                          
    ## 2    164318      41855 27   219.96 < 2.2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

We can try to merge some of the levels that appear to be not significantly different.

Variable : Brand
----------------

Let's start with the variable Brand.

``` r
training_set$Brand_merged = training_set$Brand
testing_set$Brand_merged = testing_set$Brand
levels(training_set$Brand_merged) <- list(A = c("Fiat", "Mercedes, Chrysler or BMW", 
    "Opel, General Motors or Ford", "other", "Volkswagen, Audi, Skoda or Seat"), 
    B = "Japanese (except Nissan) or Korean", C = "Renault, Nissan or Citroen")
levels(testing_set$Brand_merged) <- list(A = c("Fiat", "Mercedes, Chrysler or BMW", 
    "Opel, General Motors or Ford", "other", "Volkswagen, Audi, Skoda or Seat"), 
    B = "Japanese (except Nissan) or Korean", C = "Renault, Nissan or Citroen")
table(training_set$Brand_merged, useNA = "always")
```

    ## 
    ##     A     B     C  <NA> 
    ## 46232 31528 86586     0

Let us now estimate the new model with these merged levels...

``` r
m2 = glm(ClaimNb ~ offset(log(Exposure)) + Power + Gas + Brand_merged + Region, 
    data = training_set, family = poisson(link = log))
summary(m2)
```

    ## 
    ## Call:
    ## glm(formula = ClaimNb ~ offset(log(Exposure)) + Power + Gas + 
    ##     Brand_merged + Region, family = poisson(link = log), data = training_set)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.5267  -0.3497  -0.2643  -0.1469   6.6153  
    ## 
    ## Coefficients:
    ##                 Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)   -2.3247389  0.0548475 -42.385  < 2e-16 ***
    ## Powere         0.1539757  0.0440148   3.498 0.000468 ***
    ## Powerf         0.1475823  0.0433983   3.401 0.000672 ***
    ## Powerg         0.0365028  0.0436707   0.836 0.403232    
    ## Powerh         0.1149008  0.0614750   1.869 0.061614 .  
    ## Poweri         0.2143487  0.0675849   3.172 0.001516 ** 
    ## Powerj         0.1791992  0.0695211   2.578 0.009948 ** 
    ## Powerk         0.2705393  0.0888117   3.046 0.002317 ** 
    ## Powerl         0.2126344  0.1272279   1.671 0.094665 .  
    ## Powerm         0.0532458  0.1959535   0.272 0.785832    
    ## Powern         0.2096706  0.2212348   0.948 0.343268    
    ## Powero         0.3494104  0.2118029   1.650 0.099005 .  
    ## GasRegular    -0.0980757  0.0265820  -3.690 0.000225 ***
    ## Brand_mergedB -0.3579007  0.0446963  -8.007 1.17e-15 ***
    ## Brand_mergedC -0.1466244  0.0283091  -5.179 2.23e-07 ***
    ## RegionR23     -0.3997283  0.1200238  -3.330 0.000867 ***
    ## RegionR24     -0.3727639  0.0400776  -9.301  < 2e-16 ***
    ## RegionR25     -0.2674485  0.0810153  -3.301 0.000963 ***
    ## RegionR31      0.0009223  0.0592910   0.016 0.987588    
    ## RegionR52     -0.2557370  0.0525308  -4.868 1.13e-06 ***
    ## RegionR53     -0.3340678  0.0503252  -6.638 3.18e-11 ***
    ## RegionR54     -0.3279237  0.0671113  -4.886 1.03e-06 ***
    ## RegionR72     -0.2339320  0.0594362  -3.936 8.29e-05 ***
    ## RegionR74     -0.0929364  0.1164538  -0.798 0.424839    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for poisson family taken to be 1)
    ## 
    ##     Null deviance: 42075  on 164345  degrees of freedom
    ## Residual deviance: 41856  on 164322  degrees of freedom
    ## AIC: 54347
    ## 
    ## Number of Fisher Scoring iterations: 6

...and perform a likelihood ratio test to compare both models.

``` r
anova(m2, m1, test = "Chisq")
```

    ## Analysis of Deviance Table
    ## 
    ## Model 1: ClaimNb ~ offset(log(Exposure)) + Power + Gas + Brand_merged + 
    ##     Region
    ## Model 2: ClaimNb ~ offset(log(Exposure)) + Power + Gas + Brand + Region
    ##   Resid. Df Resid. Dev Df Deviance Pr(>Chi)
    ## 1    164322      41856                     
    ## 2    164318      41855  4  0.77812   0.9414

Variable : Power
----------------

Let us now look at the variable Power.

``` r
visreg(m2, xvar = "Power", type = "contrast", scale = "response")
```

<img src="glm_files/figure-markdown_github/unnamed-chunk-12-1.png" style="display: block; margin: auto;" />

``` r
training_set$Power_merged = training_set$Power
levels(training_set$Power_merged) = list(A = "d", B = c("e", "f", "g", "h"), 
    C = c("i", "j", "k", "l", "m", "n", "o"))
testing_set$Power_merged = testing_set$Power
levels(testing_set$Power_merged) = list(A = "d", B = c("e", "f", "g", "h"), 
    C = c("i", "j", "k", "l", "m", "n", "o"))
m3 = glm(ClaimNb ~ offset(log(Exposure)) + Power_merged + Gas + Brand_merged + 
    Region, data = training_set, family = poisson(link = log))
summary(m3)
```

    ## 
    ## Call:
    ## glm(formula = ClaimNb ~ offset(log(Exposure)) + Power_merged + 
    ##     Gas + Brand_merged + Region, family = poisson(link = log), 
    ##     data = training_set)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.4936  -0.3490  -0.2649  -0.1475   6.6179  
    ## 
    ## Coefficients:
    ##                Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)   -2.315787   0.054587 -42.424  < 2e-16 ***
    ## Power_mergedB  0.110237   0.037544   2.936 0.003322 ** 
    ## Power_mergedC  0.208648   0.048345   4.316 1.59e-05 ***
    ## GasRegular    -0.107512   0.025986  -4.137 3.51e-05 ***
    ## Brand_mergedB -0.362762   0.044314  -8.186 2.70e-16 ***
    ## Brand_mergedC -0.145596   0.028041  -5.192 2.08e-07 ***
    ## RegionR23     -0.401766   0.120011  -3.348 0.000815 ***
    ## RegionR24     -0.375216   0.040045  -9.370  < 2e-16 ***
    ## RegionR25     -0.270028   0.080995  -3.334 0.000856 ***
    ## RegionR31      0.001981   0.059234   0.033 0.973317    
    ## RegionR52     -0.258219   0.052500  -4.918 8.72e-07 ***
    ## RegionR53     -0.334430   0.050311  -6.647 2.99e-11 ***
    ## RegionR54     -0.331231   0.067091  -4.937 7.93e-07 ***
    ## RegionR72     -0.233870   0.059414  -3.936 8.28e-05 ***
    ## RegionR74     -0.100369   0.116421  -0.862 0.388620    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for poisson family taken to be 1)
    ## 
    ##     Null deviance: 42075  on 164345  degrees of freedom
    ## Residual deviance: 41870  on 164331  degrees of freedom
    ## AIC: 54343
    ## 
    ## Number of Fisher Scoring iterations: 6

``` r
anova(m3, m2, test = "Chisq")
```

    ## Analysis of Deviance Table
    ## 
    ## Model 1: ClaimNb ~ offset(log(Exposure)) + Power_merged + Gas + Brand_merged + 
    ##     Region
    ## Model 2: ClaimNb ~ offset(log(Exposure)) + Power + Gas + Brand_merged + 
    ##     Region
    ##   Resid. Df Resid. Dev Df Deviance Pr(>Chi)
    ## 1    164331      41870                     
    ## 2    164322      41856  9   13.832   0.1284

Variable : Region
-----------------

Finally, let's consider the variable Region.

``` r
visreg(m3, xvar = "Region", type = "contrast", scale = "response")
```

<img src="glm_files/figure-markdown_github/unnamed-chunk-14-1.png" style="display: block; margin: auto;" />

``` r
training_set$Region_merged = training_set$Region
levels(training_set$Region_merged)[c(1, 5, 10)] = "R11-31-74"
testing_set$Region_merged = testing_set$Region
levels(testing_set$Region_merged)[c(1, 5, 10)] = "R11-31-74"
m4 = glm(ClaimNb ~ offset(log(Exposure)) + Power_merged + Gas + Brand_merged + 
    Region_merged, data = training_set, family = poisson(link = log))
summary(m4)
```

    ## 
    ## Call:
    ## glm(formula = ClaimNb ~ offset(log(Exposure)) + Power_merged + 
    ##     Gas + Brand_merged + Region_merged, family = poisson(link = log), 
    ##     data = training_set)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.4917  -0.3490  -0.2648  -0.1475   6.6214  
    ## 
    ## Coefficients:
    ##                  Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)      -2.32160    0.04987 -46.550  < 2e-16 ***
    ## Power_mergedB     0.11027    0.03752   2.939 0.003294 ** 
    ## Power_mergedC     0.20875    0.04830   4.322 1.55e-05 ***
    ## GasRegular       -0.10695    0.02589  -4.132 3.60e-05 ***
    ## Brand_mergedB    -0.36143    0.04401  -8.212  < 2e-16 ***
    ## Brand_mergedC    -0.14567    0.02804  -5.195 2.05e-07 ***
    ## Region_mergedR23 -0.39643    0.11847  -3.346 0.000819 ***
    ## Region_mergedR24 -0.36969    0.03478 -10.629  < 2e-16 ***
    ## Region_mergedR25 -0.26462    0.07863  -3.365 0.000765 ***
    ## Region_mergedR52 -0.25280    0.04876  -5.184 2.17e-07 ***
    ## Region_mergedR53 -0.32894    0.04629  -7.106 1.19e-12 ***
    ## Region_mergedR54 -0.32579    0.06418  -5.076 3.85e-07 ***
    ## Region_mergedR72 -0.22862    0.05634  -4.058 4.96e-05 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for poisson family taken to be 1)
    ## 
    ##     Null deviance: 42075  on 164345  degrees of freedom
    ## Residual deviance: 41871  on 164333  degrees of freedom
    ## AIC: 54340
    ## 
    ## Number of Fisher Scoring iterations: 6

``` r
anova(m4, m3, test = "Chisq")
```

    ## Analysis of Deviance Table
    ## 
    ## Model 1: ClaimNb ~ offset(log(Exposure)) + Power_merged + Gas + Brand_merged + 
    ##     Region_merged
    ## Model 2: ClaimNb ~ offset(log(Exposure)) + Power_merged + Gas + Brand_merged + 
    ##     Region
    ##   Resid. Df Resid. Dev Df Deviance Pr(>Chi)
    ## 1    164333      41871                     
    ## 2    164331      41870  2  0.79484   0.6721

Interactions ?
--------------

Let's see if we can add some interactions.

``` r
m5.1 = glm(ClaimNb ~ offset(log(Exposure)) + Power_merged * Gas + Brand_merged + 
    Region_merged, data = training_set, family = poisson(link = log))
summary(m5.1)
```

    ## 
    ## Call:
    ## glm(formula = ClaimNb ~ offset(log(Exposure)) + Power_merged * 
    ##     Gas + Brand_merged + Region_merged, family = poisson(link = log), 
    ##     data = training_set)
    ## 
    ## Deviance Residuals: 
    ##     Min       1Q   Median       3Q      Max  
    ## -0.4823  -0.3484  -0.2648  -0.1471   6.6190  
    ## 
    ## Coefficients:
    ##                          Estimate Std. Error z value Pr(>|z|)    
    ## (Intercept)              -2.33108    0.07547 -30.885  < 2e-16 ***
    ## Power_mergedB             0.12541    0.07266   1.726 0.084371 .  
    ## Power_mergedC             0.17973    0.08848   2.031 0.042233 *  
    ## GasRegular               -0.09455    0.07958  -1.188 0.234782    
    ## Brand_mergedB            -0.36028    0.04403  -8.183 2.77e-16 ***
    ## Brand_mergedC            -0.14777    0.02814  -5.252 1.51e-07 ***
    ## Region_mergedR23         -0.39508    0.11849  -3.334 0.000855 ***
    ## Region_mergedR24         -0.36836    0.03483 -10.577  < 2e-16 ***
    ## Region_mergedR25         -0.26272    0.07867  -3.339 0.000840 ***
    ## Region_mergedR52         -0.25169    0.04880  -5.158 2.50e-07 ***
    ## Region_mergedR53         -0.32789    0.04632  -7.079 1.45e-12 ***
    ## Region_mergedR54         -0.32447    0.06421  -5.053 4.34e-07 ***
    ## Region_mergedR72         -0.22814    0.05636  -4.048 5.16e-05 ***
    ## Power_mergedB:GasRegular -0.02584    0.08507  -0.304 0.761282    
    ## Power_mergedC:GasRegular  0.05193    0.10581   0.491 0.623596    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for poisson family taken to be 1)
    ## 
    ##     Null deviance: 42075  on 164345  degrees of freedom
    ## Residual deviance: 41870  on 164331  degrees of freedom
    ## AIC: 54343
    ## 
    ## Number of Fisher Scoring iterations: 6

``` r
anova(m4, m5.1, test = "Chisq")
```

    ## Analysis of Deviance Table
    ## 
    ## Model 1: ClaimNb ~ offset(log(Exposure)) + Power_merged + Gas + Brand_merged + 
    ##     Region_merged
    ## Model 2: ClaimNb ~ offset(log(Exposure)) + Power_merged * Gas + Brand_merged + 
    ##     Region_merged
    ##   Resid. Df Resid. Dev Df Deviance Pr(>Chi)
    ## 1    164333      41871                     
    ## 2    164331      41870  2   1.0732   0.5847

Let's try to find other interactions

-   with Power\_merged.

``` r
m5.2 = glm(ClaimNb ~ offset(log(Exposure)) + Power_merged + Gas + Power_merged * 
    Brand_merged + Gas + Region_merged, data = training_set, family = poisson(link = log))
anova(m4, m5.2, test = "Chisq")
```

    ## Analysis of Deviance Table
    ## 
    ## Model 1: ClaimNb ~ offset(log(Exposure)) + Power_merged + Gas + Brand_merged + 
    ##     Region_merged
    ## Model 2: ClaimNb ~ offset(log(Exposure)) + Power_merged + Gas + Power_merged * 
    ##     Brand_merged + Gas + Region_merged
    ##   Resid. Df Resid. Dev Df Deviance Pr(>Chi)
    ## 1    164333      41871                     
    ## 2    164329      41864  4   6.6259    0.157

``` r
m5.3 = glm(ClaimNb ~ offset(log(Exposure)) + Power_merged + Gas + Brand_merged + 
    Gas + Power_merged * Region_merged, data = training_set, family = poisson(link = log))
anova(m4, m5.3, test = "Chisq")
```

    ## Analysis of Deviance Table
    ## 
    ## Model 1: ClaimNb ~ offset(log(Exposure)) + Power_merged + Gas + Brand_merged + 
    ##     Region_merged
    ## Model 2: ClaimNb ~ offset(log(Exposure)) + Power_merged + Gas + Brand_merged + 
    ##     Gas + Power_merged * Region_merged
    ##   Resid. Df Resid. Dev Df Deviance Pr(>Chi)  
    ## 1    164333      41871                       
    ## 2    164319      41843 14   27.957  0.01442 *
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

We will now keep the interaction between Power\_merged and Region\_merged, and try other possibilities.

-   with Gas

``` r
m5.4 = glm(ClaimNb ~ offset(log(Exposure)) + Power_merged + Brand_merged * Gas + 
    Power_merged * Region_merged, data = training_set, family = poisson(link = log))
anova(m5.3, m5.4, test = "Chisq")
```

    ## Analysis of Deviance Table
    ## 
    ## Model 1: ClaimNb ~ offset(log(Exposure)) + Power_merged + Gas + Brand_merged + 
    ##     Gas + Power_merged * Region_merged
    ## Model 2: ClaimNb ~ offset(log(Exposure)) + Power_merged + Brand_merged * 
    ##     Gas + Power_merged * Region_merged
    ##   Resid. Df Resid. Dev Df Deviance Pr(>Chi)
    ## 1    164319      41843                     
    ## 2    164317      41842  2  0.48166    0.786

``` r
m5.5 = glm(ClaimNb ~ offset(log(Exposure)) + Power_merged * Region_merged + 
    Gas + Brand_merged + Gas + Region_merged * Gas, data = training_set, family = poisson(link = log))
anova(m5.3, m5.5, test = "Chisq")
```

    ## Analysis of Deviance Table
    ## 
    ## Model 1: ClaimNb ~ offset(log(Exposure)) + Power_merged + Gas + Brand_merged + 
    ##     Gas + Power_merged * Region_merged
    ## Model 2: ClaimNb ~ offset(log(Exposure)) + Power_merged * Region_merged + 
    ##     Gas + Brand_merged + Gas + Region_merged * Gas
    ##   Resid. Df Resid. Dev Df Deviance Pr(>Chi)
    ## 1    164319      41843                     
    ## 2    164312      41834  7   9.0177   0.2514

-   with Brand\_merged

``` r
m5.6 = glm(ClaimNb ~ offset(log(Exposure)) + Power_merged * Region_merged + 
    Brand_merged + Gas + Region_merged * Brand_merged, data = training_set, 
    family = poisson(link = log))
anova(m5.3, m5.6, test = "Chisq")
```

    ## Analysis of Deviance Table
    ## 
    ## Model 1: ClaimNb ~ offset(log(Exposure)) + Power_merged + Gas + Brand_merged + 
    ##     Gas + Power_merged * Region_merged
    ## Model 2: ClaimNb ~ offset(log(Exposure)) + Power_merged * Region_merged + 
    ##     Brand_merged + Gas + Region_merged * Brand_merged
    ##   Resid. Df Resid. Dev Df Deviance Pr(>Chi)  
    ## 1    164319      41843                       
    ## 2    164305      41820 14    22.59  0.06727 .
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

This is in the 'gray zone'. We will keep the interaction.

We can visualize the interaction between Power\_merged and Region\_merged

``` r
visreg(m5.6, xvar = "Power_merged", by = "Region_merged", scale = "response", 
    type = "contrast")
```

<img src="glm_files/figure-markdown_github/unnamed-chunk-20-1.png" style="display: block; margin: auto;" />

and between Region\_merged and Brand\_merged

``` r
visreg(m5.6, xvar = "Brand_merged", by = "Region_merged", scale = "response", 
    type = "contrast")
```

<img src="glm_files/figure-markdown_github/unnamed-chunk-21-1.png" style="display: block; margin: auto;" />

Predictive Power of the models
------------------------------

Let us now check the predictive power of the various models that we have used up to now. We can use the testing\_set that we have created from the beginning. We can use for instance, the Poisson deviance as a measure (that we wish to minimize).

``` r
results = rep(NA, 7)
results[1] = 2 * (sum(dpois(x = testing_set$ClaimNb, lambda = testing_set$ClaimNb, 
    log = TRUE)) - sum(dpois(x = testing_set$ClaimNb, lambda = predict(m0, newdata = testing_set, 
    type = "response"), log = TRUE)))
results[2] = 2 * (sum(dpois(x = testing_set$ClaimNb, lambda = testing_set$ClaimNb, 
    log = TRUE)) - sum(dpois(x = testing_set$ClaimNb, lambda = predict(m1, newdata = testing_set, 
    type = "response"), log = TRUE)))
results[3] = 2 * (sum(dpois(x = testing_set$ClaimNb, lambda = testing_set$ClaimNb, 
    log = TRUE)) - sum(dpois(x = testing_set$ClaimNb, lambda = predict(m2, newdata = testing_set, 
    type = "response"), log = TRUE)))
results[4] = 2 * (sum(dpois(x = testing_set$ClaimNb, lambda = testing_set$ClaimNb, 
    log = TRUE)) - sum(dpois(x = testing_set$ClaimNb, lambda = predict(m3, newdata = testing_set, 
    type = "response"), log = TRUE)))
results[5] = 2 * (sum(dpois(x = testing_set$ClaimNb, lambda = testing_set$ClaimNb, 
    log = TRUE)) - sum(dpois(x = testing_set$ClaimNb, lambda = predict(m4, newdata = testing_set, 
    type = "response"), log = TRUE)))
results[6] = 2 * (sum(dpois(x = testing_set$ClaimNb, lambda = testing_set$ClaimNb, 
    log = TRUE)) - sum(dpois(x = testing_set$ClaimNb, lambda = predict(m5.3, 
    newdata = testing_set, type = "response"), log = TRUE)))
results[7] = 2 * (sum(dpois(x = testing_set$ClaimNb, lambda = testing_set$ClaimNb, 
    log = TRUE)) - sum(dpois(x = testing_set$ClaimNb, lambda = predict(m5.6, 
    newdata = testing_set, type = "response"), log = TRUE)))
results
```

    ## [1] 10427.02 10415.78 10415.20 10409.17 10410.26 10413.54 10403.56
