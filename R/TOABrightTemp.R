## Function to compute Top of Atmosphere (TOA) Brightness Temperature
#         BT = K2 / ln (k1 / Lλ + 1) - 272.15
# Where:
# BT = Top of atmosphere brightness temperature (°C)
# Lλ = TOA spectral radiance (Watts/( m2 * sr * μm))
# K1 = K1 Constant Band (No.)
# K2 = K2 Constant Band (No.)

# * TOA_Radiance10: TOA spectral radiance results for Landsat thermal band 10
# * TOA_Radiance11: TOA spectral radiance results for Landsat thermal band 11

TOABrightTemp <- function(TOA_RadianceBand10, TOA_RadianceBand11){
  # read cvs file 
  metadata <- read.csv("./data/metadata.cvs")
  
  # get K1 constant and K2 constant values from metadata for BAND 10
  K1Const10 <- metadata$value[metadata$parameter == 'K1 Constant Band 10']
  K2Const10 <- metadata$value[metadata$parameter == 'K2 Constant Band 10']
  
  # get K1 constant and K2 constant values from metadata for BAND 11
  K1Const11 <- metadata$value[metadata$parameter == 'K1 Constant Band 11']
  K2Const11 <- metadata$value[metadata$parameter == 'K2 Constant Band 11']
  
  # calculate TOA Brightness Temperature
  BTBand10 <- calc(TOA_RadianceBand10, fun = function(x) {K2Const10 / log(K1Const10 / x + 1) - 272.15})
  BTBand11 <- calc(TOA_RadianceBand11, fun = function(x) {K2Const11 / log(K1Const11 / x + 1) - 272.15})
  
  # create a list of the brightness temperature results
  brightnessTemperatue <- c(BTBand10, BTBand11)
  
  # return brightnessTemperature
  return(brightnessTemperatue)
}