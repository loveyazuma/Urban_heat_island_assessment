# Check availability of libraries
list.of.packages <- c("satellite", "rgdal", "raster", "sf", "sp", "RStoolbox", "ggplot2", "extrafont", "devtools", "magrittr", "dplyr", "maps", "ggspatial", "RColorBrewer")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)>0) {install.packages(new.packages)}

install.packages('devtools')
devtools::install_github("statnmap/SDMSelect", force = TRUE)
devtools::install_github("statnmap/SDMSelect")

# Load libraries
library(rgdal)
library(raster)
library(sp)
library(sf)
library(satellite)
library(RStoolbox)
library(ggplot2)
library(extrafont)
font_import()
library(magrittr)
library(SDMSelect)
library(dplyr)
library(maps)
library(ggspatial)
library(RColorBrewer)


# Source external functions
# ----Pre-processing Functions----
source('./R/dataExtraction.R')
source('./R/getStudyArea.R')
source('./R/reproject.R')
source('./R/cropImages.R')
source('./R/cloudAreaMask.R')
# ----Analysis Functions----
source('./R/DigNumToRadiance.R')
source('./R/TOABrightTemp.R')
source('./R/ndvi.R')
source('./R/landSurfaceEmissivity.R')
source('./R/landSurfaceTemperature.R')
source('./R/ndbi.R')
source('./R/overallCorrelation.R')
source('./R/linearModel.R')
# ----Visualisation Functions----
source('./R/colourScatterplot.R')
source('./R/linearModelPlot.R')
source('./R/plotting.R')

########################## PRE-PROCESSING ##########################

# create output folder if not yet existent
# initialize output directory 
outputdir <- 'output'

if (!dir.exists(outputdir)) {
  dir.create(outputdir)
}

# initialize data directory 
datadir <- 'data'

# Download the required raster data, extract and brick them
AutumunImg <- dataExtraction('https://www.dropbox.com/s/zg078whpborr2m2/autumn.zip?dl=1', datadir, 'autumn')
SpringImg <- dataExtraction('https://www.dropbox.com/s/upsq1uzipp7x5mw/spring.zip?dl=1', datadir, 'spring')
SummerImg <- dataExtraction('https://www.dropbox.com/s/vkbfdo5s5r5reas/summer.zip?dl=1', datadir, 'summer')
WinterImg <- dataExtraction('https://www.dropbox.com/s/t5hc753vl43o31s/winter.zip?dl=1', datadir, 'winter')

# Get Tehran boundary
Tehran <- getStudyArea()

# Reproject the boundary data to the same as the raster data
Tehranproj <- reproject(Tehran)

# Crop the bricks to the boundary size
# ** Autumn
TehranAutumn <- cropImages(AutumunImg, Tehranproj)
TehranAutumn <- crop(TehranAutumn, extent(Tehranproj))

# ** Spring
TehranSpring <- cropImages(SpringImg, Tehranproj)
TehranSpring <- crop(TehranSpring, extent(Tehranproj))

# ** Summer
TehranSummer <- cropImages(SummerImg, Tehranproj)
TehranSummer <- crop(TehranSummer, extent(Tehranproj))

# ** Winter
TehranWinter <- cropImages(WinterImg, Tehranproj)
TehranWinter <- crop(TehranWinter, extent(Tehranproj))

# Remove temporary files
remove(AutumunImg)
remove(SpringImg)
remove(SummerImg)
remove(WinterImg)

# Mask out Clouds for the Winter Image
# ** Winter
TehranWinter <- cloudAreaMask(TehranWinter, 3, 1)

########################## CALCULATION and ANALYSIS ##########################

## Get metadata
metadata <- download.file('https://www.dropbox.com/s/t67t6zrr4sra5vg/metadata.cvs?dl=1', destfile = paste0(datadir, '/metadata.cvs'), method = 'auto')

## -------------------------Land Surface Temperature-------------------------

### STEP ONE: Top of Atmosphere (TOA) Radiance

# ** Autumn
TOA_Radiance10Autumn <- DigNumToRadiance(TehranAutumn[[1]])
TOA_Radiance11Autumn <- DigNumToRadiance(TehranAutumn[[2]])

