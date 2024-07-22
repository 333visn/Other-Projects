library(tidyverse)
library(shiny)
library(ggplot2)
library(readxl)
library(httr)
library(tidyverse)
library(rvest)
library(jsonlite)
library(shinythemes)

path <- "https://bsproxy.royaleapi.dev/v1/brawlers"
api_key <- "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjdmMjIxYjY3LTczZmYtNGIzZC04ZTBmLTdkNjA0Y2ZlZjBkOCIsImlhdCI6MTcwMTMyNDMyOSwic3ViIjoiZGV2ZWxvcGVyL2ZhYjc4N2JlLTkyNTMtYzJlNy1iNTk0LTBlNTE2ZDUyMDQ3OCIsInNjb3BlcyI6WyJicmF3bHN0YXJzIl0sImxpbWl0cyI6W3sidGllciI6ImRldmVsb3Blci9zaWx2ZXIiLCJ0eXBlIjoidGhyb3R0bGluZyJ9LHsiY2lkcnMiOlsiMzguNjUuMjM2LjEyMSIsIjQ1Ljc5LjIxOC43OSJdLCJ0eXBlIjoiY2xpZW50In1dfQ.AIgIOvjHByetSeiIwDUFraHNbBUoJ6_XHi_SgKfvk6YHTS1H2ByDCG5FTUKXApDHyWd8F4w23hSqw2B3Xw51rA
-Oy5_Z9JxLKlJJ74MB6EZTreAraAyfCEuPwa2HM4sbUQB2zeepsEEpdW47e7-YRrWzIt5J988sO8bY6YYKw"
headers <- c(
  "Authorization" = paste("Bearer", api_key),
  "Content-Type" = "application/json"
)
r1 <- GET(path, add_headers(headers))
rr1 <- content(r1, as = "text", encoding = "UTF-8")
df1 <- jsonlite::fromJSON(rr1,flatten = TRUE)
brawler_data = df1[[1]]

path2 <- "https://bsproxy.royaleapi.dev/v1/players/%238CQV8GPG9"
api_key <- "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjdmMjIxYjY3LTczZmYtNGIzZC04ZTBmLTdkNjA0Y2ZlZjBkOCIsImlhdCI6MTcwMTMyNDMyOSwic3ViIjoiZGV2ZWxvcGVyL2ZhYjc4N2JlLTkyNTMtYzJlNy1iNTk0LTBlNTE2ZDUyMDQ3OCIsInNjb3BlcyI6WyJicmF3bHN0YXJzIl0sImxpbWl0cyI6W3sidGllciI6ImRldmVsb3Blci9zaWx2ZXIiLCJ0eXBlIjoidGhyb3R0bGluZyJ9LHsiY2lkcnMiOlsiMzguNjUuMjM2LjEyMSIsIjQ1Ljc5LjIxOC43OSJdLCJ0eXBlIjoiY2xpZW50In1dfQ.AIgIOvjHByetSeiIwDUFraHNbBUoJ6_XHi_SgKfvk6YHTS1H2ByDCG5FTUKXApDHyWd8F4w23hSqw2B3Xw51rA
-Oy5_Z9JxLKlJJ74MB6EZTreAraAyfCEuPwa2HM4sbUQB2zeepsEEpdW47e7-YRrWzIt5J988sO8bY6YYKw"
headers <- c(
  "Authorization" = paste("Bearer", api_key),
  "Content-Type" = "application/json"
)
r2 <- GET(path2, add_headers(headers))
rr2 <- content(r2, as = "text", encoding = "UTF-8")
df2 <- jsonlite::fromJSON(rr2,flatten = TRUE)
solo <- df2[[17]]

