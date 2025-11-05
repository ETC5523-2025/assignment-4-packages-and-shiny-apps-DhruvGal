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
      selectInput(
        "country",
        "Select country:",
        choices = sort(unique(quarantine_data$country)),
        selected = sort(unique(quarantine_data$country))[1]
      )
    ),
    mainPanel(
      plotOutput("plot")
    )
  )
)

server <- function(input, output, session) {
  output$plot <- renderPlot({
    df <- quarantine_data |>
      filter(country == input$country)

    ggplot(df, aes(x = date, y = outcome_rate)) +
      geom_line() +
      labs(
        x = "Date",
        y = "Outcome rate",
        title = paste("Outcome rate over time for", input$country)
      )
  })
}

shinyApp(ui, server)
