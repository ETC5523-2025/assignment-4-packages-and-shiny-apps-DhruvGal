#' Quarantine breach risk simulations
#'
#' A dataset combining three simulation outputs from the COVIDQuarantine model
#' (Lydeamore et al.), representing different quarantine and vaccination
#' scenarios for travellers and workers in hotel quarantine over 14 days.
#'
#' Each row corresponds to a time point within a simulation and includes the
#' estimated breach risk under one scenario.
#'
#' @format A data frame with one row per time point and scenario. Key variables
#'   include:
#' \describe{
#'   \item{scenario}{Text label describing the scenario (e.g. traveller vs worker, vaccination status).}
#'   \item{group}{Whether the scenario relates to travellers or workers.}
#'   \item{time}{Time index or day in the simulation (replace with your actual column name if different).}
#'   \item{breach_prob}{Estimated probability or rate of breach at that time (replace with your actual column name if different).}
#'   \item{...}{Other variables included in the original simulation outputs.}
#' }
#'
#' @source Derived from three CSV files in the COVIDQuarantine GitHub repository
#'   by Michael Lydeamore.
"quarantine_data"