# ** Spring
TOA_Radiance10Spring <- DigNumToRadiance(TehranSpring[[1]])
TOA_Radiance11Spring <- DigNumToRadiance(TehranSpring[[2]])

# ** Summer
TOA_Radiance10Summer <- DigNumToRadiance(TehranSummer[[1]])
TOA_Radiance11Summer <- DigNumToRadiance(TehranSummer[[2]])

# ** Winter
TOA_Radiance10Winter <- DigNumToRadiance(TehranWinter[[1]])
TOA_Radiance11Winter <- DigNumToRadiance(TehranWinter[[2]])

### STEP TWO: Top of Atmosphere (TOA) Brightness Temperature

# ** TOA_Brightness Temperature Autumn
brightTemperatureAutumn <- TOABrightTemp(TOA_Radiance10Autumn, TOA_Radiance11Autumn)

# ** TOA_Brightness Temperature Spring
brightTemperatureSpring <- TOABrightTemp(TOA_Radiance10Spring, TOA_Radiance11Spring)

# ** TOA_Brightness Temperature Summer
brightTemperatureSummer <- TOABrightTemp(TOA_Radiance10Summer, TOA_Radiance11Summer)

# ** TOA_Brightness Temperature Winter
brightTemperatureWinter <- TOABrightTemp(TOA_Radiance10Winter, TOA_Radiance11Winter)

#### Average brightness temperature between band 10 and band 11

# ** Autumn
brightTempAvgAutumn <- mean(brightTemperatureAutumn[[1]], brightTemperatureAutumn[[2]])

# ** Spring
brightTempAvgSpring <- mean(brightTemperatureSpring[[1]], brightTemperatureSpring[[2]])

# ** Summer
brightTempAvgSummer <- mean(brightTemperatureSummer[[1]], brightTemperatureSummer[[2]])

# ** Winter
brightTempAvgWinter <- mean(brightTemperatureWinter[[1]], brightTemperatureWinter[[2]])

### STEP THREE: Compute Land Surface Emissivity (LSE)

##       Compute NDVI 

# ** NDVI Autumn
NIR_Autumn <- TehranAutumn[[5]]
RED_Autumn <- TehranAutumn[[4]]
NDVI_Autumn <- ndvi(NIR_Autumn, RED_Autumn)
# get minimun and maximum NDVI values
NDVI_minAutumn <- minValue(NDVI_Autumn)
NDVI_maxAutumn <- maxValue(NDVI_Autumn)

# ** NDVI Spring
NIR_Spring <- TehranSpring[[5]]
RED_Spring <- TehranSpring[[4]]
NDVI_Spring <- ndvi(NIR_Spring, RED_Spring)
# get minimun and maximum NDVI values
NDVI_minSpring <- minValue(NDVI_Spring)
NDVI_maxSpring <- maxValue(NDVI_Spring)

# ** NDVI Summer
NIR_Summer <- TehranSummer[[5]]
RED_Summer <- TehranSummer[[4]]
NDVI_Summer <- ndvi(NIR_Summer, RED_Summer)
# get minimun and maximum NDVI values
NDVI_minSummer <- minValue(NDVI_Summer)
NDVI_maxSummer <- maxValue(NDVI_Summer)

# ** NDVI Winter
NIR_Winter <- TehranWinter[[5]]
RED_Winter <- TehranWinter[[4]]
NDVI_Winter <- ndvi(NIR_Winter, RED_Winter)
# get minimun and maximum NDVI values
NDVI_minWinter <- minValue(NDVI_Winter)
NDVI_maxWinter <- maxValue(NDVI_Winter)

##   Land Surface Emissivity (LSE)
# ** LSE Autumn
LSE_Autumn <- landSurfaceEmissivity(NDVI_Autumn, NDVI_minAutumn, NDVI_maxAutumn)

# ** LSE Spring
LSE_Spring <- landSurfaceEmissivity(NDVI_Spring, NDVI_minSpring, NDVI_maxSpring)

