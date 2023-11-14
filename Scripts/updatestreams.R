
#Aim of the script:

#When new player(s) signs up using the survey
#   1. Read list of current artists tracked from `artistdatabase`
#   2. Compute new stream values for each artist
#   3. Append new column of streams to `artistdatabase`


# Load Packages -----------------------------------------------------------


#devtools::install_github("liamhaller/spotifystreams", force = TRUE)
library(spotifystreams)
library(tidyverse)
library(googlesheets4)


# Authentication ----------------------------------------------------------

#initiate authentication
source(paste0(getwd(),'/Scripts/', 'googleauth.R'))

#Load local functions
source(paste0(getwd(),'/Scripts/', 'helper_functions.R'))



# Load Artist Database ----------------------------------------------------

### add Artists database ###
artistdatabase <- "https://docs.google.com/spreadsheets/d/18cLVfPIy0EAG3lQzxlSRDRAi5kGezcgML7BU3UkikF8/edit#gid=0"

#Add new column with streams of current date
todays_date <- as.character(as.Date(Sys.Date()))
artist_update <- read_sheet(artistdatabase) %>%
  rowwise() %>%
  mutate(streams = spotifystreams::get_monthly_listeners(artist_id)) %>%
  rename(!!todays_date := streams)


googlesheets4::sheet_write(ss =  artistdatabase,
                           data = artist_update,
                           sheet = 1)











