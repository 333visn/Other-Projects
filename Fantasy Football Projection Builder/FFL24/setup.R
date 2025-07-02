library("ffanalytics")
library(tidyverse)

rec = list(
  all_pos = TRUE,
  rec = 1, rec_yds = 0.1, rec_tds = 6
)

my_scrape <- scrape_data(src = c("CBS", "ESPN", "FantasyPros"), 
                         pos = c("QB", "RB", "WR", "TE", "DST"),
                         season = NULL, week = NULL)

ffl2024 <- projections_table(my_scrape)

ffl2024 <- ffl2024 %>% add_ecr() %>% add_uncertainty() %>%
  add_adp() %>% add_aav() %>% add_player_info()

average <- ffl2024 %>%
  filter(avg_type == "average") %>%
  select(-"id", -"avg_type") %>%
  select("pos", "last_name", "first_name", matches("."))

robust <- ffl2024 %>%
  filter(avg_type == "robust") %>%
  select(-"id", -"avg_type")

weighted <- ffl2024 %>%
  filter(avg_type == "weighted") %>%
  select(-"id", -"avg_type")

view(average)

write_csv(x= ffl2024, file = "data/ffl2024.csv")
write_csv(x= average, file = "data/average.csv")
write_csv(x= robust, file = "data/robust.csv")
write_csv(x= weighted, file = "data/weighted.csv")

view(ffl2024)


my_scrape2 <- scrape_data(src = c("CBS", "ESPN", "FantasyPros"), 
                          pos = c("QB", "RB", "WR", "TE", "DST"),
                          season = 2022, week = 0)

ffl2022 <- projections_table(my_scrape2)

ffl2022 <- ffl2022 %>% add_ecr() %>% add_uncertainty() %>%
  add_adp() %>% add_aav() %>% add_player_info()

write_csv(x= ffl2022, file = "data/ffl2022.csv")