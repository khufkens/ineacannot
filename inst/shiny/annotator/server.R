
# Define server logic ----
server <- function(input, output, session) {
  
  # populate UI fields using a row number (assuming the data is loaded)
  populate_fields <- function(row_number){
    output$location <- renderText({ 
      data$location[row_number]
    })
    
    output$filename <- renderText({ 
      basename(data$files[row_number])
    })
    
    output$myImage <- renderImage({
      list(src = as.character(data$files[row_number]),
           width = "100%")
    }, deleteFile = FALSE)
    
    observe({
      
      # grab dynamic data
      data <- db()

      output$total_images <- renderInfoBox({
        infoBox(
          "Images", nrow(data), icon = icon("list"),
          color = "orange"
        )
      })
      
      output$progress <- renderInfoBox({
        infoBox(
          "progress", paste(100 * length(which(data$status == TRUE))/nrow(data), "%"),
          icon = icon("list"),
          color = "orange"
        )
      })
      
      # update the data table in the explorer
      output$table = DT::renderDataTable({
        tmp = data[,2:ncol(data)]
        return(tmp)
      },
      selection = "single",
      options = list(lengthMenu = list(c(10, 20), c('10', '20'))),
      extensions = c('Responsive'))
    
      # general parameters
      updateTextInput(session, "station",
                      value = data$station[row_number])
      updateTextInput(session, "number",
                      value = data$number[row_number])
      updateTextInput(session, "lat",
                      value = data$lat[row_number])
      updateTextInput(session, "lon",
                      value = data$lon[row_number])
      updateTextInput(session, "month",
                      value = data$month[row_number])
      updateTextInput(session, "year",
                      value = data$year[row_number])
      updateTextInput(session, "t_min",
                      value = data$t_min[row_number])
      updateTextInput(session, "t_max",
                      value = data$t_max[row_number])
      updateTextInput(session, "precip",
                      value = data$precip[row_number])
      updateTextInput(session, "precip_intensity",
                      value = data$precip_intensity[row_number])
      updateTextInput(session, "psy_temp_dry",
                      value = data$psy_temp_dry[row_number])
      updateTextInput(session, "psy_temp_humid",
                      value = data$psy_temp_humid[row_number])
      updateTextInput(session, "relative_humidity",
                      value = data$relative_humidity[row_number])
      updateTextInput(session, "evapometre_de_piche",
                      value = data$evapometre_de_piche[row_number])
      updateTextInput(session, "temp_du_bar",
                      value = data$temp_du_bar[row_number])
      updateTextInput(session, "haut_bar_luc",
                      value = data$haut_bar_luc[row_number])
      updateTextInput(session, "t1",
                      value = data$t1[row_number])
      updateTextInput(session, "t2",
                      value = data$t2[row_number])
      updateTextInput(session, "t3",
                      value = data$t3[row_number])
      updateTextInput(session, "actino",
                      value = data$actino[row_number])
      updateTextInput(session, "hygro",
                      value = data$hygro[row_number])
      updateTextInput(session, "cloud_type",
                      value = data$cloud_type[row_number])
      updateTextInput(session, "nebulosity",
                      value = data$nebulosity[row_number])
      })
  }
  
  # make this reactive otherwise this will not function
  write_annotations <- function(row_number){
    
    # grab current data
    data <- db()
    
    # update the data
    # general parameters
    data$station[row_number] <- input$station
    data$number[row_number] <- input$number
    data$lat[row_number] <- input$lat
    data$lon[row_number] <- input$lon
    data$month[row_number] <- input$month
    data$year[row_number] <- input$year
    
    # climate variables
    data$t_min[row_number] <- input$t_min
    data$t_max[row_number] <- input$t_max
    data$precip[row_number] <- input$precip
    data$precip_intensity[row_number] <- input$precip_intensity
    data$psy_temp_dry[row_number] <- input$psy_temp_dry
    data$psy_temp_humid[row_number] <- input$psy_temp_humid
    data$relative_humidity[row_number] <- input$relative_humidity
    data$evapometre_de_piche[row_number] <- input$evapometre_de_piche
    data$temp_du_bar[row_number] <- input$temp_du_bar
    data$haut_bar_luc[row_number] <- input$haut_bar_luc
    data$t1[row_number] <- input$t1
    data$t2[row_number] <- input$t2
    data$t3[row_number] <- input$t3
    data$actino[row_number] <- input$actino
    data$hygro[row_number] <- input$hygro
    data$cloud_type[row_number] <- input$cloud_type
    data$nebulosity[row_number] <- input$nebulosity
    data$status[row_number] <- TRUE
    
    # write basic file to disk to save
    # progress incrementally
    write.table(data,
                meta_data_file,
                quote = FALSE,
                row.names = FALSE,
                col.names = TRUE,
                sep = ",")  
    
    # re-assign data to the reactive element
    db(data)
  }
  
  # load path
  path <- get("path", envir = .GlobalEnv)
  
  # create location meta-data file
  meta_data_file <- file.path(path, "meta_data.csv")
  
  # check if a meta-data file exists
  if(!file.exists(file.path(path, "meta_data.csv"))){
    
    # list all png files
    files <- normalizePath(list.files(path,"*.jpg",
                        full.names = TRUE,
                        recursive = TRUE), winslash = "/")
    
    # check if there are files to process, if not exit app
    # else assign to data frame
    if(length(files)==0){
      message("No image files found in the specified directory!")
      stopApp()
    } else {
      data <- as.data.frame(files, stringsAsFactors = FALSE)
    }
    
    # create base path field
    data$location <- top_dir(data$files)
    
    # general parameters
    data$station <- NA
    data$number <- NA
    data$lat <- NA
    data$lon <- NA
    data$month <- NA
    data$year <- NA
    
    # climate variables
    data$t_min <- NA
    data$t_max <- NA
    data$precip <- NA
    data$precip_intensity <- NA
    data$psy_temp_dry <- NA
    data$psy_temp_humid <- NA
    data$relative_humidity <- NA
    data$evapometre_de_piche <- NA
    data$temp_du_bar <- NA
    data$haut_bar_luc <- NA
    data$t1 <- NA
    data$t2 <- NA
    data$t3 <- NA
    data$actino <- NA
    data$hygro <- NA
    data$cloud_type <- NA
    data$nebulosity <- NA
    data$status <- NA
    
    # write basic file to disk as not to
    # index data on the next pass
    write.table(data,
                meta_data_file,
                quote = FALSE,
                row.names = FALSE,
                col.names = TRUE,
                sep = ",")
  } else {
    data <- read.table(meta_data_file,
               sep = ",",
               header = TRUE,
               stringsAsFactors = FALSE)
  }
  
  # find the first empty slot
  data$status <- apply(data,1,function(x){
    ifelse(all(is.na(x[3:24])), FALSE, TRUE)
  })
  
  if(all(data$status == TRUE)){
    message("All data is processed, exiting the annotation interface.")
    stopApp()
  }
  
  # create reactive data store
  db <- reactiveVal()
  
  # fill reactive database on startup
  db(data)
  
  # locate first unprocessed image, set this as the
  # starting row location
  row_location <- reactiveVal()
  row_location(which(data$status == 0)[1])
  
  # load first image
  populate_fields(row_location())
  
  # watch submit button
  observeEvent(input$submit, {
    
    # write data to file
    write_annotations(row_location())
    
    # increment row location
    old_value = row_location()
    row_location(old_value + 1)
    
    # populate fields and display image
    populate_fields(row_location())
  })
  
  # watch the back button
  observeEvent(input$back, {
    old_value = row_location()
    row_location(old_value - 1)
    populate_fields(row_location())
  })
}