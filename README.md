
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Nepal-Conflict-and-Elections

<!-- badges: start -->
<!-- badges: end -->

## The data

Here is some data:

``` r
library(tidyverse)

df = read.csv("nepalelection.csv")
head(df)
#>   districtname constnum      constname maoist   uml nepalicongress turnout
#> 1       Achham        1       Achham 1  29.04 38.86          25.98   54.53
#> 2       Achham        2       Achham 2  32.35 27.04          21.00   52.82
#> 3 Arghakhanchi        1 Arghakhanchi 1  35.54 19.85          21.64   55.34
#> 4 Arghakhanchi        2 Arghakhanchi 2  25.44 29.48          33.72   52.05
#> 5      Baglung        1      Baglung 1  30.47 27.92          24.72   60.01
#> 6      Baglung        2      Baglung 2  19.98  8.56          27.38   55.29
#>   candidate_avgage winnerage per_femalecandidates per_malecandidates
#> 1            40.57        40                 0.00             100.00
#> 2            45.50        32                 0.00             100.00
#> 3            44.75        46                12.50              87.50
#> 4            44.33        46                16.67              83.33
#> 5            46.70        48                10.00              90.00
#> 6            47.00        66                10.00              90.00
#>   winnergender
#> 1            M
#> 2            M
#> 3            M
#> 4            F
#> 5            M
#> 6            M
```

## Descriptive statistics

``` r
avgage = mean(df$winnerage)
head(avgage)
#> [1] 43.725
```

## Plots

``` r
ggplot(df, aes(maoist, winnerage, colour = winnergender)) + 
  geom_point() + 
  geom_smooth(method=lm, se=FALSE)
```

![](README_files/figure-gfm/unnamed-chunk-4-1.png)<!-- -->
