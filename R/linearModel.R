## Function to estimate a linear model.To have a look at the spatial heterogeneity, showing where observations deviates from the model.
# * rasterStack: a RasterStack containing the layers to be modeled

linearModel <- function(rasterStack){
  
  # Estimate a linear model, using NDVI or NDBI as a linear predictor for LST
  lm1 <- lm(values(rasterStack)[,2] ~ values(rasterStack)[,1])
  
  # Retrieve residuals considering missing values
  resid_lm <- raster(rasterStack, 1) * NA
  values(resid_lm)[-lm1$na.action] <- lm1$residuals
  
  # return resid_lm
  return(resid_lm)
}

