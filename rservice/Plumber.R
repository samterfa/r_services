
# Swagger docs at ...s/__swagger__/ (needs trailing slash!)
if(Sys.getenv('PORT') == '') Sys.setenv(PORT = 8000)

#' @apiTitle My R Service
#' @apiDescription This service runs scalable R scripts on Google Cloud Run.

#* Confirmation Message
#* @get /
#* @serializer text
function(msg=""){
  "My R Service Deployed!"
}


#* Number from Random Uniform Distribution
#* @param min Lower limit of the distribution.
#* @param max Upper limit of the distribution.
#* @get /runif
#* @serializer html
function(min, max){
  
  x <- runif(n = 1, min = min, max = max)
  
  paste0('<h3>', x, '</h3>')
}
