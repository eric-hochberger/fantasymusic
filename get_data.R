


#check current version
league

#update leage streams
league <- update_streams(league)

#save output to an RDS file
saveRDS(league, file = "league_jun_1.rds")

