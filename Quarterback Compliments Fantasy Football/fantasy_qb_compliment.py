import pandas as pd

# Data pulled and setup in file 'setup.py'
file_path = 'data/qb_df_full.csv'
data = pd.read_csv(file_path)

# Finding the bye week
def extract_bye_week(row):
    for week_num, matchup in enumerate(row[2:], start=1):
        if 'BYE' in str(matchup):
            return week_num
    return None

data['ByeWeek'] = data.apply(extract_bye_week, axis=1)

# Sorting out the weekly matchups
def extract_matchups(row):
    matchups = row[2:]
    return matchups

# Converting the opponent's percentage differences from string to float
def clean_percentage(value):
    if isinstance(value, str):
        value = value.replace('%', '').strip('[]')
        try:
            return float(value)
        except ValueError:
            return None
    return None

# Calculating and showing the ideal backup quarterbacks to draft
def show_ideal_backups(selected_name, data, available_data):
    selected_data = data[data['Name'] == selected_name]
    
    if selected_data.empty:
        print(f"No data found for {selected_name}.")
        return

    bye_week = selected_data['ByeWeek'].values[0]
    
    if pd.isna(bye_week):
        print(f"{selected_name} does not have a bye week listed.")
        return
    
    print(f"\nSelected quarterback: {selected_name}")
    print(f"Bye Week: {bye_week - 1}")
    
    potential_backups = []

    for idx, row in data.iterrows():
        if row['Name'] != selected_name and row['Name'] in available_data['Name'].values:
            quarterback_name = row['Name']
            matchups = extract_matchups(row)
            if len(matchups) >= bye_week:
                matchup = matchups.iloc[int(bye_week) - 1]
                if pd.notna(matchup):
                    percentage = matchup.split(']')[0].strip('[')
                    opponent = matchup.split(']')[1] if len(matchup.split(']')) > 1 else ''
                    potential_backups.append((quarterback_name, percentage, opponent))
    
    potential_backups = [(qb, clean_percentage(pct), opp) for qb, pct, opp in potential_backups if clean_percentage(pct) is not None]
    potential_backups.sort(key=lambda x: x[1], reverse=True)
    
    print("\nIdeal backups based on bye week matchups:")
    for qb, pct, opp in potential_backups:
        print(f"QB: {qb}, Matchup Percentage: {pct}%, Opponent: {opp}")

# Main option, shows all quarterbacks based on fantasy rankings. 
# Gives option to remove a quarterback from the draft board, or inquire about possible backups.
def select_quarterback(data):
    available_data = data.copy()
    
    while not available_data.empty:
        print("Available Quarterbacks:")
        for idx, name in enumerate(available_data['Name'].unique(), start=1):
            print(f"{idx}. {name}")

        selected_index = int(input("Select a quarterback by entering the corresponding number (or 0 to exit): "))
        
        if selected_index == 0:
            print("Exiting selection.")
            break
        
        if 1 <= selected_index <= len(available_data['Name'].unique()):
            selected_name = available_data['Name'].unique()[selected_index - 1]
            selected_data = available_data[available_data['Name'] == selected_name]
            
            print(f"\nYou selected: {selected_name}")
            print(f"Here is the data for {selected_name}:\n")
            print(selected_data)
            
            action = input("Type 'remove' to remove the quarterback from the board, or 'backup' to see ideal backups: ").strip().lower()
            if action == 'remove':
                available_data = available_data[available_data['Name'] != selected_name]
                print(f"\n{selected_name} has been removed from the board.")
            elif action == 'backup':
                show_ideal_backups(selected_name, data, available_data)
            else:
                print("Invalid option. Please type 'remove' or 'backup'.")
        else:
            print("Invalid selection. Please try again.")
    
    if available_data.empty:
        print("No more quarterbacks available for selection.")

def main():
    select_quarterback(data)

if __name__ == "__main__":
    main()
