
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
  
  print(Sys.getenv('slack_auth_token'))
  print(req$body$trigger_id)
  
  response <- rSlack::views_open(token = Sys.getenv('slack_auth_token'), 
                     trigger_id = req$body$trigger_id, 
                     view = rSlack::view_object(type = 'modal', 
                                        title = rSlack::text_object(type = 'plain_text', text = 'Testing'), 
                                        blocks = list(rSlack::button_element(text = rSlack::text_object(type = 'plain_text', 
                                                                                                        text = 'This is a button')))))
  
  print(response)
  print(httr::content(response))
  
  return('')
}
