library(tidyverse)
library(shiny)
library(hrbrthemes)

Book <- read.csv("Player_bookStats.csv") %>%
  select(-`X`, -`PlayerId`, -`player_id`, -`year`)

AdvancedBook <- read.csv("AdvancedBook.csv")

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Fantasy Baseball Tools 2025"),
  navbarPage("Tabs", 
             tabPanel("Table",
                      sidebarPanel(selectInput("isPitching", "Batting or Pitching", choices = c("Batting", "Pitching")), selected = "Batting"),
                      dataTableOutput("table1")),
             tabPanel("Plot",
                      sidebarPanel(
                        selectInput("isPitching", "Batting or Pitching", choices = c("Batting", "Pitching")), selected = "Batting",
                        selectInput("plotStat", "Select a stat:", choices = c("BA", "SLG", "ISO", "OBP", "WOBA")), selected = "WOBA"),
                      ),
                      mainPanel(
                      plotOutput("xPlot")))
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  PitcherBoolean <- reactive({
    if (input$isPitching == "Batting") {
      subset(Book, isPitcher == FALSE)
    } else {
      subset(Book, isPitcher == TRUE)
    }
  })
  
  PitcherBooleanAdvanced <- reactive ({
    if (input$isPitching == "Batting") {
      subset(AdvancedBook, isPitcher == FALSE)
    } else {
      subset(AdvancedBook, isPitcher == TRUE)
    }
  })
  
  AdvancedStatX <- reactive({
    BookFiltered = PitcherBooleanAdvanced()
    if (input$plotStat == "BA") {
      advStat = BookFiltered$BA
    }
    else if (input$plotStat == "ISO") {
      advStat = BookFiltered$ISO
    }
    else if (input$plotStat == "SLG") {
      advStat = BookFiltered$SLG
    }
    else if (input$plotStat == "OBP") {
      advStat = BookFiltered$OBP
    }
    else {
      advStat = BookFiltered$WOBA
    }
    return (advStat)
  })
  
  
  AdvancedStatY <- reactive({
    BookFiltered = PitcherBooleanAdvanced()
    if (input$plotStat == "BA") {
      xadvStat = BookFiltered$xBA
    }
    else if (input$plotStat == "ISO") {
      xadvStat = BookFiltered$xISO
    }
    else if (input$plotStat == "SLG") {
      xadvStat = BookFiltered$xSLG
    }
    else if (input$plotStat == "OBP") {
      xadvStat = BookFiltered$xOBP
    }
    else {
      xadvStat = BookFiltered$xWOBA
    }
    return (xadvStat)
  })
  
  output$table1 <- renderDataTable({
    PitcherBoolean()
  })
  
  output$xPlot <- renderPlot({
    ggplot(PitcherBooleanAdvanced(), aes(x = AdvancedStatX(), y = AdvancedStatY(), color = FantasyTeam)) +
      geom_abline(intercept = 0, slope = 1) +
      xlab(input$plotStat) +
      ylab(paste("x", input$plotStat)) +
      geom_point(size = 7)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
