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
function(min = 0, max = 1){
  
  x <- runif(n = 1, min = as.numeric(min), max = as.numeric(max))
  
  paste0('<h3>', x, '</h3>')
}

#* iris datatable
#* @get /iris
#* @serializer htmlwidget
function(){
  
  DT::datatable(iris)
}