# ** LSE Summer
LSE_Summer <- landSurfaceEmissivity(NDVI_Summer, NDVI_minSummer, NDVI_maxSummer)

# ** LSE Winter
LSE_Winter <- landSurfaceEmissivity(NDVI_Winter, NDVI_minWinter, NDVI_maxWinter)

###   STEP FOUR: Land Surface Temperature (LST)

# ** LST Autumn
# results in degree Kelvin
band10Autumn <- TehranAutumn[[1]]
LST_Autumn <- landSurfaceTemperature(brightTempAvgAutumn, band10Autumn, LSE_Autumn)


# ** LST Spring
band10Spring <- TehranSpring[[1]]
LST_Spring <- landSurfaceTemperature(brightTempAvgSpring, band10Spring, LSE_Spring)


# ** LST Summer
band10Summer <- TehranSummer[[1]]
LST_Summer <- landSurfaceTemperature(brightTempAvgSummer, band10Summer, LSE_Summer)


# ** LST Winter
band10Winter <- TehranWinter[[1]]
LST_Winter <- landSurfaceTemperature(brightTempAvgWinter, band10Winter, LSE_Winter)


## -------------------------Compute NDBI-------------------------
# ** NDBI Autumn
SWIR_Autumn <- TehranAutumn[[6]]
NDBI_Autumn <- ndbi(SWIR_Autumn, NIR_Autumn)

# ** NDBI Spring
SWIR_Spring <- TehranSpring[[6]]
NDBI_Spring <- ndbi(SWIR_Spring, NIR_Spring)

# ** NDBI Summer
SWIR_Summer <- TehranSummer[[6]]
NDBI_Summer <- ndbi(SWIR_Summer, NIR_Summer)

# ** NDBI Winter
SWIR_Winter <- TehranWinter[[6]]
NDBI_Winter <- ndbi(SWIR_Winter, NIR_Winter)

## ----------------Identify relationship between NDVI, NDBI and LST---------------------

### Autumn
NDBI_LST_Autumn <- stack(NDBI_Autumn, LST_Autumn)
NDVI_LST_Autumn <- stack(NDVI_Autumn, LST_Autumn)

## Overall Correlation
# ** Correlation be NDBI and LST
NDBI_LST_CorAutumn <- overallCorrelation(NDBI_LST_Autumn)
# ** Correlation be NDVI and LST
NDVI_LST_CorAutumn <- overallCorrelation(NDVI_LST_Autumn)

## Linear Model
# **correlation between between NDBI and LST
NDBI_LST_LRAutumn <- linearModel(NDBI_LST_Autumn)
# **correlation between NDVI and LSt
NDVI_LST_LRAutumn <- linearModel(NDVI_LST_Autumn)


### Spring
NDBI_LST_Spring <- stack(NDBI_Spring, LST_Spring)
NDVI_LST_Spring <- stack(NDVI_Spring, LST_Spring)

## Overall Correlation
# ** Correlation be NDBI and LST
NDBI_LST_CorSpring <- overallCorrelation(NDBI_LST_Spring)
# ** Correlation be NDVI and LST
NDVI_LST_CorSpring <- overallCorrelation(NDVI_LST_Spring)

## Linear Model
# **correlation between between NDBI and LST
NDBI_LST_LRSpring <- linearModel(NDBI_LST_Spring)
# **correlation between NDVI and LSt
NDVI_LST_LRSpring <- linearModel(NDVI_LST_Spring)


### Summer
NDBI_LST_Summer <- stack(NDBI_Summer, LST_Summer)
NDVI_LST_Summer <- stack(NDVI_Summer, LST_Summer)

## Overall Correlation
# ** Overall correlation between NDBI and LST
NDBI_LST_CorSummer <- overallCorrelation(NDBI_LST_Summer)
# ** Overall correlation between NDVI and LST
NDVI_LST_CorSummer <- overallCorrelation(NDVI_LST_Summer)

## Linear Model
# **correlation between between NDBI and LST
NDBI_LST_LRSummer <- linearModel(NDBI_LST_Summer)
# **correlation between NDVI and LSt
NDVI_LST_LRCorSummer <- linearModel(NDVI_LST_Summer)


