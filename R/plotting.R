## Function for plotting

plotting <- function(givefilename, cols, ImgAu, mainAu, ImgSp, mainSp, ImgSu, mainSu, ImgWi, mainWi, givetext){
  png(filename=givefilename, width=800, height=500)
  par(mfrow=c(2,2))
  plot(ImgAu, legend = FALSE, main=mainAu, font.main=1, col=brewer.pal(n=15 , cols))
  plot(ImgSp, legend = FALSE, main=mainSp, font.main=1, col=brewer.pal(n=15 , cols))
  plot(ImgSu, legend = FALSE, main=mainSu, font.main=1, col=brewer.pal(n=15 , cols))
  plot(ImgWi, main=mainWi, font.main=1, col=brewer.pal(n=15 , cols))
  mtext(text = givetext, side = 1, line=-2, outer=TRUE, cex=2, font = 1)
  dev.off()
  return()
}
