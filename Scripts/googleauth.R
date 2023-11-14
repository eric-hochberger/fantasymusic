#Googlesheets connect


library(googlesheets4)
library(gargle)

##Initial setup of secret token, done once

# # designate project-specific cache
# options(gargle_oauth_cache = ".secrets")
#
# # check the value of the option, if you like
# gargle::gargle_oauth_cache()
#
#
# # trigger auth on purpose --> store a token in the specified cache
# # a broswer will be opened
# googlesheets4::gs4_auth()
#
# # see your token file in the cache, if you like
# list.files(".secrets/")
#
#
# # deauth
# googlesheets4::gs4_deauth()

#To be run each time

# set values in options
options(
  gargle_oauth_cache = ".secrets",
  gargle_oauth_email = "musicleaguefantasy@gmail.com"
)

#run sheets auth
googlesheets4::gs4_auth()


