## Function to calculate the overall correlation value between two raster layers
# * rasterStack: a RasterStack containing the layers to be correlated
overallCorrelation <- function(rasterStack){
  
  # calculate overall correlation value
  correlationValue <- cor(values(rasterStack)[,1],
                        values(rasterStack)[,2],
                        use = "na.or.complete")
  
  # return correlation
  return(correlationValue)
}