###  Winter
NDBI_LST_Winter <- stack(NDBI_Winter, LST_Winter)
NDVI_LST_Winter <- stack(NDVI_Winter, LST_Winter)

## Overall Correlation
# ** Overall correlation between NDBI and LST
NDBI_LST_CorWinter <- overallCorrelation(NDBI_LST_Winter)
# ** Overall correlation between NDVI and LST
NDVI_LST_CorWinter <- overallCorrelation(NDVI_LST_Winter)

## Linear Model
# **correlation between between NDBI and LST
NDBI_LST_LRWinter <- linearModel(NDBI_LST_Winter)
# **correlation between NDVI and LSt
NDVI_LST_LRWinter <- linearModel(NDVI_LST_Winter)

########################## VISUALISATION ##########################
## LST, NDVI, NDBI plot for the 4 seasons
# Plot NDVI for four seasons
NDVI4season <- plotting ("output/NDVI_fourseason.png", 'YlGn', NDVI_Autumn, 'Autumn', NDVI_Spring, 'Spring', NDVI_Summer, 'Summer', NDVI_Winter, 'Winter', 'NDVI maps for four seasons ')

# Plot NDBI for four seasons
NDBI4season <- plotting ("output/NDBI_fourseason.png", 'OrRd', NDBI_Autumn, 'Autumn', NDBI_Spring, 'Spring', NDBI_Summer, 'Summer', NDBI_Winter, 'Winter', 'NDBI maps for four seasons ')

# Plot LST for four seasons
LST4season <- plotting ("output/LST_fourseason.png", 'YlOrRd', LST_Autumn, 'Autumn', LST_Spring, 'Spring', LST_Summer, 'Summer', LST_Winter, 'Winter', 'LST maps for four seasons ')


## Overall Correlation between NDVI, NDBI and LST barplot

NDVI_LST_Cor <- c(NDVI_LST_CorAutumn, NDVI_LST_CorSpring, NDVI_LST_CorSummer, NDVI_LST_CorWinter)
NDBI_LST_Cor <- c(NDBI_LST_CorAutumn, NDBI_LST_CorSpring, NDBI_LST_CorSummer, NDBI_LST_CorWinter)
png(paste0(outputdir, "/NDVI_NDBI_LSTBarplot.png"), width=800, height=500)
par(mfrow=c(1,2))
cols <- c('orange', 'dark green', 'yellow', 'grey60')
barplot(NDVI_LST_Cor, main='NDVI - LST Correlation', font.main=1, col = cols)
barplot(NDBI_LST_Cor, main='NDBI - LST Correlation', font.main=1, col = cols)
legend("topright",
       legend = c('Autumn', 'Spring', 'Summer', 'Winter'),
       fill = c('orange', 'dark green', 'yellow', 'grey60'))
mtext(text = 'NDVI, NDBI & LST Correlation', side = 1, line=-2, outer=TRUE, cex=2, font = 2)
dev.off()


## LST - NDVI and LST - NDBI correlation plot for the 4 seasons
# Autumn
png(paste0(outputdir, "/NDVI_LSTScatterPlotAutumn.png"), width=800, height=500)
print(colourScatterplot(NDVI_LST_Autumn, 'NDVI', 'LST', 'NDVI-LST Feature Space Plot (Autumn)'))
dev.off()
png(paste0(outputdir, "/NDBI_LSTScatterPlotAutumn.png"), width=800, height=500)
print(colourScatterplot(NDBI_LST_Autumn, 'NBVI', 'LST', 'NDBI-LST Feature Space Plot (Autumn)'))
dev.off()

# Spring
png(paste0(outputdir, "/NDVI_LSTScatterPlotSpring.png"), width=800, height=500)
colourScatterplot(NDVI_LST_Spring, 'NDVI', 'LST', 'NDVI-LST Feature Space Plot (Spring)')
dev.off()
png(paste0(outputdir, "/NDBI_LSTScatterPlotSpring.png"), width=800, height=500)
colourScatterplot(NDBI_LST_Spring, 'NBVI', 'LST', 'NDBI-LST Feature Space Plot (Spring)')
dev.off()

