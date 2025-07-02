This is a guide/brief summary to all the projects in the repository.

1. Brawl Stars Data Visualization
  This is a visualizer that uses RShiny in which the data is pulled from the Brawl Stars API (https://developer.brawlstars.com/#/). The application can display leaderboards for certain countries and brawlers, as well as personal statistics for certain brawlers. More information can be found in the about.Rmd in the Brawl Stars Data Visualization folder.

2. NHL Goalie 2024-25 Analysis
   This is a Jupyter notebook that takes data from Hockey Reference (https://www.hockey-reference.com/leagues/NHL_2025_goalies.html) that starts by visualizing goalie statistics (shots faced, goals conceded, wins) and then uses linear regression to predict the amount of quality starts a goalie should have given certain variables.

3. Fantasy Football Projection Builder
    This is a projection builder using R that uses the "ffanalytics" package to scrape projections from Fantasy Football websites (ESPN, Yahoo, FantasyPros). Data is built for a Standard PPR League. Users can filter for different positions to get rankings on those selected, and can choose either average projections, weighted (weights are added based on historical accuracy), or robust (outliers are taken out as much as possible, but there are no weights). Robust is recommended, as it takes out any outlier projections from any source. Projections are available for 2023 and 2024, and 2025 will be up soon.

4. Quarterback Compliments Fantasy Football (2024)
   This is an program using Python and Excel that pulls data from FTN Fantasy and Draft Sharks and let's a user select an NFL Quarterback that they can draft in fantasy football and the program will display the other quarterbacks with the best matchups during the bye week of the quarterback selected. This is meant to give an idea as to who would be a good backup to draft given the quarterbacks on the board and the starter picked (and which starter to pick if the bye week landscape gives impacts the user's selection). Users can also remove quarterbacks off the board if they want, based on their preferences.

5. School Learning Model
  This short project takes in data from a given set of schools and uses an ANOVA models to determine if factors like culture, origin, school type, type of learner, and gender all could contribute to the amounts of day a child was absent from school. There will be a pdf report to include any findings from the data model.
