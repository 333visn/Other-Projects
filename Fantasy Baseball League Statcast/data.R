library(tidyverse)
library(stringi)

Player_book <- read.csv("Player_book.csv") %>%
  mutate("Name" = `X0`, "PlayerId" = `X1`, "Position(s)" = `X2`, "FantasyTeam" = `X3`) %>%
  select(-`X0`, -`X1`, -`X2`, -`X3`)
#view(Player_book)

xStatsBatting <- read.csv("expected_statsMayBatting.csv") %>%
  mutate("Name" = str_replace(last_name..first_name, "^(.*),\\s*(.*)$", "\\2 \\1")) %>%
  select("Name", player_id:`swing_percent`) %>%
  rename("hit_by_pitch" = `b_hit_by_pitch`, "sac_fly" = `b_sac_fly`, "IBB" = `b_intent_walk`)

xStatsBatting$Name = stri_trans_general(str = xStatsBatting$Name, id = "Latin-ASCII")

#View(xStatsBatting)

xStatsPitching <- read.csv("expected_statsMayPitching.csv") %>%
  mutate("Name" = str_replace(last_name..first_name, "^(.*),\\s*(.*)$", "\\2 \\1")) %>%
  select("Name", player_id:`swing_percent`) %>%
  rename("hit_by_pitch" = `p_hit_by_pitch`, "sac_fly" = `p_sac_fly`, "IBB" = `p_intent_walk`)


xStatsPitching$Name = stri_trans_general(str = xStatsPitching$Name, id = "Latin-ASCII")
#view(xStatsPitching)

xStats <- xStatsBatting %>%
  full_join(xStatsPitching)
#View(xStats)

Player_bookStats <- Player_book %>%
  left_join(xStats, by = "Name") %>%
  mutate("isPitcher" = (grepl('P', `Position(s)`) & !grepl('Shohei Ohtani', `Name`)))
View(Player_bookStats)

write.csv(Player_bookStats, "Player_bookStats.csv")