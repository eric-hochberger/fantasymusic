
#upload most recent version of spotifystreams package
devtools::install_github("liamhaller/spotifystreams", force = TRUE, ref = "main")
library(spotifystreams)

#check current version
league

#update leage streams
league <- spotifystreams::update_streams(league)


# designate project-specific cache
options(gargle_oauth_cache = ".secrets")
# check the value of the option, if you like
gargle::gargle_oauth_cache()


# trigger auth on purpose to store a token in the specified cache
# a broswer will be opened
googlesheets4::gs4_auth(
  cache = ".secrets",
  email = "musicleaguefantasy@gmail.com"
)

gs4_deauth()
gs4_has_token()

spotifystreams::update_sheets(list = league, updated_coulmn = 4,
                              sheet_id = "1GtLYZJ3OcywTGT75LMIXJwogC5CJx_biGl5l0MuVLM4",
                              auth_token = token)






















#save output to csvs
for ( i in seq_along(league) ) {
  filename <- paste0("updates/",names(league)[i], ".csv")
  write.csv(league[[i]], file = filename, row.names = FALSE)
}


