
#Aim of the script:

#When new player(s) signs up using the survey
#   1. The artists they added are verified (valid entry & correct categories)
#   2. If all entries are valid, their details are added to the `playerdatabase`
#   3. Their artists are added in the `artistdatabase`
#TODO
#   3. They are recoreded in `leaguedatabase`

# Load Packages -----------------------------------------------------------


#devtools::install_github("liamhaller/spotifystreams", force = TRUE)
library(spotifystreams)
library(tidyverse)
library(googlesheets4)


# Authentication ----------------------------------------------------------

#initiate authentication
source(paste0(getwd(),'/Scripts/', 'googlesheets_authentication.R'))

#Load local functions
source(paste0(getwd(),'/Scripts/', 'helper_functions.R'))


# Load databases ---------------------------------------------------

player_signup_sheet <- 'https://docs.google.com/spreadsheets/d/1ma6XLczPAx9vHLg2K5hQvWIfq-CkZq4-BEdjBNP0RcQ/edit#gid=1094503793'
league_data <- 'https://docs.google.com/spreadsheets/d/1CK0yXMXTIvirWfRNO6XLdytMq9OnRKo5aBi001x53SY/edit#gid=0'

new_players <- googlesheets4::read_sheet(player_signup_sheet) %>%
  mutate(time_submitted = as.Date(Timestamp), .keep = "unused", .before = 1)
colnames(new_players) <- c('time_submitted', 'email', 'teamname', 'artist1', 'artist2', 'artist3', 'artist4', 'artist5')

league_data <- googlesheets4::read_sheet(league_data)
artist_caps <- league_data %>%
  filter(`Leauge ID` == 1) %>% #hard coded for now
  select(4:8) #select artist data

# Wrangle entries ---------------------------------------------------------

##Filter for recent entries (within five days) -- or for now sine last updated
refresh_date <- as.Date(Sys.time()) - 5

new_players <-
  new_players %>% filter(time_submitted > refresh_date) %>%
  mutate(tempid = row_number())

#Replace spotify URL with artist code
new_players <-
  new_players %>% mutate(across(starts_with('artist'),  spotifystreams::parse_spotify_link))


# Validate entries ---------------------------------------



## Check if artists provided are under category caps ##
issues_df <- data.frame(player_to_remove = integer(), artist = integer(), stringsAsFactors = FALSE) #dataframe of invalid artists and associated player


#TODO check to see if it's a valid link (should be added to spotifystrams)


#check to make sure each artist is currently under the league cap
for(i in 1:NROW(new_players)){ #This level is for each entry

  artist_codes <- new_players[i, c(4:8)]

  for(j in 1:length(artist_codes)){

    #get current number of listeners
    current_listeners <- spotifystreams::get_monthly_listeners(artist_codes[[j]])
    #get artist cap for current category
    category_cap <- artist_caps[[j]]

    if(current_listeners > category_cap){

      issue <- data.frame(player_to_remove = i, artist = j)
      issues_df <- rbind(issues_df, issue, stringsAsFactors = FALSE)
      print('issue')
    }
  }
}

#TODO
## function to message players input was invalid, should be added to helper functions

# message <- paste("Hi, unfortunately the artist you submitted for the <",
#                  ifelse(j == 1, "25k", ifelse(j == 2 || j == 3 || j == 4, "250k", "1m")),
#                  "category has", current_listeners, "Monthly Listeners.
#                        Please try again or feel free to reach out to me at eahochberger@gmail.com if you believe this to be a mistake.
#                        Thanks, Eric", sep = " ")


#Remove invalid entries from list
new_players <- new_players[ ! new_players$tempid %in% issues_df$player_to_remove, ]



# Edit databases ----------------------------------------------------------

## Add valid new player(s) to database ##
playerdatabase <- 'https://docs.google.com/spreadsheets/d/1ywy6QH3iQktlYRV3z2HJVcuD2Rr8bwhXkEW-jwkcmV8/edit#gid=0'

#find number of last ID in existing player database & generate list for new playesrs
last_id <- googlesheets4::read_sheet(playerdatabase) %>% NROW()
new_ids <- seq(last_id + 1, last_id + NROW(new_players))

#reformat new player input to fit with database
new_players <- new_players %>%
  mutate(player_id = new_ids, .before = everything()) %>%
  mutate(league_id = 1, .after = player_id) %>%
  rename(player_baseline = time_submitted) %>%
  select(-tempid)

#add new player(s) to database
googlesheets4::sheet_append(ss = playerdatabase,
                            data = new_players,
                            sheet = 1)

#TODO add artists to player active artist list

### add Artists database ###
artistdatabase <- "https://docs.google.com/spreadsheets/d/18cLVfPIy0EAG3lQzxlSRDRAi5kGezcgML7BU3UkikF8/edit#gid=0"

existing_artists <- read_sheet(artistdatabase) %>% pull(1) #pull artist IDs

#get list of new artists to add
new_artists <- new_players %>%
  select(6:10) %>%
  tidyr::pivot_longer(everything()) %>%
  pull(value) %>%
  unname()

#remove duplicates and aritsts that are already in the database
new_artists <- setdiff(new_artists, existing_artists) %>% as.data.frame

#Get names of each artist and add to database
new_artists$artist_name <- apply(new_artists, 1, spotifystreams::get_artist_name)
colnames(new_artists) <- c('artist_id', 'artist_name')

#add new artist(s) to database
googlesheets4::sheet_append(ss = artistdatabase,
                            data = new_artists,
                            sheet = 1)





