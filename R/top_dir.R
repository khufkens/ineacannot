#' Find top most directory
#' 
#' From a vector of file locations
#' 
#' @param files vector with file locations
#' @keywords file locations, io
#' @export

top_dir <- function(files){
  unlist(lapply(strsplit(files, "/"), "[[", 1))
}