

remove.packages('spotifystreams')
#Load in functions to update streams
devtools::install_github("liamhaller/spotifystreams", force = TRUE, ref = "main", upgrade = TRUE )
library(spotifystreams)

#check current version
league_baseline

#update leage streams
spotifystreams::update_streams(league)

spotifystreams::

#save output to an RDS file
saveRDS(league, file = "league_jun_1.rds")

