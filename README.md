
# covidQuarantineViz

covidQuarantineViz is an R package that turns the simulated quarantine
analysis from ETC5523 into a reproducible, interactive workflow.

The package:

1.  Bundles three simulation scenarios from Michael Lydeamore’s
    COVIDQuarantine model (traveller vs worker, vaccinated vs
    unvaccinated),

2.  Exposes the combined dataset as quarantine_data,

3.  Provides a Shiny app to explore differences in incubation times
    between scenarios, and

4.  Includes a vignette and documentation website to explain the
    analysis.

This package was developed as part of ETC5523 Assignment 4: Turning
analysis interactive. It takes the ideas from Assignments 1–3 and wraps
them into a distributable R package with an interactive Shiny component.

## Installation

You can install the development version from GitHub with:

``` r
# install.packages("remotes")
remotes::install_github("ETC5523-2025/assignment-4-packages-and-shiny-apps-DhruvGal")
```

## Getting started

Load the package:

``` r
library(covidQuarantineViz)
```

## The main dataset: quarantine_data

The core dataset included in the package is quarantine_data, which
combines three simulation outputs from the COVIDQuarantine model into a
single data frame. Each row corresponds to one simulated individual in
one scenario.

``` r
data("quarantine_data", package = "covidQuarantineViz")
head(quarantine_data)
#>   days_infectious_community days_in_quar days_in_extended_quar
#> 1                 1.4146924            4                     0
#> 2                 2.8309601            4                     4
#> 3                 0.4137212            2                     4
#> 4                 1.1789740            4                     0
#> 5                 3.8798872            4                     0
#> 6                 1.3757392            2                    14
#>   days_in_isolation t_latent t_incubation t_post_incubation time_discharged
#> 1                10      0.1     4.822449          9.692244             158
#> 2                10      0.1     9.820436          9.110525             162
#> 3                10      0.1     6.466695          8.747026            1774
#> 4                10      0.1     8.001724          8.977250            1867
#> 5                10      0.1     8.858909          9.020979            2150
#> 6                 0      0.1     6.582189          8.993550            2330
#>   index_case symptomatic vaccinated compliant      FoI_max integrated_FoI
#> 1          0           0          0         1 2.704994e-04   9.979526e-06
#> 2          0           0          0         1 3.691373e-01   6.508962e-02
#> 3          0           0          0         1 1.905661e+00   6.236900e-03
#> 4          1           0          0         1 1.710111e-06   4.684067e-08
#> 5          0           0          0         1 3.902629e-07   1.424251e-07
#> 6          0           0          0         1 5.485896e-01   2.072547e-02
#>                  scenario     group days_to_detection tested_positive
#> 1 Traveller, unvaccinated traveller                NA              NA
#> 2 Traveller, unvaccinated traveller                NA              NA
#> 3 Traveller, unvaccinated traveller                NA              NA
#> 4 Traveller, unvaccinated traveller                NA              NA
#> 5 Traveller, unvaccinated traveller                NA              NA
#> 6 Traveller, unvaccinated traveller                NA              NA
#>   expressed_symptoms time_removed FoI
#> 1                 NA           NA  NA
#> 2                 NA           NA  NA
#> 3                 NA           NA  NA
#> 4                 NA           NA  NA
#> 5                 NA           NA  NA
#> 6                 NA           NA  NA
```

Key variables include:

scenario: Simulation scenario (traveller/worker and vaccination status).

group: Whether the scenario relates to travellers or workers.

t_incubation: Simulated incubation time (days) until symptom onset.

Other variables from the original simulation outputs.

For full details, see the help page:

``` r
?quarantine_data
```

## Launching the Shiny app

The package includes an interactive Shiny app that allows you to explore
the distribution of incubation times by scenario and to compare simple
summary statistics.

Launch the app with:

``` r
run_quarantine_app()
```

In the app you can:

select a scenario (e.g. traveller vs worker, vaccinated vs
unvaccinated),

view the incubation time distribution for the selected scenario, and

inspect a summary table (mean, median, min, max, sample size) for
incubation times.

The sidebar describes the key fields, and each tab includes guidance on
how to interpret the plot and the table.

## Vignette

A more detailed walkthrough of the dataset and analysis is provided in
the package vignette. It reproduces simple summaries and plots and
explains how the Shiny app fits into the broader ETC5523 analysis.

You can open the vignette with:

``` r
vignette("overview", package = "covidQuarantineViz")
#> Warning: vignette 'overview' not found
```

The vignette:

gives an overview of the quarantine_data structure,

shows example summaries of incubation time by scenario, and

demonstrates simple visualisations that match the story told in the app.

## Package website

A pkgdown website is available for this package, providing function
reference pages and access to the vignette in a web browser:

<https://etc5523-2025.github.io/assignment-4-packages-and-shiny-apps-DhruvGal/>

## Data source and attribution

The quarantine_data dataset is derived from three CSV files in the
COVIDQuarantine GitHub repository by Michael Lydeamore. These
simulations describe quarantine scenarios for travellers and workers in
hotel quarantine over 14 days, under different vaccination assumptions.

This package repackages those simulation outputs for teaching in ETC5523
and adds an interactive interface to help users explore how the
incubation time distribution changes under different scenarios.
