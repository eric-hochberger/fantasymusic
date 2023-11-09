library(tidyverse)

devtools::install_github("liamhaller/spotifystreams", force = TRUE)
pak::pak("tidyverse/googlesheets4")
library(spotifystreams)
library(googlesheets4)
library(rvest)
## Existing League
league <-
  list(
    DRAKE = structure(
      list(
        artist = c("VRSS", "Arcy Drive",
                   "DNL", "Keiran Ivy", "KHI INFINITE", 'elias hix', 'Alessandra Salinas'),
        artist_code = c(
          "1o963gG7zP39nwOenqzPg2",
          "7o1TBmx7Ube5h2Czlam84O",
          "7aXH52JKx39Q5PprJmFxXu",
          "0wzHzFNLOLex8psv09KqNK",
          "6wthNkb9tOcsMdNtrHI5vs",
          '7caEhKgBilB0MHIyWWWGsV',
          '75yUCGnQnc6K7fg7qptCkO'
        ),
        baseline = c(1690, 141332, 10323,
                     23428, 426971, 99472, 2493)
      ),
      class = "data.frame",
      row.names = c(NA,7L)
    ),
    GUT = structure(
      list(
        artist = c("BXB LOVE", "Mike Sabbath",
                   "Louis Millne", "Ogi", "Mochakk", "Couch", "Dogs in a Pile"),
        artist_code = c(
          "03k90jclqTrew2X2DFnRCC",
          "3UTCjjwxYJioyA39EX6ciu",
          "6oVWsUniV39LusFsC7axlb",
          "60nDKjd690Luygtd3Fm0Cu",
          "0rTh1tAdrEbdKZBTiiAQSo",
          "3nYyLjhw4mYzYfJePsCJYJ",
          "5lObmA5WxJpUj8QO6YX7yF"
        ),
        baseline = c(1051, 177982, 129320,
                     227880, 826429, 160467, 20182)
      ),
      class = "data.frame",
      row.names = c(NA,-7L)
    ),
    GRAHAM = structure(
      list(
        artist = c(
          "BBiche",
          "Theo Kandel",
          "Anna Bates",
          "Peark & The Oysters",
          "Zinadelphia",
          "Sidney Gish"
        ),
        artist_code = c(
          "1m0M7J2El2DioTfule3L41",
          "0YEY41EVT9qE1IdDDDyF9q",
          "4JLqUtfyFvInfcLILCOIJx",
          "7ovvjgqrTeuMxbzIykUqDs",
          "2bTnGGWvuVQsMVyg31rmum",
          '2orBKFyc84jo9AZH5jarhI'
        ),
        baseline = c(8774, 68423, 172806,
                     164653, 522497, 284955)
      ),
      class = "data.frame",
      row.names = c(NA,-6L)
    ),
    LIAM = structure(
      list(
        artist = c("Nico Champagne",
                   "Wa-FU", "HIGGO", "Semma Sole", "PCRC", 'jev'),
        artist_code = c(
          "3aSb1wUqNgbzj9VTgYBhjY",
          "51miQgR4HHTo5kOwFCeyJo",
          "0f1qSxprIDtLaJfIaEJb64",
          "6bKkC8yidNL8j94vKjLysJ",
          "41Nu7NgAj9rJxjj7JDuXrV",
          '6OmxkansdRyVTvo6BpZzKF',
          "1XprynXL0SEUZCJN6OUFe6"
        ),
        baseline = c(353, 81884, 162736,
                     12793, 360087, 936921, 26672)
      ),
      class = "data.frame",
      row.names = c(NA,-7L)
    ),
    FELD = structure(
      list(
        artist = c("Cinya Khan",
                   "Flaujae", "Daoud", "YPC Nige", "jamesjamesjames"),
        artist_code = c(
          "7nv9u1rH0xrKytpgKfDKfz",
          "5IQcgEvxwvq8kwy4iWCiBC",
          "3e76yvk1gLZQhKZiUHkMsP",
          "13crAKmlVhj6yzOO9fuOmF",
          "0DqR5aQYPz1s2M3YbycLMJ"
        ),
        baseline = c(2745, 124864, 33168,
                     30521, 630692)
      ),
      class = "data.frame",
      row.names = c(NA,-5L)
    ),
    HOCH = structure(
      list(
        artist = c(
          "semiratuth",
          "Emanuel Satie",
          "MELT",
          "Murphys Law",
          "Ray Vaughan",
          "Munya",
          "mynameisntjmack"
        ),
        artist_code = c(
          "6vjKiruwh9k8dDi1rYvI82",
          "3veg7sFGWTk62Ecwj6mzij",
          "0G7KI9I5BApiXc5Sqpyil9",
          "1q85MRE0aEF6NfZQdlMrl1",
          "4yYYCSCDUTypErQMZv5iSg",
          '0JnhdXEQfVjoY1OgwTExwO',
          "7HY1ISUuRotG01FVu0PKWh"
        ),
        baseline = c(1248, 97818, 140738,
                     92716, 335847, 381765, 232979)
      ),
      class = "data.frame",
      row.names = c(NA,-7L)
    ),
    TRUES = structure(
      list(
        artist = c("Gibs", "DJ Chus",
                   "Crackazat", "Tiny Habits", "Mall Grab", "Lawrence"),
        artist_code = c(
          "6UEqUjzkCgVcEgJ5avKeFv",
          "7kxOVclB0zQamtBR0syCrg",
          "2PagBkTVHoKFjuxtCJp3As",
          "2QYdqWGgRorVkA8cJMMdrn",
          "7yF6JnFPDzgml2Ytkyl5D7",
          '5rwUYLyUq8gBsVaOUcUxpE'
        ),
        baseline = c(4774, 248524, 211869,
                     195807, 780378,576888)
      ),
      class = "data.frame",
      row.names = c(NA,-6L)
    ),
    LAM = structure(
      list(
        artist = c(
          "Mel 4ever",
          "FKA MASH",
          "Remmy Quinn",
          "Ben Sterling",
          "Justin Jay",
          "MAZ (BR)",
          "Sammy Virji"
        ),
        artist_code = c(
          "7e34iWed5vSXh7wAoejlOJ",
          "6tooLez7Cq2bgY60m3TJMq",
          "6OQoRzjz71ofDCQa5OTlfq",
          "79uJoLQkQ621xZy7MyH4uL",
          "5k5eiijuHxrGwXp2Pz37GZ",
          '6gYwbDKcqhLitCTlgF1oZn',
          '1GuqTQbuixFHD6eBkFwVcb'
        ),
        baseline = c(4925, 166838, 33814, 55276, 309695, 551076, 860525)
      ),
      class = "data.frame",
      row.names = c(NA,-7L)
    )
  )

