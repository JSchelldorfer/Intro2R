# A Short Introduction to R for Actuaries, Bratislava 2019

All the material of the training is available here. The course closely follows other courses and teaching material. More details are given below.

### Required Software
- R (https://cloud.r-project.org/bin/windows/base/ )
- RStudio ( https://www.rstudio.com/products/rstudio/download/#download )
 
 Please install these two software before the training.
 
 ### Required Packages
 After installing the required software, please run the following commands to install the additional required packages:
 
 ``` r
if (!require("sp")) install.packages("sp")
if (!require("xts")) install.packages("xts")
if (!require("CASdatasets")) install.packages("CASdatasets", repos = "http://cas.uqam.ca/pub/R/", type="source")
require("CASdatasets")
```

If the installation succeeded, the following lines should load a dataset and show the first six lines.

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
The training material is mainly based on the following literature:
- "Insurance Analytics, A Primer", 31th International Summer School of the Swiss Association of Actuaries (2018)
  (https://github.com/fpechon/SummerSchool)
- "A Tutorial Introduction to R" by Aaron A. King, Stu Field, Ben Bolker, Steve Ellner (http://kingaa.github.io/R_Tutorial/)
- "Introduction to R" by Jonathan Cornelissen (https://github.com/datacamp/courses-intro-to-r)
- "An Introduction to R" by W. N. Venables, D. M. Smithand the R Core Team (https://cran.r-project.org/doc/manuals/r-release/R-intro.pdf)
- "Introduction to Data Science with R", a video course by RStudio and O'Reilly Media (https://github.com/rstudio/Intro)
- "Case Study: French Motor Third-Party Liability Claims" from A. Noll, R. Salzmann and M.V. Wüthrich (https://www.actuarialdatascience.org/ADS-Tutorials/)
- "Data Analytics for Non-Life Insurance Pricing" by M.V. Wüthrich and Ch. Buser (https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2870308)
