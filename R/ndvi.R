## This function calculates the Normalized Differential Vegetation Index (NDVI) which is a standardized vegetation index calculated using NearInfra-red and Red bands.
#                     NDVI = (NIR – RED) / (NIR + RED)
# Where:
# RED= DN values from the RED band
# NIR= DN values from Near-Infrared band
# * NIR: Near-Infra-red Band
# * RED: Red band 

ndvi <- function(NIR, RED){
  
  # calculate NDVI 
  calNDVI <- (NIR - RED) / (NIR + RED)
  
  #return NDVI
  return(calNDVI)
}