# Summer
png(paste0(outputdir, "/NDVI_LSTScatterPlotSummer.png"), width=800, height=500)
print(colourScatterplot(NDVI_LST_Summer, 'NDVI', 'LST', 'NDVI-LST Feature Space Plot (Summer)'))
dev.off()
png(paste0(outputdir, "/NDBI_LSTScatterPlotSummer.png"), width=800, height=500)
print(colourScatterplot(NDBI_LST_Summer, 'NBVI', 'LST', 'NDBI-LST Feature Space Plot (Summer)'))
dev.off()

# Winter
png(paste0(outputdir, "/NDVI_LSTScatterPlotWinter.png"), width=800, height=500)
print(colourScatterplot(NDVI_LST_Winter, 'NDVI', 'LST', 'NDVI-LST Feature Space Plot (Winter)'))
dev.off()
png(paste0(outputdir, "/NDBI_LSTScatterPlotWinter.png"), width=800, height=500)
print(colourScatterplot(NDBI_LST_Winter, 'NBVI', 'LST', 'NDBI-LST Feature Space Plot (Winter)'))
dev.off()

## Linear Regression

# Autumn
NDVI_LST_LM_Autumn <- linearModel(NDVI_LST_Autumn)
png(paste0(outputdir, "/NDVI_LST_LM_Autumn.png"), width=800, height=500)
print(linearModelPlot(NDVI_LST_LM_Autumn, "#f4d03f", "#0b5345", "NDVI - LST Linear Regression (Autumn)"))
dev.off()
NDBI_LST_LM_Autumn <- linearModel(NDBI_LST_Autumn)
png(paste0(outputdir, "/NDBI_LST_LM_Autumn.png"), width=800, height=500)
print(linearModelPlot(NDBI_LST_LM_Autumn, "#f4d03f", "#ff0000", "NDBI - LST Linear Regression (Autumn)"))
dev.off()

# Spring
NDVI_LST_LM_Spring <- linearModel(NDVI_LST_Spring)
png(paste0(outputdir, "/NDVI_LST_LM_Spring.png"), width=800, height=500)
print(linearModelPlot(NDVI_LST_LM_Spring, "#f4d03f", "#0b5345", "NDVI - LST Linear Regression (Spring)"))
dev.off()
NDBI_LST_LM_Spring <- linearModel(NDBI_LST_Spring)
png(paste0(outputdir, "/NDBI_LST_LM_Spring.png"), width=800, height=500)
print(linearModelPlot(NDBI_LST_LM_Spring, "#f4d03f", "#ff0000", "NDBI - LST Linear Regression (Spring)"))
dev.off()

# Summer
NDVI_LST_LM_Summer <- linearModel(NDVI_LST_Summer)
png(paste0(outputdir, "/NDVI_LST_LM_Summer.png"), width=800, height=500)
print(linearModelPlot(NDVI_LST_LM_Summer, "#f4d03f", "#0b5345", "NDVI - LST Linear Regression (Summer)"))
dev.off()
NDBI_LST_LM_Summer <- linearModel(NDBI_LST_Summer)
png(paste0(outputdir, "/NDBI_LST_LM_Summer.png"), width=800, height=500)
print(linearModelPlot(NDBI_LST_LM_Summer, "#f4d03f", "#ff0000", "NDVI - LST Linear Regression (Summer)"))
dev.off()

# Winter
NDVI_LST_LM_Winter <- linearModel(NDVI_LST_Winter)
png(paste0(outputdir, "/NDVI_LST_LM_Winter.png"), width=800, height=500)
print(linearModelPlot(NDVI_LST_LM_Winter, "#f4d03f", "#0b5345", "NDVI - LST Linear Regression (Winter)"))
dev.off()

NDBI_LST_LM_Winter <- linearModel(NDBI_LST_Winter)
png(paste0(outputdir, "/NDBI_LST_LM_Winter.png"), width=800, height=500)
print(linearModelPlot(NDBI_LST_LM_Winter, "#f4d03f", "#ff0000", "NBVI - LST Linear Regression (Winter)"))
dev.off()


