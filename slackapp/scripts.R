
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
                                                     text = 'Submit', 
                                                     emoji = F), 
                                private_metadata = '', 
                                callback_id = '', 
                                clear_on_close = F, 
                                notify_on_close = F, 
                                external_id = ''), 
             return_response = T)
}

push_next_view <- function(req){
  
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
                                                     text = 'Submit', 
                                                     emoji = F), 
                                private_metadata = '', 
                                callback_id = '', 
                                clear_on_close = F, 
                                notify_on_close = F, 
                                external_id = ''), 
             return_response = T)
}