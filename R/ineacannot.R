#' Starts the COBECORE meta-data annotator
#' 
#' The GUI to annotate COBECORE images.
#' 
#' @param path image location path
#' @keywords GUI, front end, interactive
#' @export
#' @examples
#' 
#' \dontrun{
#' # Starts the GUI
#' ineacannot(path = "~")
#' }

ineacannot <- function(path =  sprintf("%s/extdata",
                                       path.package("ineacannot"))){
  if(!requireNamespace(c("shiny"), quietly = TRUE)){
    stop("Packages are missing. Please install them.",
         call. = FALSE)
  }
  
  # assign global variable
  assign("path", path, envir = .GlobalEnv)
  
  # start app
  appDir = sprintf("%s/shiny/annotator", path.package("ineacannot"))
  suppressWarnings(shiny::runApp(appDir,
                                 display.mode = "normal",
                                 launch.browser = TRUE,
                                 quiet = TRUE))
}