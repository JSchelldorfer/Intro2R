# A Short Introduction to R for Actuaries, Bratislava 2019

All the material of the training is available here on GitHub. The course closely follows other courses and teaching material listed below.

### Required Software
In order to make best use of the training, please bring a laptop and install the following software on your laptop **before** the training (there is no time during the training).
- R (https://cloud.r-project.org/bin/windows/base/)
- RStudio ( https://www.rstudio.com/products/rstudio/download/#download)

It can be that you can not install the software on your company laptop, then bring your private laptop with you.

However, you can still follow the training without the software installed. The material is provided as html file as well.
 
 
### Required Packages
After installing the required software, please run the following commands to install the specific packages used during the training. (It is known that the "CASdatasets" package can sometimes not be installed. No problem, we provide you with the required data/code separately on this GitHub repository).
 
 ``` r
if (!require("MASS")) install.packages("MASS")
if (!require("tidyverse")) install.packages("tidyverse")
if (!require("caret")) install.packages("caret")
if (!require("mgcv")) install.packages("mgcv")
if (!require("plyr")) install.packages("plyr")
if (!require("gridExtra")) install.packages("gridExtra")
if (!require("visreg")) install.packages("visreg")
if (!require("plotrix")) install.packages("plotrix")
if (!require("rgeos")) install.packages("rgeos", type="source")
if (!require("rgdal")) install.packages("rgdal", type="source")
if (!require("xtable")) install.packages("xtable")
if (!require("maptools")) install.packages("maptools")
if (!require("CASdatasets")) install.packages("CASdatasets", repos = "http://cas.uqam.ca/pub/R/", type="source")
```

If the installation succeeded, the following lines load the packages.

 ``` r
library("MASS")
library("tidyverse")
library("mgcv")
library("caret")
library("gridExtra")
library("plyr")
library("visreg")
library("plotrix")
library("rgdal")
library("rgeos")
library("xtable")
library("maptools")
library("CASdatasets")
```

If the installation and loading succeeded, the following lines should load a dataset and show the first six lines.

``` r
data("freMTPLfreq")
head(freMTPLfreq)
```

    ##   PolicyID ClaimNb Exposure Power CarAge DriverAge
    ## 1        1       0     0.09     g      0        46
    ## 2        2       0     0.84     g      0        46
    ## 3        3       0     0.52     f      2        38
    ## 4        4       0     0.45     f      2        38
    ## 5        5       0     0.15     g      0        41
    ## 6        6       0     0.75     g      0        41
    ##                                Brand     Gas Region Density
    ## 1 Japanese (except Nissan) or Korean  Diesel    R72      76
    ## 2 Japanese (except Nissan) or Korean  Diesel    R72      76
    ## 3 Japanese (except Nissan) or Korean Regular    R31    3003
    ## 4 Japanese (except Nissan) or Korean Regular    R31    3003
    ## 5 Japanese (except Nissan) or Korean  Diesel    R52      60
    ## 6 Japanese (except Nissan) or Korean  Diesel    R52      60

 
### References
The training material is based on (and closely follows) the following literature:
- "Insurance Analytics, A Primer", 31th International Summer School of the Swiss Association of Actuaries (2018)
  (https://github.com/fpechon/SummerSchool)
- "Data Analytics for Non-Life Insurance Pricing" by M.V. Wüthrich and Ch. Buser (https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2870308)
- "Introduction to R", Statistical Consulting Group, Seminar für Statistik (SfS), ETH Zürich (ftp://ess.r-project.org/users/sfs/RKurs/R.Intro/slides.pdf)
- "An Introduction to R" by W. N. Venables, D. M. Smithand the R Core Team (https://cran.r-project.org/doc/manuals/r-release/R-intro.pdf)
- "A Tutorial Introduction to R" by Aaron A. King, Stu Field, Ben Bolker, Steve Ellner (http://kingaa.github.io/R_Tutorial/)
- "Introduction to R" by Jonathan Cornelissen (https://github.com/datacamp/courses-intro-to-r)
- "Introduction to Data Science with R", a video course by RStudio and O'Reilly Media (https://github.com/rstudio/Intro)
- "CASdatasets Package Vignette", Reference Manual (http://cas.uqam.ca/)
- "Computational Actuarial Science with R", A. Charpentier, CRC Press
- "Case Study: French Motor Third-Party Liability Claims" from A. Noll, R. Salzmann and M.V. Wüthrich (https://www.actuarialdatascience.org/ADS-Tutorials/)
- "Actuarial Data Science", Swiss Association of Actuaries, https://www.actuarialdatascience.org