fetch_rankings_data <- function(country_code, season_id) {
  url <- paste0("https://bsproxy.royaleapi.dev/v1/rankings/",country_code, "/powerplay/seasons/",season_id)
  api_key <- "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiIsImtpZCI6IjI4YTMxOGY3LTAwMDAtYTFlYi03ZmExLTJjNzQzM2M2Y2NhNSJ9.eyJpc3MiOiJzdXBlcmNlbGwiLCJhdWQiOiJzdXBlcmNlbGw6Z2FtZWFwaSIsImp0aSI6IjdmMjIxYjY3LTczZmYtNGIzZC04ZTBmLTdkNjA0Y2ZlZjBkOCIsImlhdCI6MTcwMTMyNDMyOSwic3ViIjoiZGV2ZWxvcGVyL2ZhYjc4N2JlLTkyNTMtYzJlNy1iNTk0LTBlNTE2ZDUyMDQ3OCIsInNjb3BlcyI6WyJicmF3bHN0YXJzIl0sImxpbWl0cyI6W3sidGllciI6ImRldmVsb3Blci9zaWx2ZXIiLCJ0eXBlIjoidGhyb3R0bGluZyJ9LHsiY2lkcnMiOlsiMzguNjUuMjM2LjEyMSIsIjQ1Ljc5LjIxOC43OSJdLCJ0eXBlIjoiY2xpZW50In1dfQ.AIgIOvjHByetSeiIwDUFraHNbBUoJ6_XHi_SgKfvk6YHTS1H2ByDCG5FTUKXApDHyWd8F4w23hSqw2B3Xw51rA
-Oy5_Z9JxLKlJJ74MB6EZTreAraAyfCEuPwa2HM4sbUQB2zeepsEEpdW47e7-YRrWzIt5J988sO8bY6YYKw"
  headers <- c(
    "Authorization" = paste("Bearer", api_key),
    "Content-Type" = "application/json"
  )
  r <- GET(url, add_headers(headers))
  rr <- content(r, as = "text", encoding = "UTF-8")
  df <- jsonlite::fromJSON(rr,flatten = TRUE)
  return(as_tibble(df[[1]]))
}

ui <- fluidPage(
  titlePanel("Brawl Stars General Statistics"),
  navbarPage("Tabs",
  theme = shinytheme("cosmo"),
    tabPanel(titlePanel("Solo Stats Plot"),
             selectInput("trophy_select", "Current Trophies or Highest Ever Trophies", choices = c("Current", "Highest")),
             actionButton("submit_btn_trophies", "Update"),
             plotOutput("trophy_plot")
             ),
    tabPanel(titlePanel("Solo Stats Table"),
             selectInput("trophy_select_table", "Current Trophies or Highest Ever Trophies", choices = c("Current", "Highest")),
             actionButton("submit_btn_trophies_table", "Update"),
             dataTableOutput("trophy_table")
    ),
    tabPanel(titlePanel("Season Rankings Chart"),
             textInput("country_text", "Enter 2-Digit Country Code", value = "US"),
             sliderInput("season_slider", "Select Season", min = 55, max = 115, value = 85),
             actionButton("submit_btn_chart", "Update"),
             dataTableOutput("brawler_rankings_chart")
    ),
    tabPanel(
      titlePanel("Brawler Info"),
      selectInput("brawler", "Select Brawler", choices = unique(brawler_data$name)),
      selectInput("power_type", "Select Power Type", choices = c("Star Power", "Gadget")),
      actionButton("submit_btn", "Update"),
      dataTableOutput("selected_power_table")
    ),
    tabPanel(titlePanel("About"), mainPanel(textOutput("about")))
  )
)

