# NFL Import
#from espn_api.football import League
# NBA Import
#from espn_api.basketball import League
# WNBA Import
#from espn_api.wbasketball import League
# MLB Import
from espn_api.baseball import League
import pandas as pd
import csv
from datetime import datetime
# NHL Import
#from espn_api.hockey import League

# private league with cookies

# Insert League ID, ESPN_S2
league = League(league_id= 00000, year=2025, espn_s2= '')

Player_book = []

# Change range(10) with the number of players in the league.
for i in range(10):
    Roster = league.get_team_data(i+1).roster
    Name = league.get_team_data(i+1).team_name
    print(league.get_team_data(i+1).team_name)
    for j in range(len(Roster)):
        player = Roster[j]
        Player_book.append([player.name, player.playerId, player.eligibleSlots, Name])


Player_book = pd.DataFrame(Player_book)

Player_book.to_csv("Player_book.csv", index = False)