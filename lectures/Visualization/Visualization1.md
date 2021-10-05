Visualization1
================
Zheyan
2021/10/5

# Preparation

``` r
library(tidyverse)
```

    ## -- Attaching packages --------------------------------------- tidyverse 1.3.1 --

    ## v ggplot2 3.3.5     v purrr   0.3.4
    ## v tibble  3.1.4     v dplyr   1.0.7
    ## v tidyr   1.1.3     v stringr 1.4.0
    ## v readr   2.0.1     v forcats 0.5.1

    ## -- Conflicts ------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(ggridges)

knitr::opts_chunk$set(
  fig.width = 6,
  fig.asp = .6,
  out.width = "90%"
)
```

``` r
weather_df = 
  rnoaa::meteo_pull_monitors(
    c("USW00094728", "USC00519397", "USS0023B17S"),
    var = c("PRCP", "TMIN", "TMAX"), 
    date_min = "2017-01-01",
    date_max = "2017-12-31") %>%
  mutate(
    name = recode(
      id, 
      USW00094728 = "CentralPark_NY", 
      USC00519397 = "Waikiki_HA",
      USS0023B17S = "Waterhole_WA"),
    tmin = tmin / 10,
    tmax = tmax / 10) %>%
  select(name, id, everything())
```

    ## Registered S3 method overwritten by 'hoardr':
    ##   method           from
    ##   print.cache_info httr

    ## using cached file: C:\Users\jimmy\AppData\Local/Cache/R/noaa_ghcnd/USW00094728.dly

    ## date created (size, mb): 2021-10-05 00:17:48 (7.617)

    ## file min/max dates: 1869-01-01 / 2021-10-31

    ## using cached file: C:\Users\jimmy\AppData\Local/Cache/R/noaa_ghcnd/USC00519397.dly

    ## date created (size, mb): 2021-10-05 00:18:00 (1.701)

    ## file min/max dates: 1965-01-01 / 2020-02-29

    ## using cached file: C:\Users\jimmy\AppData\Local/Cache/R/noaa_ghcnd/USS0023B17S.dly

    ## date created (size, mb): 2021-10-05 00:18:06 (0.913)

    ## file min/max dates: 1999-09-01 / 2021-09-30

# Scatterplot

## Basic Scatterplot

tmax vs tmin

    ## Warning: Removed 15 rows containing missing values (geom_point).

<img src="Visualization1_files/figure-gfm/pressure-1.png" width="90%" />

you can save ggplot

``` r
ggp_tmax_tmin = 
  weather_df %>% ggplot(aes(x = tmin, y = tmax)) + 
  geom_point()

ggp_tmax_tmin
```

    ## Warning: Removed 15 rows containing missing values (geom_point).

<img src="Visualization1_files/figure-gfm/unnamed-chunk-2-1.png" width="90%" />

## Advancecd scatterplot

Add color

``` r
weather_df %>% ggplot(aes(x = tmin, y = tmax)) + 
  geom_point(aes(color = name))
```

    ## Warning: Removed 15 rows containing missing values (geom_point).

<img src="Visualization1_files/figure-gfm/unnamed-chunk-3-1.png" width="90%" />

We can also make the point more transparent and add a smooth line in it

``` r
# add color in ggplot, the color is global/public (in point and smooth line)
ggplot(weather_df, aes(x = tmin, y = tmax, color = name)) + 
  geom_point(alpha = .5) +
  geom_smooth(se = FALSE)
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

    ## Warning: Removed 15 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 15 rows containing missing values (geom_point).

<img src="Visualization1_files/figure-gfm/unnamed-chunk-4-1.png" width="90%" />

``` r
# use facet to draw mutiple plots
ggplot(weather_df, aes(x = tmin, y = tmax)) + 
  geom_point(aes(color = name), alpha = .5) +
  geom_smooth(se = FALSE) +
  facet_grid(.~name)
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

    ## Warning: Removed 15 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 15 rows containing missing values (geom_point).

<img src="Visualization1_files/figure-gfm/unnamed-chunk-5-1.png" width="90%" />

Lets make one more scatterplot

``` r
weather_df %>% 
  ggplot(aes(x = date, y = tmax, color = name,size = prcp)) +
  geom_point() +
  facet_grid(.~name) + 
  geom_smooth(se = FALSE)
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

    ## Warning: Removed 3 rows containing non-finite values (stat_smooth).

    ## Warning: Removed 3 rows containing missing values (geom_point).

<img src="Visualization1_files/figure-gfm/unnamed-chunk-6-1.png" width="90%" />

## Use data manipulations as part of this

``` r
weather_df %>% 
  filter(name == "CentralPark_NY") %>% 
  ggplot(aes(x = tmin, y = tmax)) + geom_point()
```

<img src="Visualization1_files/figure-gfm/unnamed-chunk-7-1.png" width="90%" />

# Stacking geoms

Which geoms do you want

``` r
weather_df %>% 
  ggplot(aes(x = date, y = tmax, color = name)) +
  geom_smooth()
```

    ## `geom_smooth()` using method = 'loess' and formula 'y ~ x'

    ## Warning: Removed 3 rows containing non-finite values (stat_smooth).

<img src="Visualization1_files/figure-gfm/unnamed-chunk-8-1.png" width="90%" />

``` r
weather_df %>% 
  ggplot(aes(x = date, y = tmax)) +
  geom_hex()
```

    ## Warning: Removed 3 rows containing non-finite values (stat_binhex).

<img src="Visualization1_files/figure-gfm/unnamed-chunk-9-1.png" width="90%" />

## Univariate plots

``` r
weather_df %>% 
  ggplot(aes(x = tmax, fill = name)) +
  geom_histogram() +
  facet_grid(.~name)
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

    ## Warning: Removed 3 rows containing non-finite values (stat_bin).

<img src="Visualization1_files/figure-gfm/unnamed-chunk-10-1.png" width="90%" />

Try other plots

``` r
weather_df %>% 
  ggplot(aes(x = tmax, fill = name)) +
  geom_density(alpha = 0.7)
```

    ## Warning: Removed 3 rows containing non-finite values (stat_density).

<img src="Visualization1_files/figure-gfm/unnamed-chunk-11-1.png" width="90%" />

Still with tmax and name

``` r
weather_df %>% 
  ggplot(aes(x = name, y = tmax)) + 
  geom_boxplot()
```

    ## Warning: Removed 3 rows containing non-finite values (stat_boxplot).

<img src="Visualization1_files/figure-gfm/unnamed-chunk-12-1.png" width="90%" />

Some people like violin plots

``` r
weather_df %>% 
  ggplot(aes(x = name, y = tmax)) + 
  geom_violin()
```

    ## Warning: Removed 3 rows containing non-finite values (stat_ydensity).

<img src="Visualization1_files/figure-gfm/unnamed-chunk-13-1.png" width="90%" />

Some linke ridges

``` r
library(ggridges)
weather_df %>% 
  ggplot(aes(x = tmax, y = name)) + 
  geom_density_ridges()
```

    ## Picking joint bandwidth of 1.84

    ## Warning: Removed 3 rows containing non-finite values (stat_density_ridges).

<img src="Visualization1_files/figure-gfm/unnamed-chunk-14-1.png" width="90%" />

## Embedding plots

``` r
# also can do glbal settings
weather_df %>% ggplot(aes(x = tmin, y = tmax)) + 
  geom_point(aes(color = name))
```

    ## Warning: Removed 15 rows containing missing values (geom_point).

<img src="Visualization1_files/figure-gfm/trying to show on github-1.png" width="90%" />
