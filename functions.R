
#Functions now in the spotifystreams package


# #Given an artist spotify code, return current monthly listeners
# get_monthly_listeners <- function(artist_code){
#
#   #Spotify link to artists page
#   artist_url <- paste0("https://open.spotify.com/artist/", artist_code)
#
#   #Load html data from spotify page in enviroment
#   web <- rvest::read_html(artist_url)
#
#   #select all text within div content
#   div_content <- web %>% html_elements("div") %>% html_text()
#
#   #10th item in the vector contains stream info
#   monthly_streams <- div_content[10]
#
#   #seperate text from "monthly listerers"
#   monthly_streams <- strsplit(monthly_streams, split = " ")
#   #subset list, and then vector to get first element
#   monthly_streams <- monthly_streams[[1]][1]
#   #remove the comma so we can convert to numeric
#   monthly_streams <- as.numeric(gsub(",", "", monthly_streams))
#
#   return(monthly_streams)
# }
#
#
# #wrapper for the monthly stream function to more
# #easily use sapply to vectorize the function
# list_get_monthly_listerns <- function(dataframe){
#
#   #second column of each persn's dataframe is wherethe
#   #artist codes are, this is clunky, sure, but it was fast
#   codes <- dataframe[,2]
#
#   #Apply monthly listens to each row and remove the name
#   listens <- unname(sapply(codes , get_monthly_listeners))
#
#   return(listens)
#
# }
#
#
# #given the league (list of dataframes), This will add a column to each
# #persons dataframe with the daily updated stream numbers
# update_streams <- function(list){
#
#   #Get current date for column title
#   col_title <- format(Sys.Date(), "%D")
#
#   #need number of columsn to change the column name after
#   n_col <- ncol(league[[1]]) + 1 #total columns post update
#
#   #Get updated value of streams for all league members
#   update <- map(list, list_get_monthly_listerns)
#
#   #update values in list & change name of column
#   for(i in seq_along(league)){
#     #create a new column in the league member database
#     list[[i]]$placeholder <- update[[i]]
#
#     #set column title to the date (you would not belive how complicated this was)
#     names <- colnames(list[[i]])
#     names[n_col] <-  enexpr(col_title)
#     colnames(list[[i]]) <- names
#
#   }
#   return(list)
# }
#
#
#
#
#
#
