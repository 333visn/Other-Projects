library("ffanalytics")
library(tidyverse)

rec = list(
  all_pos = TRUE,
  rec = 1, rec_yds = 0.1, rec_tds = 6
)

my_scrape <- scrape_data(src = c("CBS", "ESPN", "FantasyPros"), 
                        pos = c("QB", "RB", "WR", "TE", "DST"),
                        season = NULL, week = NULL)

ffl2023 <- projections_table(my_scrape)

ffl2023 <- ffl2023 %>% add_ecr() %>% add_uncertainty() %>%
  add_adp() %>% add_aav() %>% add_player_info()

average <- ffl2023 %>%
  filter(avg_type == "average") %>%
  select(-"id", -"avg_type")

robust <- ffl2023 %>%
  filter(avg_type == "robust") %>%
  select(-"id", -"avg_type")

weighted <- ffl2023 %>%
  filter(avg_type == "weighted") %>%
  select(-"id", -"avg_type")

view(average)

write_csv(x= ffl2023, file = "data/ffl2023.csv")
write_csv(x= average, file = "data/average.csv")
write_csv(x= robust, file = "data/robust.csv")
write_csv(x= weighted, file = "data/weighted.csv")

view(ffl2023)


my_scrape2 <- scrape_data(src = c("CBS", "ESPN", "FantasyPros"), 
                         pos = c("QB", "RB", "WR", "TE", "DST"),
                         season = 2022, week = 0)

ffl2022 <- projections_table(my_scrape2)

ffl2022 <- ffl2022 %>% add_ecr() %>% add_uncertainty() %>%
  add_adp() %>% add_aav() %>% add_player_info()

write_csv(x= ffl2022, file = "data/ffl2022.csv")