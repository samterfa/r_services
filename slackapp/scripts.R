# Based on instructions from https://api.slack.com/authentication/verifying-requests-from-slack
verify_request <- function(request_timestamp, request_signature, request_body_raw, signing_secret, version = 'v0'){
  
  library(dplyr)
  
  # Compute request signature
  sig <- paste0(version, '=',
                paste(version,
                      request_timestamp,
                      request_body_raw %>% rawToChar(),
                      sep = ':') %>%
                  digest::hmac(key = signing_secret,
                               object = .,
                               algo = 'sha256',
                               serialize = F)
  )
  
  # Make sure the request was recent and this isn't a replay attack.
  if(abs(as.numeric(Sys.time()) - as.numeric(request_timestamp)) > 60*5){
    stop("Code 425 - Possible Replay Attack")
  }
  
  # Check for a match between the computed signature and the signature header.
  if(!identical(sig, request_signature)){
    stop("Code 401 - Authentication required")
  }
  
  # Return true for verified request.
  T
}

push_opening_view <- function(req){
  
  library(jsonlite)
  library(httr)
  
  # Get trigger id from the request body.
  trigger_id <- req$body$trigger_id
  
  # Define payload for the views.open method.
  payload <- list()
  payload$view <- read_json('opening_modal.json')
  payload$trigger_id <- trigger_id
  
  # Pull environmental variable storing our app's auth token.
  token <- Sys.getenv('slack_auth_token')
  
  # Make the post request sending the payload to Slack.
  response <- httr::POST('https://slack.com/api/views.open', 
                         body = payload %>% jsonlite::toJSON(auto_unbox = T), 
                         encode = 'json', 
                         httr::content_type_json(), 
                         httr::add_headers(Authorization = glue::glue('Bearer {token}')))
  
  # Check the response content for errors.
  result <- httr::content(response)
  
  if(!result$ok){
    stop(result$error)
  }
  
  # Return the response content
  result
}


push_next_view <- function(req){
  
  library(jsonlite)
  library(httr)
  
  payload <- jsonlite::fromJSON(req$body$payload, F, F, F, F)
  
  view_id <- payload$view$root_view_id
  view_hash <- payload$view$hash
  trigger_id <- payload$trigger_id
  
  # Define payload for the views.open method.
  payload <- list()
  payload$view <- read_json('next_modal.json')
  payload$trigger_id <- trigger_id
  
  # Pull environmental variable storing our app's auth token.
  token <- Sys.getenv('slack_auth_token')
  
  # Make the post request sending the payload to Slack.
  response <- httr::POST('https://slack.com/api/views.push', 
                         body = payload %>% jsonlite::toJSON(auto_unbox = T), 
                         encode = 'json', 
                         httr::content_type_json(), 
                         httr::add_headers(Authorization = glue::glue('Bearer {token}')))
  
  # Check the response content for errors.
  result <- httr::content(response)
  
  # if(!result$ok){
  #   stop(result$error)
  # }
  
  # Return the response content
  result
}