server <- function(input, output) {
  observeEvent(input$submit_btn_trophies, {
    if (input$trophy_select == "Current") {
        trophy <- "trophies"
        yl <- "Current Number of Trophies"
        output$trophy_plot <- renderPlot({
          ggplot(solo, aes(x = name, y = trophies, fill = name)) +
            geom_bar(stat = "identity") +
            labs(title = "Current Number of Trophies per Brawler",
                 x = "Brawler",
                 y = yl) +
            theme_minimal() +
            scale_x_discrete(labels = NULL)
        })
    } else {
      trophy <- "highestTrophies"
      yl <- "Highest Number of Trophies"
      output$trophy_plot <- renderPlot({
        ggplot(solo, aes(x = name, y = highestTrophies, fill = name)) +
          geom_bar(stat = "identity") +
          labs(title = "Highest Number of Trophies per Brawler",
               x = "Brawler",
               y = yl) +
          theme_minimal() +
          scale_x_discrete(labels = NULL)
      })
    }
  })
    
    observeEvent(input$submit_btn_trophies_table, {
      soloTR <- solo %>%
        select(`name`, `power`,`rank`,`trophies`) %>%
        arrange(., desc(`trophies`))
      soloHTR <- solo %>%
        select(`name`, `power`,`rank`,`highestTrophies`) %>%
        arrange(., desc(`highestTrophies`))
      soloTable <- soloTR
      if (input$trophy_select_table == "Current") {
        soloTable <- soloTR
      } else {
        soloTable <- soloHTR
      }
      output$trophy_table <- renderDataTable({
        soloTable
      })
  })
  
  observeEvent(input$submit_btn_chart, {
    selected_country_chart <- input$country_text
    selected_season_chart <- input$season_slider
    output$brawler_rankings_chart <- renderDataTable({
      table <- (fetch_rankings_data(selected_country_chart, selected_season_chart))
      table
    })
  })
  
  observeEvent(input$submit_btn, {
    selected_brawler <- input$brawler
    selected_power_type <- input$power_type
    brawler_id <- brawler_data$id[brawler_data$name == selected_brawler]
    # Filter data based on user input
    if (selected_power_type == "Star Power") {
      selected_brawler_starPowers <- brawler_data$starPowers[brawler_data$name == selected_brawler]
      spt <- selected_brawler_starPowers[[1]]
    } else {
      selected_brawler_gadgets <- brawler_data$gadgets[brawler_data$name == selected_brawler]
      spt <- selected_brawler_gadgets[[1]]
    }
    
    # Render the selected power table
    output$selected_power_table <- renderDataTable({
      spt
    })
  })
  
  output$about <- renderText("
  This application contains different stats from Brawl Stars. Stats include Solo Stats, 
  where the user can pull up my statistics from the game for different Brawlers and showed 
  their ranks and trophies currently and the highest I have achieved with those Brawlers. 
    There is also the Season Rankings Chart where the user can find the top 200 users from 
    several countries or global for different seasons. To obtain a specific country, type in a 
    2 digit code in the 2 Digit Country Code slot. Some codes for countries include US, MX, CA, 
    CH, IN, ID, and JP, etc.. If the user wants global rankings, simply type 'global'. Each Brawl 
    Star season last two weeks, which is why there are a lot of seasons that the user can access. 
    However, the data found only starts from season 55 so any data from seasons before are not available. 
    Rankings are based on the number of trophies at the end of a season. When the season ends, 
    each brawler is reset to a lower amount of trophies (usually rounded down to the closet factor 
    of 50, so someone with 675 trophies goes to 650 and someone with 747 trophies goes down to 700).
    The Brawler Info tab is a basic lookup of a Brawler's Gadget and Star Power. Each Brawler has 
    2 Gadgets that they can use a fixed number of times during a match and 2 Star Powers that gives a 
    Brawler a certain power that can be only unlocked when the Brawler reaches Level 9. Each 
    Brawler can only select one of each for a match if they have unlocked Gadgets and/or Star Powers. 
    Users can drop down select any character in the game and select if they want to find that 
    character's Star Power or Gadget. The Brawler Info tab only provides the name and id of these Star 
    Powers and Gadgets, not more.
    Brawl Stars is a mobile game made by Supercell. Users play with different characters (called Brawlers) who have different characteristics and weapons and they will try to accumulate trophies by winning different matches against other users. Users can also level up Brawlers by collecting brawler tokens. The higher the rank, the stronger the Brawler (that Brawler will do more damage in matches and have more health).
    Data was taken from the Brawl Stars API.
    [Brawl Stars Api](https://developer.brawlstars.com/#/)")
}

shinyApp(ui = ui, server = server)