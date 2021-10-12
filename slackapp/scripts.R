
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