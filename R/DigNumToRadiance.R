## Function to convert pixels digital number (DN) to TOA spectral radiance by using the radiance rescaling factor
#         Lλ = ML * Qcal + AL
# Where:
#  Lλ = TOA spectral radiance (Watts/ (m2 * sr * μm))
#  ML = Radiance multiplicative Band (No.)
#  AL = Radiance Add Band (No.)
#  Qcal = Quantized and calibrated standard product pixel values (DN)

# * raster: raster data that the conversion will be based on

DigNumToRadiance <- function(raster){
  
  # read cvs file 
  metadata <- read.csv("./data/metadata.cvs")
  
  # get radiance multiplicative band and radiance add band values from metadata
  radAddBand <- metadata$value[metadata$parameter == 'Radiance Add Band 10']
  radMultiBand <- metadata$value[metadata$parameter == 'Radiance Mult Band 10']
  
  # compute TOA spectral radiance
  TOA_spectral_radiance <- calc(raster, fun=function(x){radMultiBand* x + radAddBand})

  # return TOA_spectral_radiance
  return(TOA_spectral_radiance)
}