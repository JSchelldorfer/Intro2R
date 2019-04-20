1 - What is R?
--------------

R is a computing environment that combines:

-   a programming language called S, developed by John Chambers at Bell Labs, that implements the idea of programming with data (Chambers 1998),

-   an extensive set of functions for classical and modern statistical data analysis and modeling,

-   powerful numerical analysis tools for linear algebra, differential equations, and stochastics,

-   graphics functions for visualizing data and model output,

-   a modular and extensible structure that supports a vast array of optional **add-on packages**, and

-   extensive help and documentation facilities.

-   **free** and **open source**

-   widely usedboth in academia and industry

-   teaser: <http://shiny.rstudio.com/gallery>

R is an open source software project, available for free download (R Core Team 2014a). Originally a research project in statistical computing (Ihaka and Gentleman 1996), it is now managed by a development team that includes a number of well-regarded statisticians, and is widely used by statistical researchers and working scientists as a platform for making new methods available to users.

R has been developed by statisticians and is hence very **convenient for actuaries**.

2 - What is RStudio?
--------------------

Rtudio (<https://www.rstudio.com/>) is an integrated Development Environment (IDE) for R:

-   like Microsoft Word, Excel, etc.
-   built to help you write R code, run R code, and analyze data with R
-   text editor, latex integration, debugging tool, version control
-   Easy reporting via RShiny

To work with RStudio is one option to work with R. Other options are using Jupyter Notebooks (<https://jupyter.org/>).

RStudio consists of four different panes, each keeps track of separate information.

-   R Console
-   R Scipt
-   Plot
-   Help files

See a short video on <https://www.rstudio.com/products/RStudio/#Desktop>

3 - Calculations
----------------

### R as a simple caclulator

``` r
# Calculate 3 + 4
sqrt(2)
```

    ## [1] 1.414214

``` r
x <- 3
y <- x^2
x + y
```

    ## [1] 12

``` r
sin(2*pi)
```

    ## [1] -2.449213e-16

### Creating vectors

``` r
c(1, 5, 80)
```

    ## [1]  1  5 80

``` r
2:11
```

    ##  [1]  2  3  4  5  6  7  8  9 10 11

``` r
a <- c(1, 6, 10, 22, 7, 13)
mean(a)
```

    ## [1] 9.833333

``` r
sum(a)
```

    ## [1] 59

### Creating matrices and data frames

``` r
matrix()
```

    ##      [,1]
    ## [1,]   NA

``` r
m <- matrix(1:6, nrow=3, ncol=2, byrow = TRUE)
m
```

    ##      [,1] [,2]
    ## [1,]    1    2
    ## [2,]    3    4
    ## [3,]    5    6

``` r
data.frame()
```

    ## data frame with 0 columns and 0 rows

``` r
df <- data.frame(Name = c("I","You","He"),Gender = as.factor(c(0,1,0)), Age = c(21,47,33))
df
```

    ##   Name Gender Age
    ## 1    I      0  21
    ## 2  You      1  47
    ## 3   He      0  33

### An **R statement** may consist of...

-   an asignment stores the result of the calculation under temp\_a and temp\_b

``` r
temp_a <- 3 * (4 + 2)
temp_b <- temp_a + 2.5
```

-   a name of an object: display object

``` r
temp_a
```

    ## [1] 18

-   a call to a function: numerical or graphical result

``` r
mean(c(temp_a,temp_b))
```

    ## [1] 19.25

``` r
mn <- mean(c(temp_a,temp_b))
```

A function is called by its name followed by ().

### Assignment and Workspace

-   Everything in R is an object and has a certain name like temp\_a, mean, mn.
-   R stores objects in your workspace

``` r
temp_a <- 3 * (4 + 2)
```

-   ATTENTION: Overwriting an object in R throughs no warning

``` r
temp_a <- temp_b^2
temp_a
```

    ## [1] 420.25

4 - Where to find help?
-----------------------

-   Help about any function

``` r
# ?foo
?lm
```

    ## starting httpd help server ... done

-   If you have any question, google 'how do I...with R'.
-   huge community
-   already asked by somebody else
-   Very useful and helpful Q&A website: <http://stackexchange.com/Cheat>
-   Sheet for Base R <https://www.rstudio.com/resources/cheatsheets/>
-   R Reference Card <https://cran.r-project.org/doc/contrib/Baggott-refcard-v2.pdf>
-   **Learning by doing** is particularly true for programming

5 - Data Import and Export
--------------------------

How do we get our data into R?

### Loading data from R (for training)

There are several packages containing claims data for Non-Life insurance.

``` r
library(MASS)
#library(CASdatasets)
#library(insuranceData)
```

For example, laod the data "Insurance"" from the MASS package:

``` r
data("Insurance")
?Insurance
head(Insurance)
```

    ##   District  Group   Age Holders Claims
    ## 1        1    <1l   <25     197     38
    ## 2        1    <1l 25-29     264     35
    ## 3        1    <1l 30-35     246     20
    ## 4        1    <1l   >35    1680    156
    ## 5        1 1-1.5l   <25     284     63
    ## 6        1 1-1.5l 25-29     536     84

### Loading data from file

Often, you have your data as a .csv file available. Chek *?read.table* for more information about this function.

``` r
data_path <- "C:/Users/juerg/AktuarDataScience/Varia/2019_SSA/"
df <- read.table(paste(data_path,"dataCar.csv",sep=""), header = TRUE,sep=",")
# ?read.csv and many other specific loading packages available
```

Some useful functions to correctly load/save the data.

Let's set the working directory - the folder from which to operate (e.g.,save and load from). Use:

``` r
getwd()  ## print the current working directory
```

    ## [1] "C:/Users/juerg/AktuarDataScience/Varia/2019_SSA"

``` r
#setwd("yourpath")
```

Or alternatively in RStudio use 'Session -&gt; Set Working Directory -&gt; Choose Directory...'

Importing data in R is easy. Different ways depending on the format (csv, txt, xlsx, etc.). Alternative: use the 'Import Dataset' tool in RStudio (upper-rightpanel)

``` r
data_path <- "C:/Users/juerg/AktuarDataScience/Varia/2019_SSA/"
df <- read.table(paste(data_path,"dataCar.csv",sep=""), header = TRUE,sep=",")
str(df)
```

    ## 'data.frame':    67856 obs. of  12 variables:
    ##  $ X        : int  1 2 3 4 5 6 7 8 9 10 ...
    ##  $ veh_value: num  1.06 1.03 3.26 4.14 0.72 2.01 1.6 1.47 0.52 0.38 ...
    ##  $ exposure : num  0.304 0.649 0.569 0.318 0.649 ...
    ##  $ clm      : int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ numclaims: int  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ claimcst0: num  0 0 0 0 0 0 0 0 0 0 ...
    ##  $ veh_body : Factor w/ 13 levels "BUS","CONVT",..: 4 4 13 11 4 5 8 4 4 4 ...
    ##  $ veh_age  : int  3 2 2 2 4 3 3 2 4 4 ...
    ##  $ gender   : Factor w/ 2 levels "F","M": 1 1 1 1 1 2 2 2 1 1 ...
    ##  $ area     : Factor w/ 6 levels "A","B","C","D",..: 3 1 5 4 3 3 1 2 1 2 ...
    ##  $ agecat   : int  2 4 2 2 2 4 4 6 3 4 ...
    ##  $ X_OBSTAT_: Factor w/ 1 level "01101    0    0    0": 1 1 1 1 1 1 1 1 1 1 ...

To save or write data to a file:

``` r
#write.table(df, file = "xy.txt", sep = " ")
```

where x is the data object to be stored an xy.txt.

Excel-files: Use CSV \* &gt; write.csv(...) \* &gt; write.csv2(...)

6 - R Objects
-------------

Everything in R is an object, for example \* data frame: most essential data structure in R

``` r
str(Insurance)
```

    ## 'data.frame':    64 obs. of  5 variables:
    ##  $ District: Factor w/ 4 levels "1","2","3","4": 1 1 1 1 1 1 1 1 1 1 ...
    ##  $ Group   : Ord.factor w/ 4 levels "<1l"<"1-1.5l"<..: 1 1 1 1 2 2 2 2 3 3 ...
    ##  $ Age     : Ord.factor w/ 4 levels "<25"<"25-29"<..: 1 2 3 4 1 2 3 4 1 2 ...
    ##  $ Holders : int  197 264 246 1680 284 536 696 3582 133 286 ...
    ##  $ Claims  : int  38 35 20 156 63 84 89 400 19 52 ...

-   vector, e.g. a column of the data set Insurance

``` r
Age <- Insurance$Age
str(Age)
```

    ##  Ord.factor w/ 4 levels "<25"<"25-29"<..: 1 2 3 4 1 2 3 4 1 2 ...

Goal is to look at or use a part of your object. To access only part of an object, use\[ \]: \* for vectors: myvector\[x\] \* for two-dimensional objects, e.g. data frames or matrices: mydata.frame\[x, y\] Specify the indices by a vector (e.g.c(1, 2, 6)) and separate the indices of different dimensions by commas.

Let’s play around with the indexing of a data frame: two-dimensionalobject!

``` r
Insurance[ , ]
```

    ##    District  Group   Age Holders Claims
    ## 1         1    <1l   <25     197     38
    ## 2         1    <1l 25-29     264     35
    ## 3         1    <1l 30-35     246     20
    ## 4         1    <1l   >35    1680    156
    ## 5         1 1-1.5l   <25     284     63
    ## 6         1 1-1.5l 25-29     536     84
    ## 7         1 1-1.5l 30-35     696     89
    ## 8         1 1-1.5l   >35    3582    400
    ## 9         1 1.5-2l   <25     133     19
    ## 10        1 1.5-2l 25-29     286     52
    ## 11        1 1.5-2l 30-35     355     74
    ## 12        1 1.5-2l   >35    1640    233
    ## 13        1    >2l   <25      24      4
    ## 14        1    >2l 25-29      71     18
    ## 15        1    >2l 30-35      99     19
    ## 16        1    >2l   >35     452     77
    ## 17        2    <1l   <25      85     22
    ## 18        2    <1l 25-29     139     19
    ## 19        2    <1l 30-35     151     22
    ## 20        2    <1l   >35     931     87
    ## 21        2 1-1.5l   <25     149     25
    ## 22        2 1-1.5l 25-29     313     51
    ## 23        2 1-1.5l 30-35     419     49
    ## 24        2 1-1.5l   >35    2443    290
    ## 25        2 1.5-2l   <25      66     14
    ## 26        2 1.5-2l 25-29     175     46
    ## 27        2 1.5-2l 30-35     221     39
    ## 28        2 1.5-2l   >35    1110    143
    ## 29        2    >2l   <25       9      4
    ## 30        2    >2l 25-29      48     15
    ## 31        2    >2l 30-35      72     12
    ## 32        2    >2l   >35     322     53
    ## 33        3    <1l   <25      35      5
    ## 34        3    <1l 25-29      73     11
    ## 35        3    <1l 30-35      89     10
    ## 36        3    <1l   >35     648     67
    ## 37        3 1-1.5l   <25      53     10
    ## 38        3 1-1.5l 25-29     155     24
    ## 39        3 1-1.5l 30-35     240     37
    ## 40        3 1-1.5l   >35    1635    187
    ## 41        3 1.5-2l   <25      24      8
    ## 42        3 1.5-2l 25-29      78     19
    ## 43        3 1.5-2l 30-35     121     24
    ## 44        3 1.5-2l   >35     692    101
    ## 45        3    >2l   <25       7      3
    ## 46        3    >2l 25-29      29      2
    ## 47        3    >2l 30-35      43      8
    ## 48        3    >2l   >35     245     37
    ## 49        4    <1l   <25      20      2
    ## 50        4    <1l 25-29      33      5
    ## 51        4    <1l 30-35      40      4
    ## 52        4    <1l   >35     316     36
    ## 53        4 1-1.5l   <25      31      7
    ## 54        4 1-1.5l 25-29      81     10
    ## 55        4 1-1.5l 30-35     122     22
    ## 56        4 1-1.5l   >35     724    102
    ## 57        4 1.5-2l   <25      18      5
    ## 58        4 1.5-2l 25-29      39      7
    ## 59        4 1.5-2l 30-35      68     16
    ## 60        4 1.5-2l   >35     344     63
    ## 61        4    >2l   <25       3      0
    ## 62        4    >2l 25-29      16      6
    ## 63        4    >2l 30-35      25      8
    ## 64        4    >2l   >35     114     33

``` r
c(1, 3, 7)
```

    ## [1] 1 3 7

``` r
1:10
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
Insurance[1:10 , ]
```

    ##    District  Group   Age Holders Claims
    ## 1         1    <1l   <25     197     38
    ## 2         1    <1l 25-29     264     35
    ## 3         1    <1l 30-35     246     20
    ## 4         1    <1l   >35    1680    156
    ## 5         1 1-1.5l   <25     284     63
    ## 6         1 1-1.5l 25-29     536     84
    ## 7         1 1-1.5l 30-35     696     89
    ## 8         1 1-1.5l   >35    3582    400
    ## 9         1 1.5-2l   <25     133     19
    ## 10        1 1.5-2l 25-29     286     52

``` r
Insurance[-c( 1, 3, 7), ] # negative indices are excluded> d.sport[ , 2:3]
```

    ##    District  Group   Age Holders Claims
    ## 2         1    <1l 25-29     264     35
    ## 4         1    <1l   >35    1680    156
    ## 5         1 1-1.5l   <25     284     63
    ## 6         1 1-1.5l 25-29     536     84
    ## 8         1 1-1.5l   >35    3582    400
    ## 9         1 1.5-2l   <25     133     19
    ## 10        1 1.5-2l 25-29     286     52
    ## 11        1 1.5-2l 30-35     355     74
    ## 12        1 1.5-2l   >35    1640    233
    ## 13        1    >2l   <25      24      4
    ## 14        1    >2l 25-29      71     18
    ## 15        1    >2l 30-35      99     19
    ## 16        1    >2l   >35     452     77
    ## 17        2    <1l   <25      85     22
    ## 18        2    <1l 25-29     139     19
    ## 19        2    <1l 30-35     151     22
    ## 20        2    <1l   >35     931     87
    ## 21        2 1-1.5l   <25     149     25
    ## 22        2 1-1.5l 25-29     313     51
    ## 23        2 1-1.5l 30-35     419     49
    ## 24        2 1-1.5l   >35    2443    290
    ## 25        2 1.5-2l   <25      66     14
    ## 26        2 1.5-2l 25-29     175     46
    ## 27        2 1.5-2l 30-35     221     39
    ## 28        2 1.5-2l   >35    1110    143
    ## 29        2    >2l   <25       9      4
    ## 30        2    >2l 25-29      48     15
    ## 31        2    >2l 30-35      72     12
    ## 32        2    >2l   >35     322     53
    ## 33        3    <1l   <25      35      5
    ## 34        3    <1l 25-29      73     11
    ## 35        3    <1l 30-35      89     10
    ## 36        3    <1l   >35     648     67
    ## 37        3 1-1.5l   <25      53     10
    ## 38        3 1-1.5l 25-29     155     24
    ## 39        3 1-1.5l 30-35     240     37
    ## 40        3 1-1.5l   >35    1635    187
    ## 41        3 1.5-2l   <25      24      8
    ## 42        3 1.5-2l 25-29      78     19
    ## 43        3 1.5-2l 30-35     121     24
    ## 44        3 1.5-2l   >35     692    101
    ## 45        3    >2l   <25       7      3
    ## 46        3    >2l 25-29      29      2
    ## 47        3    >2l 30-35      43      8
    ## 48        3    >2l   >35     245     37
    ## 49        4    <1l   <25      20      2
    ## 50        4    <1l 25-29      33      5
    ## 51        4    <1l 30-35      40      4
    ## 52        4    <1l   >35     316     36
    ## 53        4 1-1.5l   <25      31      7
    ## 54        4 1-1.5l 25-29      81     10
    ## 55        4 1-1.5l 30-35     122     22
    ## 56        4 1-1.5l   >35     724    102
    ## 57        4 1.5-2l   <25      18      5
    ## 58        4 1.5-2l 25-29      39      7
    ## 59        4 1.5-2l 30-35      68     16
    ## 60        4 1.5-2l   >35     344     63
    ## 61        4    >2l   <25       3      0
    ## 62        4    >2l 25-29      16      6
    ## 63        4    >2l 30-35      25      8
    ## 64        4    >2l   >35     114     33

``` r
Insurance[c(1, 3, 6), 2:3]
```

    ##    Group   Age
    ## 1    <1l   <25
    ## 3    <1l 30-35
    ## 6 1-1.5l 25-29

7 - R Functions
---------------

Example function calls

``` r
mean(Insurance$Claims)
```

    ## [1] 49.23438

``` r
quantile(Insurance$Claims)
```

    ##    0%   25%   50%   75%  100% 
    ##   0.0   9.5  22.0  55.5 400.0

``` r
quantile(Insurance$Claims, probs = c(0.75, 0.9))
```

    ##   75%   90% 
    ##  55.5 101.7

Always check out the functions help function with ?mean and ?quantile.

Functions consist of mandatory and optional arguments: mean(x, trim = 0, na.rm = FALSE, ...) x: mandatory argument trim: optional argument, default is 0 na.rm: optional argument, default is FALSE

The arguments of a function have a defined order and each argument has its own unique name.

``` r
mean(x = Insurance$Claims, na.rm = TRUE)
```

    ## [1] 49.23438

You can either use the names of the arguments, or place the values in the correct order (or a mix of both):

``` r
mean(Insurance$Claims, ,TRUE)
```

    ## [1] 49.23438

Example functions with no mandatory arguments: matrix(), vector(),array(), list()&gt; ?matrix

8 - Useful functions
--------------------

Useful functions (look for help by typing ?str):

-   str()
-   nrow() and ncol()
-   dim()
-   summary()
-   apply()
-   head() and tail() see also R Reference card

9 - Packages
------------

By default, R only provides a basic set of functions. Additional functions(and datasets) are obtained by loading additional \* add-on packages\*

Install and load "MASS" package (<https://cran.r-project.org/web/packages/MASS/MASS.pdf>. There is always a pdf containing information about the package.

``` r
#install.packages("MASS") # install onto computer once
require(MASS) # for every R session.
library(MASS)
```

Online resources:

-   list of all packages:<http://cran.r-project.org/web/packages/I>

-   by topic: <http://cran.r-project.org/web/views/I>

-   ask Google

10 - Further reading
--------------------

For continuation on that level, see <ftp://ess.r-project.org/users/sfs/RKurs/R.Intro/slides.pdf>

Google's R Style Guide ("how to write good R code") <https://google.github.io/styleguide/Rguide.xml>

RStudio Cheat Sheets (phantastic!) <https://www.rstudio.com/resources/cheatsheets/>
