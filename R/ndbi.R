## Function that calculate the Normalized Difference Built-Up Index (NDBI) that 
 # highlights urban areas where there is a higher reflectance in the shortwave-infrared (SWIR) region (with a SWIR band between 1.55-1.75 µm), 
 # compared to the near-infrared (NIR) region.
#                     NDVI = (SWIR - NIR) / (SWIR + NIR)
# Where:
# SWIR= DN values from the Shortwave-infrared band
# NIR= DN values from Near-Infrared band
# * SWIR: Shortwave-infrared
# * NIR: Near-Infra-red Band

ndbi <- function(SWIR, NIR){
  
  # calculate NDBI 
  calcNDBI <- (SWIR - NIR) / (SWIR + NIR)
  
  #return NDBI
  return(calcNDBI)
}