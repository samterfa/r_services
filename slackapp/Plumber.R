
source('Slack.R')
source('GCP.R')

require(dplyr)

# Grab project number from Google Compute Engine metadata.  See https://cloud.google.com/compute/docs/storing-retrieving-metadata for details.
if(gargle:::detect_gce()){
  # For deployed app.
  print('Loading project information from GCE.')
  project_number <- gargle:::gce_metadata_request('project/numeric-project-id') %>% httr::content() %>% rawToChar()
  project_id <- gargle:::gce_metadata_request('project/project-id') %>% httr::content() %>% rawToChar()
}else{
  #  For local testing, define google_cloud_project_number in .Renviron file.
  print('Loading project information from environment.')
  project_number <- Sys.getenv('google_cloud_project_number')
  project_id <- Sys.getenv('google_cloud_project_id')
}

secretsToLoad <- c('slack_json')
preloadSecrets(secrets = secretsToLoad, project_number = project_number)

# Swagger docs at ...s/__swagger__/ (needs trailing slash!)
if(Sys.getenv('PORT') == '') Sys.setenv(PORT = 8000)

#' @apiTitle R Slack Integration
#' @apiDescription These endpoints allow the user to create custom functions in Slack which call R functions.

#* Initiates our Slack App
#* @param req The request
#* @param res The response
#* @param text The text typed into Slack (If any)
#* @post /slackapp
#* @serializer text
function(req, res, text, ...){
  
  require(dplyr)
  
  print('Slack Request Incoming')
  
  res <- checkSlackAuth(req, res)
  
  response <- views_open(token = Sys.getenv('slack_auth_token'), 
                         trigger_id = req$body$trigger_id, 
                         view = view_object(type = 'modal', 
                                            title = text_object(type = 'plain_text', 
                                                                text = 'Testing', 
                                                                emoji = F), 
                                            blocks = list(actions_block(elements = list(button_element(text = text_object(type = 'plain_text', 
                                                                                                                          text = 'Test Paragraph', 
                                                                                                                          emoji = F), 
                                                                                                       action_id = 'button', 
                                                                                                       url = 'https://www.google.com', 
                                                                                                       value = 'testing', 
                                                                                                       style = 'primary', 
                                                                                                       confirm = confirm_object(title = text_object(type = 'plain_text', 
                                                                                                                                                    text = 'Confirm Title'), 
                                                                                                                                confirm = text_object(type = 'plain_text', 
                                                                                                                                                      text = 'Confirm'), 
                                                                                                                                deny = text_object(type = 'plain_text', 
                                                                                                                                                   text = 'Cancel', 
                                                                                                                                                   emoji = F), 
                                                                                                                                text = text_object(type = 'plain_text', 
                                                                                                                                                   text = 'help text', 
                                                                                                                                                   emoji = F), 
                                                                                                                                style = 'primary'))), 
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
  
  print(response)
  print(httr::content(response))
  
  return('')
}
