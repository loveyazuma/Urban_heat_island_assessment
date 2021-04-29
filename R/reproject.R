## Function to reproject boundary data using a raster layer.
# * vector: vector data that will be reprojected 
# * raster: raster data that reprojection will be based on

reproject <- function(vector){
  
  # define crs object based on Landsat8 projection
  projection <- st_crs('+proj=utm +zone=39 +datum=WGS84 +units=m +no_defs +ellps=WGS84 +towgs84=0,0,0')
  
  # perform coordinate transformation
  rprj <- st_transform(vector, crs = projection)
  
  # return rprj
  return(rprj)
  
}