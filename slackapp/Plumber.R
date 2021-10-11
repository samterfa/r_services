
Sys.setenv(TZ = 'America/Chicago')

# Documentation at .../__docs__/ (needs trailing slash!)

# For local testing
if(Sys.getenv('PORT') == '') Sys.setenv(PORT = 8000)

#' @apiTitle R Slack Integration
#' @apiDescription These endpoints allow the user to create custom functions in Slack which call R functions.

#* Launches our Slack App
#* @param req The request
#* @param res The response
#* @param text The text typed into Slack (If any)
#* @post /launch
#* @serializer text
function(req, res, text, ...){
  
  require(dplyr)
  require(slackme)
  
  source('scripts.R')
  
  print(Sys.getenv('slack_auth_token'))
  
  # Verify that request comes from Slack
  assertthat::assert_that(
    verify_request(request_timestamp = req$HTTP_X_SLACK_REQUEST_TIMESTAMP, 
                   request_signature = req$HTTP_X_SLACK_SIGNATURE, 
                   request_body_raw = req$bodyRaw,
                   signing_secret = Sys.getenv('slack_signing_secret'))
  )
  
  push_opening_view(req)
  
  return('')
}


#* Interacts with our Slack App
#* @param req The request
#* @param res The response
#* @param text The text typed into Slack (If any)
#* @post /interact
#* @serializer text
function(req, res, ...){
  
  require(dplyr)
  require(slackme)
  
  source('scripts.R')
  
  # Verify that request comes from Slack
  assertthat::assert_that(
    verify_request(request_timestamp = req$HTTP_X_SLACK_REQUEST_TIMESTAMP, 
                   request_signature = req$HTTP_X_SLACK_SIGNATURE, 
                   request_body_raw = req$bodyRaw,
                   signing_secret = Sys.getenv('slack_signing_secret'))
  )
  
  print(Sys.getenv('slack_auth_token'))
  
  push_next_view(req)
  
  return('')
}