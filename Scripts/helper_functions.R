#helper functions


parse_spotify_link <- function(link){

  artist_code <- strsplit(link, split =  "/")[[1]][5]
  return(artist_code)

}
parse_spotify_link <- Vectorize(parse_spotify_link)

#TODO
#notify removals function
