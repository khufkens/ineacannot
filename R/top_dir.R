#' Find top most directory
#' 
#' From a vector of file locations
#' 
#' @param files vector with file locations
#' @keywords file locations, io
#' @export

top_dir <- function(files){
  files <- normalizePath(files,
                         winslash = "/")
  file_parts <- strsplit(files, "/")
  location <- length(unlist(file_parts[1])) - 1
  unlist(lapply(file_parts, "[[", location))
}