# read in new team submissions
new_teams <- read_csv('/path/to/googleformoutput.csv')
new_column_names <- c('time_submitted', 'email', 'teamname', 'artist_25k', 'artist_250k_1', 'artist_250k_2', 'artist_250k_3', 'artist_1m')
colnames(new_teams) <- new_column_names
new_teams$artist_250k_1

new_teams
# get just artist codes



issues_df <- data.frame(email = character(), message = character(), stringsAsFactors = FALSE)




for (i in 1:nrow(new_teams)) {
  skip_team <- FALSE  # Flag to determine if the team should be skipped

  new_team_raw <- new_teams[i, ]
  teamname <- new_team_raw$teamname
  email <- new_team_raw$email


  new_team_raw$artist_1m <- strsplit(strsplit(new_team_raw$artist_1m, "https://open.spotify.com/artist/")[[1]][2], "\\?")[[1]][1]
  new_team_raw$artist_250k_1 <- strsplit(strsplit(new_team_raw$artist_250k_1, "https://open.spotify.com/artist/")[[1]][2], "\\?")[[1]][1]
  new_team_raw$artist_250k_2 <- strsplit(strsplit(new_team_raw$artist_250k_2, "https://open.spotify.com/artist/")[[1]][2], "\\?")[[1]][1]
  new_team_raw$artist_250k_3 <- strsplit(strsplit(new_team_raw$artist_250k_3, "https://open.spotify.com/artist/")[[1]][2], "\\?")[[1]][1]
  new_team_raw$artist_25k <- strsplit(strsplit(new_team_raw$artist_25k, "https://open.spotify.com/artist/")[[1]][2], "\\?")[[1]][1]

  artist_codes <- list(new_team_raw$artist_25k, new_team_raw$artist_250k_1, new_team_raw$artist_250k_2, new_team_raw$artist_250k_3,
                       new_team_raw$artist_1m)

  baseline_list = c()
  artist_list = c()
  artist_code_list = c()

  for (j in seq_along(artist_codes)) {
    artist_code <- artist_codes[[j]]
    artist_url <- paste0("https://open.spotify.com/artist/", artist_code)

    web <- rvest::read_html(artist_url)
    div_content <- web %>% rvest::html_elements("div") %>% rvest::html_text()
    h1_content <- web %>% rvest::html_elements("h1") %>% rvest::html_text()
    artist_name = h1_content[1]
    artist_url

    monthly_streams <- div_content[10]
    monthly_streams <- strsplit(monthly_streams, split = " ")
    monthly_streams <- as.numeric(gsub(",", "", monthly_streams[[1]][1]))

    baseline_list <- c(baseline_list, monthly_streams)
    artist_code_list <- c(artist_code_list, artist_code)
    artist_list <- c(artist_list, artist_name)

    if (j == 1 && baseline_list[j] > 25000 ||
        j == 2 && baseline_list[j] > 250000 ||
        j == 3 && baseline_list[j] > 250000 ||
        j == 4 && baseline_list[j] > 250000 ||
        j == 5 && baseline_list[j] > 1000000) {
      message <- paste("Hi, unfortunately the artist", artist_list[j], "you submitted for the <",
                       ifelse(j == 1, "25k", ifelse(j == 2 || j == 3 || j == 4, "250k", "1m")),
                       "category has", baseline_list[j], "Monthly Listeners. Please try again or feel free to reach out to me at eahochberger@gmail.com if you believe this to be a mistake. Thanks, Eric", sep = " ")

      issue <- data.frame(email = email, message=message)
      issues_df <- rbind(issues_df, issue, stringsAsFactors = FALSE)

      skip_team <- TRUE  # Set the flag to skip the current team
      break
       # Skip to the next team in new_teams
    }
  }

  if (skip_team) {
    next
  }
new_team = structure(
  list(
    artist = c(artist_list),
    artist_code = c(artist_code_list),
    baseline = c(baseline_list)
  ),
  class = "data.frame",
  row.names = c(NA,-length(artist_list))
)

league <- c(league, list(new_team))
names(league)[length(league)] <- teamname
}






