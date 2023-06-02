
#Load in functions to update streams
devtools::install_github("liamhaller/spotifystreams", force = TRUE, ref = "main")
library(spotifystreams)

#check current version
league_baseline

#update leage streams
league <- spotifystreams::pdate_streams(league)
namelist <- names(league)

#save output to csvs
for ( i in seq_along(league) ) {
  filename <- paste0("updates/",names(league)[i], ".csv")
  write.csv(league[[i]], file = filename, row.names = FALSE)
}


