# Script to create the `quarantine_data` dataset from three CSVs

library(readr)
library(dplyr)
library(usethis)

# 1. Read each CSV and tag it with a scenario label

traveller_unvacc <- readr::read_csv(
  "data-raw/TUnvacc_WUnvacc_HotelQuar_14d_traveller_breach_timeseries.csv"
) |>
  dplyr::mutate(
    scenario = "Traveller, unvaccinated",
    group = "traveller"
  )

traveller_vacc_az1 <- readr::read_csv(
  "data-raw/TVaccAZ1_WUnvacc_HotelQuar_14d_traveller_breach_timeseries.csv"
) |>
  dplyr::mutate(
    scenario = "Traveller, AZ1 vaccinated",
    group = "traveller"
  )

worker_unvacc <- readr::read_csv(
  "data-raw/TUnvacc_WUnvacc_HotelQuar_14d_worker_breach_timeseries.csv"
) |>
  dplyr::mutate(
    scenario = "Worker, unvaccinated",
    group = "worker"
  )

# 2. Combine into a single dataset

quarantine_data <- dplyr::bind_rows(
  traveller_unvacc,
  traveller_vacc_az1,
  worker_unvacc
)

# 3. Save as package data

usethis::use_data(quarantine_data, overwrite = TRUE)

