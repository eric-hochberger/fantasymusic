
library(purrr)
library(rvest)
library(rlang)

#check current version
league

#update leage streams
league <- update_streams(league)
namelist <- names(league)
#save output to csvs
for ( i in seq_along(league) ) {
  filename <- paste0("updates/",names(league)[i], ".csv")
  write.csv(league[[i]], file = filename, row.names = FALSE)
}

