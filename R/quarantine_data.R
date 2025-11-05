#' Quarantine breach risk simulations
#'
#' A dataset combining three simulation outputs from the COVIDQuarantine model
#' (Lydeamore et al.), representing different quarantine and vaccination
#' scenarios for travellers and workers in hotel quarantine over 14 days.
#'
#' Each row corresponds to a time point within a simulation and includes the
#' estimated breach-related quantities under one scenario.
#'
#' @format A data frame with one row per time point and scenario. Key variables
#'   include:
#' \describe{
#'   \item{scenario}{Simulation scenario (traveller/worker and vaccination status).}
#'   \item{group}{Whether the scenario relates to travellers or workers.}
#'   \item{t_incubation}{Simulated incubation time (days) until symptom onset.}
#'   \item{...}{Other variables from the original simulation outputs.}
#' }
#'
#' @source Derived from three CSV files in the COVIDQuarantine GitHub repository
#'   by Michael Lydeamore.
"quarantine_data"
