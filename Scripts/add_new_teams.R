


# Load Packages -----------------------------------------------------------



library(spotifystreams)
#devtools::install_github("liamhaller/spotifystreams", force = TRUE)

library(tidyverse)
library(googlesheets4)

#pak::pak("tidyverse/googlesheets4") #is there a reason you were using the github version?
#library(rvest)





# Load new submissions  ---------------------------------------------------


league <- readRDS("league.rds")


# read in new team submissions
new_teams <- read_csv('/Users/Eric.Hochberger/Downloads/Fantasy Music League Sign-up 4.csv')
new_column_names <- c('time_submitted', 'email', 'teamname', 'artist_25k', 'artist_250k_1', 'artist_250k_2', 'artist_250k_3', 'artist_1m')
colnames(new_teams) <- new_column_names
new_teams$artist_250k_1

new_teams
# get just artist codes



issues_df <- data.frame(email = character(), message = character(), stringsAsFactors = FALSE)




# Process submissions  ----------------------------------------------------


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


scoring <- tibble::tribble(
  ~desc, ~scoring,
  "25k Artist Growth", "=(INDEX(4:4, 1, COUNTA(4:4))-C4)/C4",
  "250k Artist 1 Growth", "=(INDEX(5:5, 1, COUNTA(5:5))-C5)/C5",
  "250k Artist 2 Growth", "=(INDEX(6:6, 1, COUNTA(6:6))-C6)/C6",
  "250k Artist 3 Growth", "=(INDEX(7:7, 1, COUNTA(7:7))-C7)/C7",
  "1M Artist Growth", "=(INDEX(8:8, 1, COUNTA(8:8))-C8)/C8"
)

scoring$scoring <- gs4_formula(scoring$scoring)

scoring_sum <- tibble::tribble(
  ~name, ~avg_formula
)


for (i in 1:length(new_team_dfs)) {
  googlesheets4::range_write('https://docs.google.com/spreadsheets/d/1GtLYZJ3OcywTGT75LMIXJwogC5CJx_biGl5l0MuVLM4/edit#gid=0', as.data.frame(new_team_dfs[[i]] %>% select(-artist_code)), sheet = new_teams[i], range = "A3:D8")

  googlesheets4::range_write('https://docs.google.com/spreadsheets/d/1GtLYZJ3OcywTGT75LMIXJwogC5CJx_biGl5l0MuVLM4/edit#gid=0', scoring, sheet = new_teams[i], range = "B20", reformat = FALSE)

new_scoring_sum_row <- tibble(
  name = new_teams[i],
  avg_formula = paste0('=AVERAGE(', new_teams[i], '!C21:C25)')
)

scoring_sum <- bind_rows(scoring_sum, new_scoring_sum_row)

}

scoring_sum$avg_formula <- gs4_formula(scoring_sum$avg_formula)

scoring_sheet <- googlesheets4::read_sheet('https://docs.google.com/spreadsheets/d/1GtLYZJ3OcywTGT75LMIXJwogC5CJx_biGl5l0MuVLM4/edit#gid=0', sheet = 'Scoring')

scoring_sheet <- scoring_sheet %>% filter(complete.cases(`Avg % Diff`))

scoring_sum_range <- paste0('B', nrow(scoring_sheet)+2)

googlesheets4::range_write('https://docs.google.com/spreadsheets/d/1GtLYZJ3OcywTGT75LMIXJwogC5CJx_biGl5l0MuVLM4/edit#gid=0', data = scoring_sum, sheet = 'Scoring', range = scoring_sum_range, col_names = FALSE, reformat = FALSE)


#transfer update to the google sheet - doesn't work for the new teams quite yet but everything else does
spotifystreams::update_sheets(list = new_league, updated_coulmn = 4,
                              sheet_id = "1GtLYZJ3OcywTGT75LMIXJwogC5CJx_biGl5l0MuVLM4",
                              auth_token = token)

saveRDS(league, file = "league.rds")

