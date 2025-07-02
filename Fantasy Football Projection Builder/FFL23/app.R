library(shiny)
library(shinythemes)
library(ggplot2)
library(tidyverse)

ffl2023 = read.csv(file = "data/ffl2023.csv") %>%
  select("pos", "last_name", "first_name", matches("."))
average = read.csv(file = "data/average.csv") %>%
  select("pos", "last_name", "first_name", matches("."))
weighted = read.csv(file = "data/weighted.csv") %>%
  select("pos", "last_name", "first_name", matches("."))
robust = read.csv(file = "data/robust.csv") %>%
  select("pos", "last_name", "first_name", matches("."))

ffl2022 = read.csv(file = "data/ffl2022.csv")
ffl2022 = ffl2022 %>%
  filter (avg_type == "robust")

ui <- fluidPage(
  titlePanel("Fantasy Football 23 Projections?"),
  navbarPage("Tabs",
             theme = shinytheme("superhero"),
             tabPanel("Random Data", dataTableOutput("table")),
             tabPanel("Random Data 2022", dataTableOutput("table22")),
             tabPanel("Specifically Random Data", sidebarLayout(sidebarPanel(selectInput("table_select", "Select Data", choices = c("Weighted", "Average", "Robust")),
                                                                             checkboxGroupInput("position_select", "Position:",
                                                                                                choices = c("QB", "RB", "WR", "TE", "DST"))),
                                                                mainPanel(dataTableOutput("select_table")))),
             tabPanel("Random Data Graph", sidebarLayout(sidebarPanel(selectInput("table_select", "Select Data", choices = c("Weighted", "Average", "Robust")),
                                                                             checkboxGroupInput("position_select", "Position:",
                                                                                                choices = c("QB", "RB", "WR", "TE", "DST"))),
                                                                mainPanel(plotOutput("graph")))),
  )
)

server <- function(input, output) {
# Table
  output$table <-
    renderDataTable({ffl2023})
  
  output$table22 <-
    renderDataTable({ffl2022})
  
  data_used = weighted
  selected_data <- reactive({
    if (input$table_select == "Robust") {
      data_used = robust
      if (!is.null(input$position_select) && length(input$position_select) > 0) {
        data_used <- data_used[data_used$pos %in% input$position_select, ]
      }
      return(data_used)
    } else if (input$table_select == "Average") {
      data_used = average
      if (!is.null(input$position_select) && length(input$position_select) > 0) {
        data_used <- data_used[data_used$pos %in% input$position_select, ]
      }
      return(data_used)
    } else {
      data_used = weighted
      if (!is.null(input$position_select) && length(input$position_select) > 0) {
        data_used <- data_used[data_used$pos %in% input$position_select, ]
      }
      return(data_used)
    }
  })

  
  output$select_table <- renderDataTable({
    selected_data()
  })
  
  output$graph <- renderPlot({
    data <- selected_data()
    if (!is.null(data)) {
      ggplot(data, aes(x = last_name, y = points_vor, color = pos)) +
        geom_point() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
