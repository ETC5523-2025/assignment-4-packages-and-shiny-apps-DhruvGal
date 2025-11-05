#' This function launches the interactive Shiny app included with the
#' `covidQuarantineViz` package.
#'
#' @return
#' @export
#'
#' @examples
#' # run_quarantine_app()
run_quarantine_app <- function() {
  app_dir <- system.file("app", package = "covidQuarantineViz")
  if (app_dir == "") {
    stop("Could not find app directory. Try reinstalling covidQuarantineViz.",
         call. = FALSE)
  }
  shiny::runApp(app_dir, display.mode = "normal")
}
