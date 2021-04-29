## Function to discard the clouds from the raster images
# * rasterImg: a raster layer the cloud mask will be performed on
# * Blue_band: a raster layer - blue band
# * TIRI_band: a raster layer - TIR band 10
  
cloudAreaMask <- function(rasterImg, Blue_band, TIR1_band){
    
    # Detect cloud areas
    cmsk = cloudMask(rasterImg, threshold = .2, blue = Blue_band, tir = TIR1_band)
    
    # Mask clouds from the raster images
    TehranCloudMask = mask(rasterImg, cmsk$CMASK, maskvalue= 1)
    
    # return TehranCloudMask
    return(TehranCloudMask)
  }
