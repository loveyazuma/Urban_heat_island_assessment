# Function that created a crop within a given extent area
cropImages <- function(rasterBrick, extentArea){
  
  # Create crop
  createCrop <- crop(rasterBrick, extentArea)
  
  createMask <-  mask(createCrop, extentArea)
  return(createMask)
}