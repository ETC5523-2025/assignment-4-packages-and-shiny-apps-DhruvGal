# inst/app/app.R

library(shiny)
library(shinythemes)
library(dplyr)
library(ggplot2)

# Use package data
data("quarantine_data", package = "covidQuarantineViz")

ui <- fluidPage(
  theme = shinythemes::shinytheme("flatly"),
  titlePanel("Quarantine outcomes explorer"),

  sidebarLayout(
    sidebarPanel(
      h4("Filters"),
      selectInput(
        "scenario",
        "Select scenario:",
        choices = sort(unique(quarantine_data$scenario)),
        selected = sort(unique(quarantine_data$scenario))[1]
      ),
      br(),
      h4("Field descriptions"),
      helpText("scenario: Simulation scenario (traveller/worker and vaccination status)."),
      helpText("t_incubation: Simulated incubation time (days) until symptom onset."),
      helpText("group: Whether the simulation relates to travellers or workers.")
    ),

    mainPanel(
      plotOutput("incub_plot"),
      br(),
      h4("How to interpret this plot"),
      p("Each bar shows how many simulated individuals have incubation times"),
      p("in each range for the selected scenario."),
      p("Scenarios shifted to the right correspond to longer incubation times on average.")
    )
  )
)

server <- function(input, output, session) {

  filtered_data <- reactive({
    quarantine_data |>
      filter(scenario == input$scenario)
  })

  output$incub_plot <- renderPlot({
    df <- filtered_data()

    ggplot(df, aes(x = t_incubation)) +
      geom_histogram(bins = 30) +
      labs(
        x = "Incubation time (days)",
        y = "Number of simulated individuals",
        title = paste("Distribution of incubation time -", input$scenario)
      )
  })
}

shinyApp(ui, server)
