
# Preload secrets into environmental variables during build. For local testing, define google_cloud_project_number in .Renviron file.
preloadSecrets <- function(secrets, project_number = Sys.getenv('google_cloud_project_number')){
  
  require(dplyr)
  
  if(!dir.exists('.secrets')) dir.create('.secrets')
  
  # Either grabs local credentials file for local testing or default service account credentials from cloud build.
  token <- gargle::token_fetch(scopes = 'https://www.googleapis.com/auth/cloud-platform', path = '.secrets/secret_manager.json')
  
  for(secret in secrets){
    
    endpt <- glue::glue('v1beta1/projects/{project_number}/secrets/{secret}/versions/latest:access')
    
    req <- gargle::request_build(method = 'GET', path = endpt, base_url = 'https://secretmanager.googleapis.com/', token = token)
    
    res <- gargle::request_make(req)
    
    print(res)
    
    secret_val <- httr::content(res)$payload$data %>% base64enc::base64decode() %>% rawToChar() %>% jsonlite::fromJSON()
    
    # By convention in Google Secret Manager, if object has JSON structure...
    if(grepl('_json', secret)){
      
      # Grab each key and preload as environment variable.
      for(name in names(secret_val)){
        eval(parse(text = glue::glue('Sys.setenv({name} = "{secret_val[name]}")')))
      }
      
      # ... else value was plain text.
    }else{
      
      # Grab value and preload as environment variable.
      eval(parse(text = glue::glue('Sys.setenv({name} = "{secret_val}")')))
      
    }
  }
}


