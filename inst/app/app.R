# inst/app/app.R

data("quarantine_data", package = "covidQuarantineViz")

ui <- shiny::fluidPage(
  theme = shinythemes::shinytheme("flatly"),
  shiny::titlePanel("Quarantine outcomes explorer"),

  shiny::sidebarLayout(
    shiny::sidebarPanel(
      shiny::h4("Filters"),
      shiny::selectInput(
        "scenario",
        "Select scenario:",
        choices = sort(unique(quarantine_data$scenario)),
        selected = sort(unique(quarantine_data$scenario))[1]
      ),
      shiny::br(),
      shiny::h4("Field descriptions"),
      shiny::helpText("scenario: Simulation scenario (traveller/worker and vaccination status)."),
      shiny::helpText("group: Whether the simulation relates to travellers or workers."),
      shiny::helpText("t_incubation: Simulated incubation time (days) until symptom onset.")
    ),

    shiny::mainPanel(
      shiny::tabsetPanel(
        shiny::tabPanel(
          "Incubation plot",
          shiny::br(),
          shiny::plotOutput("incub_plot"),
          shiny::br(),
          shiny::h4("How to interpret this plot"),
          shiny::p("Each bar shows how many simulated individuals have incubation times"),
          shiny::p("in each range for the selected scenario."),
          shiny::p("Scenarios with bars further to the right correspond to longer incubation"),
          shiny::p("times on average, which may increase the chance that infections are"),
          shiny::p("missed before the end of quarantine.")
        ),
        shiny::tabPanel(
          "Summary table",
          shiny::br(),
          shiny::tableOutput("summary_table"),
          shiny::br(),
          shiny::h4("How to interpret this table"),
          shiny::p("The table reports simple summary statistics of the incubation time"),
          shiny::p("for the selected scenario. A higher mean or median indicates longer"),
          shiny::p("incubation times, while a wider range (min to max) indicates more"),
          shiny::p("variability between simulated individuals.")
        )
      )
    )
  )
)

server <- function(input, output, session) {

  filtered_data <- shiny::reactive({
    quarantine_data |>
      dplyr::filter(scenario == input$scenario)
  })

  output$incub_plot <- shiny::renderPlot({
    df <- filtered_data()

    ggplot2::ggplot(df, ggplot2::aes(x = t_incubation)) +
      ggplot2::geom_histogram(bins = 30) +
      ggplot2::labs(
        x = "Incubation time (days)",
        y = "Number of simulated individuals",
        title = paste("Incubation time distribution -", input$scenario)
      )
  })

  output$summary_table <- shiny::renderTable({
    df <- filtered_data()

    dplyr::tibble(
      mean_incubation   = mean(df$t_incubation, na.rm = TRUE),
      median_incubation = stats::median(df$t_incubation, na.rm = TRUE),
      min_incubation    = min(df$t_incubation, na.rm = TRUE),
      max_incubation    = max(df$t_incubation, na.rm = TRUE),
      n                 = sum(!is.na(df$t_incubation))
    )
  })
}

shiny::shinyApp(ui, server)
