## Function to plot linear model in a plot contatining 4 linear model results
# * rasterStack1: linear Model - prediction result
# * col1: character string - colour code
# * col2: character string - colour code
# * title: character string - title of the graph

linearModelPlot <- function(linearModel, col1, col2, title){
  
  
  # plot rasterStack1
  resid_lm_dat <- SDMSelect::gplot_data(
    linearModel, maxpixels = 50000) %>%
    mutate(variable = "Residuals") %>%
    filter(!is.na(value))
  
  gplot <- ggplot(resid_lm_dat) +
           geom_tile(aes(x, y, fill = value)) +
           scale_fill_gradient2("Residuals",
                                   low = col1,
                                   high = col2,
                                   midpoint = 0) +
           
          labs(title = title)+
          annotation_scale(location = "bl", width_hint = 0.5)+
          theme(plot.title = element_text(face = "bold.italic", 
                                          hjust = 0.5, 
                                          color= "black",
                                          family = "DejaVu Serif",
                                          size = 18)) +
           coord_quickmap(
                xlim = range(resid_lm_dat$x),
                ylim = range(resid_lm_dat$y)
           ) +
          annotation_north_arrow(location = "bl", which_north = "true", 
                                 pad_x = unit(0.75, "in"), pad_y = unit(0.5, "in"),
                                 style = north_arrow_fancy_orienteering) +
          xlab("") + ylab("")
  
  return(gplot)
  
}
