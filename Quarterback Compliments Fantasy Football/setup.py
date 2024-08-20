import requests
from bs4 import BeautifulSoup
import pandas as pd

# Excel file downloaded from FTN Fantasy, columns removed so file has Name, QB Ranking, Team
qb_rankings = 'data/qb_expert_rankings.xlsx'
adp_df = pd.read_excel(qb_rankings)

print(adp_df.head())

# Pulling data for SOS from Draft Sharks
url = "https://www.draftsharks.com/strength-of-schedule/qb"

response = requests.get(url)
response.raise_for_status()  # Check for request errors

soup = BeautifulSoup(response.text, 'html.parser')

table = soup.find('table', class_='table')
rows = table.find_all('tr')

qb_data = []

for row in rows[1:]:
    columns = row.find_all('td')
    if columns:
        qb_name = columns[0].get_text(strip=True)
        matchups = [col.get_text(strip=True) for col in columns[1:]]
        qb_data.append({'Team': qb_name, 'Matchups': matchups})

qb_df = pd.DataFrame(qb_data)

matchups_df = pd.DataFrame(qb_df['Matchups'].tolist(), columns=[f'Week_{i + 1}' for i in range(23)])

final_df = pd.concat([qb_df['Team'], matchups_df], axis=1)

final_df['Team'] = final_df['Team'].str.replace('qbs', '', regex=False)

final_df = final_df.drop(final_df.index[-1])

final_df = final_df.iloc[:, :-6]

# final_df.to_csv('data/qb_17_week_matchups.csv', index=False)

# Merging both data frames, final one will containg all columns from both
qb_df_full = pd.merge(adp_df, final_df, on='Team', how='inner')

# qb_df_full.to_csv('data/qb_df_full.csv', index=False)