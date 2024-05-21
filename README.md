
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Nepal-Conflict-and-Elections

<!-- badges: start -->
<!-- badges: end -->

## The data

Here is some data:

``` r
library(tidyverse)
#> ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
#> ✔ dplyr     1.1.4     ✔ readr     2.1.5
#> ✔ forcats   1.0.0     ✔ stringr   1.5.1
#> ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
#> ✔ lubridate 1.9.3     ✔ tidyr     1.3.0
#> ✔ purrr     1.0.2     
#> ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
#> ✖ dplyr::filter() masks stats::filter()
#> ✖ dplyr::lag()    masks stats::lag()
#> ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors

df = read.csv("electionstats.csv")
head(df)
#>   districtname const maoistvotes totalvotes eligiblevoters
#> 1       Achham     1       16468      52976          97149
#> 2       Achham     2       17976      50553          95707
#> 3 Arghakhanchi     1       19584      48720          88034
#> 4 Arghakhanchi     2       11588      48226          92660
#> 5      Baglung     1       14386      47769          79605
#> 6      Baglung     2        7451      41449          74969
```