# for loop here for multiple teams getting added


#Spotify link to artists page



token <- googlesheets4::gs4_token()

#Update leage results into local storage
new_league <- spotifystreams::update_streams(league)

sheet_info <- googlesheets4::gs4_get('https://docs.google.com/spreadsheets/d/1GtLYZJ3OcywTGT75LMIXJwogC5CJx_biGl5l0MuVLM4/edit#gid=0')

sheets <- sheet_info$sheets

current_teams <- c(sheets$name)

current_teams <- current_teams[current_teams != 'Scoring']

new_teams <- names(new_league)

new_teams <- new_teams[!(new_teams %in% current_teams)]

googlesheets4::sheet_add('https://docs.google.com/spreadsheets/d/1GtLYZJ3OcywTGT75LMIXJwogC5CJx_biGl5l0MuVLM4/edit#gid=0', sheet = new_teams) ## this adds sheets for all new teams, now need to be able to select the right dataframes and then write those to sheets


new_team_dfs <- new_league[new_teams]

length(new_team_dfs)

for (i in 1:length(new_team_dfs)) {
  googlesheets4::write_sheet(as.data.frame(new_team_dfs[[i]]), 'https://docs.google.com/spreadsheets/d/1GtLYZJ3OcywTGT75LMIXJwogC5CJx_biGl5l0MuVLM4/edit#gid=0', sheet = new_teams[i])

}




#transfer update to the google sheet - doesn't work for the new teams quite yet but everything else does
spotifystreams::update_sheets(list = new_league, updated_coulmn = 4,
                              sheet_id = "1GtLYZJ3OcywTGT75LMIXJwogC5CJx_biGl5l0MuVLM4",
                              auth_token = token)

