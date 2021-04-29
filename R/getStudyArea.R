#  This function gets the extent of Tehran, Iran  
getStudyArea <- function(){
  
  # Create data folder to store downloaded data if not yet existent
  if (!dir.exists('data')) {
    dir.create('data')
  }

  # Download data to data folder if not yet present
  if (!file.exists('/data')) {
    download.file(url = 'https://www.dropbox.com/s/sl89c2rspz2yznv/TehranCity.kml?dl=1', destfile = 'data/vector.kml', method = 'auto')
  }

  # Read kml file 
  TehranCity <- st_read("data/vector.kml")
  
  # keep only useful columns in dataframe
  keepCol <- c('name_en')
  TehranCity <- TehranCity[1:22, keepCol, drop = FALSE]
  
  # create a union of all the polygons
  TehranCity <- st_union(TehranCity)
  
  TehranCity <-  st_as_sf(TehranCity)
  
  return(TehranCity)
}

