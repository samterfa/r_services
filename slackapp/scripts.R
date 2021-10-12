
push_opening_view <- function(req){
  
  library(jsonlite)
  library(httr)
  
  trigger_id <- req$body$trigger_id
  
  opening_view <- list()
  opening_view$view <- read_json('opening_modal.json')
  opening_view$trigger_id <- trigger_id
  
  token <- Sys.getenv('slack_auth_token')
  
  print(token)
  
  response <- httr::POST('https://slack.com/api/views.open', 
                         body = opening_view %>% jsonlite::toJSON(auto_unbox = T), 
                         encode = 'json', 
                         httr::content_type_json(), 
                         httr::add_headers(Authorization = glue::glue('Bearer {token}')))
  
  body <- httr::content(response)
  
  print(body)
  
  # if(!body$ok){
  #   stop(body$error)
  # }
  
  body
}


push_next_view <- function(req){
  
  require(dplyr)
  require(slackme)
  require(jsonlite)
  
  payload <- jsonlite::fromJSON(req$body$payload, F, F, F, F)
  
  view_id <- payload$view$root_view_id
  view_hash <- payload$view$hash
  trigger_id <- payload$trigger_id
  
#  next_modal <- list()
#  next_modal$view <- read_json('next_modal.json')
 # next_modal$trigger_id <- trigger_id
#  next_modal$response_action <- "update"
  
  next_modal <- read_json('next_modal.json')
  
  # response <- httr::POST('https://slack.com/api/views.push', 
  #                        
  #                        body =  next_modal %>% toJSON(auto_unbox = T), 
  #                        
  #                        encode = 'json', 
  #                        
  #                        httr::content_type_json(), 
  #                        
  #                        httr::add_headers(Authorization = glue::glue('Bearer {Sys.getenv("slack_auth_token")}')))
  # 
  # print(httr::content(response))
  
  next_modal #%>% toJSON(auto_unbox = T)
}