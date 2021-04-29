## This Function calculates the Land Surface Emissivity (LSE) (i.e. average emissivity of an element of the surface of the Earth) from NDVI values.

# first, it calculates Proportion of Vegetation 
#           PV = [(NDVI – NDVI min) / (NDVI max + NDVI min)]^2
# Where:
# PV = Proportion of Vegetation
# NDVI = DN values from NDVI Image
# NDVI min = Minimum DN values from NDVI Image
# NDVI max = Maximum DN values from NDVI Image

# Second, it calculates the LSE
#     E = 0.004 * PV + 0.986
# Where:
# E = Land Surface Emissivity
# PV = Proportion of Vegitation

# * NDVI: raster layer
# * NDVI_min: integer, minimum values ofthe NDVI raster layer
# * NDVI_max: integer, maximum values ofthe NDVI raster laye

landSurfaceEmissivity <- function(NDVI, NDVI_min, NDVI_max){
  
  # calculate Proportion of Vegetation as PV
  PV <- (NDVI - NDVI_min) / (NDVI_max + NDVI_min) ^ 2
  
  # calculate land surface emissivity as LSE
  LSE <- 0.004 * PV + 0.986
  
  # return LSE
  return(LSE)
}