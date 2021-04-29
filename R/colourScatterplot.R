## Function to plot scatterplot
# * rasterStack: linear Model - prediction result
# * x_label: character string - x-axis label
# * y_label: character string - y-axis label
# * title: character string - title of the graph

colourScatterplot <- function(rasterStack, x_label, y_label, title){
  
  # convert raster to dataframe and remove NA values
  rasterDF <- na.omit(as.data.frame(rasterStack))
  
  # get a random sample
  rasterDF <- rasterDF[sample(nrow(rasterDF), 10000), ]
  
  # plot scatterplot
  ggplot(rasterStack, aes(layer.1, layer.2))+
    geom_point(alpha = 0.1, color = "orange")+
    labs(x= x_label, y = y_label, title = title)+
    stat_ellipse()

  
}

