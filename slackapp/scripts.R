
push_opening_view <- function(req){
  
  views_open(token = Sys.getenv('slack_auth_token'), 
             trigger_id = req$body$trigger_id, 
             view = view_object(type = 'modal', 
                                title = text_object(type = 'plain_text', 
                                                    text = 'Testing', 
                                                    emoji = F), 
                                blocks = list(context_block(elements = list(image_element(image_url = 'https://api.time.com/wp-content/uploads/2019/03/kitten-report.jpg',
                                                                                          alt_text = 'Cutest Kitty')
                                ), 
                                block_id = 'action_button')), 
                                close = text_object(type = 'plain_text', 
                                                    text = 'Close', 
                                                    emoji = F), 
                                submit = text_object(type = 'plain_text', 
                                                     text = 'Next', 
                                                     emoji = F), 
                                private_metadata = '', 
                                callback_id = '', 
                                clear_on_close = F, 
                                notify_on_close = F, 
                                external_id = ''), 
             return_response = T)
}


push_next_view <- function(req){
  
  require(dplyr)
  require(slackme)
  require(jsonlite)
  
  payload <- jsonlite::fromJSON(req$body$payload, F, F, F, F)
  
  view_id <- payload$view$root_view_id
  view_hash <- payload$view$hash
  trigger_id <- payload$trigger_id
  
  next_modal <- list()
  next_modal$view <- read_json('next_modal.json')
 # next_modal$trigger_id <- trigger_id
  next_modal$response_action <- "update"
  
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
  
  next_modal %>% toJSON(auto_unbox = T)
}