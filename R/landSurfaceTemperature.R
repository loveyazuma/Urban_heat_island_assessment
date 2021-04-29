# This function calculates the Land Surface Temperature (LST) using Top of atmosphere brightness temperature, wavelength of emitted radiance, Land Surface Emissivity.
#       LST = (BT / 1) + W * (BT / 14380) * ln(E)
# Where:
# BT = Top of atmosphere brightness temperature (°C)
# W = Wavelength of emitted radiance
# E = Land Surface Emissivity

# * TOA_BT: a raster layer which is the Top of atmosphere brightness temperature
# * wavelength: an integer which is the wavelenght of emiited radiance in micrometer
# * LSE: a raster layer which is the land surface emissivity

landSurfaceTemperature <- function(TOA_BT, wavelength, LSE){
  
  # calculate the Land Surface Temperature as LST
  LST <- (TOA_BT / 1) + wavelength * (TOA_BT / 14380) * log(LSE)
  
  # return LST
  return(LST)
}