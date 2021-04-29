## Function to download  data and brick the bands.
# * URL: data download URL 
# * datadir: directory to extract the data to

dataExtraction <- function(URL, datadir, filename) {
  
  # create data folder if not yet existent
  if (!dir.exists(datadir)) {
    dir.create(datadir)
  }
  
  # download zip data
  ifelse(!file.exists(
    paste0(datadir, '/data.zip')), 
    download.file(url = URL, destfile = paste0(datadir, '/data.zip'), method = 'auto'), FALSE)
  
  # unzip data and remove zip file
  unzip(paste0(datadir, '/data.zip'), exdir = datadir)
  file.remove(paste0(datadir, '/data.zip'))
  
  # Load the Raster file
  LandsatImg <-stack(list.files(paste(datadir, filename, sep = '/'), pattern = glob2rx('*.TIF'), full.names = TRUE))
  
  # create a vector for the band names
  bands <- c("Band10","Band11", "Band2", "Band4", "Band5", "Band6")
  
  # names the bands in the raster stacks
  names(LandsatImg) <- bands
  
  # create a brick with the named bands
  LandsatBrick <- brick(LandsatImg)

  # return brickList
  return(LandsatBrick)
}


