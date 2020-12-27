
# Based on instructions found here: https://api.slack.com/authentication/verifying-requests-from-slack
checkSlackAuth <- function(req, res){

  require(dplyr)

  sig <- paste0('v0=',
                paste('v0',
                      req$HTTP_X_SLACK_REQUEST_TIMESTAMP,
                      req$bodyRaw %>% rawToChar(),
                      sep = ':') %>%
                  digest::hmac(key = Sys.getenv('slack_signing_secret'),
                               object = .,
                               algo = 'sha256',
                               serialize = F)
  )

  if(abs(as.numeric(Sys.time()) - as.numeric(req$HTTP_X_SLACK_REQUEST_TIMESTAMP)) > 60*5){
    res$status <- 425 # Possible Replay
    return("Possible Replay Attack")
  }

  if(sig != req$HTTP_X_SLACK_SIGNATURE){
    res$status <- 401 # Unauthorized
    return("Authentication required")
  }

  res
}
