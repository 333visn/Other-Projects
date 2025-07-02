library(tidyverse)

Book <- read.csv("Player_bookStats.csv") %>%
  select(-`X`, -`PlayerId`, -`player_id`, -`year`)

Book2 <- Book %>%
  filter(!is.na(pa)) %>%
  group_by(FantasyTeam, isPitcher) %>%
  mutate(xHits = xba * ab, 
         xBases = xslg * ab, 
         xOB = xobp * (ab + walk + hit_by_pitch + sac_fly),
         xWOB = xwoba * (ab + walk - IBB + sac_fly + hit_by_pitch),
         WOB = woba * (ab + walk - IBB + sac_fly + hit_by_pitch)) %>%
  summarise(pa = sum(pa), ab = sum(ab), hit = sum(hit), 
            single = sum(single), double = sum(double), triple = sum(triple),
            home_run = sum(home_run), strikeout = sum(strikeout), walk = sum(walk), IBB = sum(IBB), 
            hit_by_pitch = sum(hit_by_pitch), sac_fly = sum(sac_fly), WOB = sum(WOB), xHits = sum(xHits),
            xBases = sum(xBases), xOB = sum(xOB), xWOB = sum(xWOB)) %>%
  mutate(`BA` = round(hit/ab, 3),
         `OBP` = round((hit + walk + hit_by_pitch) / (ab + walk + hit_by_pitch + sac_fly), 3),
         `SLG` = round((`single` + 2*`double` + 3*`triple` + 4*`home_run`) / ab, 3),
         `OPS` = `OBP` + `SLG`,
         `K%` = round(strikeout / pa, 3),
         `BB%` = round(walk / pa, 3),
         `ISO` = round(SLG - BA, 3),
         `WOBA` = round(WOB / (ab + walk - IBB + sac_fly + hit_by_pitch), 3),
         `xBA` = round(`xHits` / ab, 3),
         `xBAdiff` = `xBA` - `BA`,
         `xSLG` = round(`xBases` / ab, 3),
         `xSLGdiff` = `xSLG` - `SLG`,
         `xISO` = `xSLG` - `xBA`,
         `xISOdiff` = `xISO` - `ISO`,
         `xOBP` = round(`xOB` / (`xOB` - `xHits` + ab + sac_fly), 3),
         `xOBPdiff` = `xOBP` - `OBP`,
         `xWOBA` = round(`xWOB` / (ab + walk - IBB + sac_fly + hit_by_pitch), 3),
         `xWOBAdiff` = `xWOBA` - `WOBA`
         )

View(Book2)

Batting <- Book2 %>%
  filter(isPitcher == FALSE)
View(Batting)


Pitching <- Book2 %>%
  filter(isPitcher == TRUE)
View(Pitching)

write.csv(Book2, "AdvancedBook.csv")