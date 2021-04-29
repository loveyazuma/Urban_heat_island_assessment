## Investigating Correlation Between Land Surface Temperature, NDVI and NDBI Using Landsat 8: A Case Study of Tehran


<p align="justify">Urbanization is considered as one of the most significant contributors to global warming, as about two-thirds (55%) of the human population lives in cities<sup>1</sup>. The growth of population and urbanization has caused the phenomenon of Urban Heat Islands (UHI), which can be described as the significant increase of temperatures in urban areas compared to their rural surroundings<sup>2</sup>. UHI and their behaviour can be studied by measuring the Land Surface Temperature (LST)<sup>3</sup>. The ability of remote sensing sensors to measure the surface temperature has resulted in the successful use of Earth Observation data in UHI studies.</p>


<p align="justify">Research on LST and UHI showed that land surface temperature response is a function of different land cover, this has prompted us to think about the correlation between LST and land cover in urban areas.</div>


**Aim**


The aim of this study is to conduct the following analysis:

- Calculation of  the NDVI (Normalised Differential Vegetation Index) and NDBI (Normalised Differential Building Index) for four seasons in 2019
- Estimation of  the LST (Land Surface Temperature) for four seasons in 2019
- Determine the relatinship and correlation between landcover (NDVI and NDBI) and LST for four seasons in 2019


**Study Area**


<p align="justify">Tehran, the capital city of Iran, which is located in the northern part of the country at the hillside location of the southern side of Alborz Mountains, within the latitudes of 35◦300 to 35◦510 and the longitudes of 51◦00’ to 51◦400<sup>4</sup>. Tehran has become the most populous city in Iran, in 2016, it had a population of 8.52 million. <sup>5</sup>. The study area leads to mountainous areas from the north and to desert areas for the south, so northern and southern part have different climatic conditions. The northern areas have a dry and cold climate, whereas the southern, it has a warm and dry climate. </div>

**Data Description**


 - The dataset consists of Landsat 8  images from four dates (2019-02-05, 2019-05-21, 2019-08-19 and 2019-10-03).  
 - A path and row of 164 and 35 were downloaded for the study area Tehran city, Iran.
 - The criteria of less than 10% cloud cover images were selected to make sure the images had no cloud cover.
 - Landsat 8 Operational Land Imager (OLI) and Thermal Infrared Sensor (TIRS) image consist of nine spectral bands with a spatial resolution of 30 meters for bands 1 to 7 and 9. The resolution for Band 8 (panchromatic) is 15 meters and 100 meters for the thermal bands 10 and 11.
 - The total size of the images is 1584 MB.
 - The administrative boundaries of the Tehran city will be used for cropping the raster data.
 - The Landsat satellite images can be searched and downloaded from the USGS website as [free](https://earthexplorer.usgs.gov/)
 - Droobox link was created for each date to make the data available. Please click (https://www.dropbox.com/s/zg078whpborr2m2/autumn.zip?dl=1)(https://www.dropbox.com/s/upsq1uzipp7x5mw/spring.zip?dl=1)(https://www.dropbox.com/s/vkbfdo5s5r5reas/summer.zip?dl=1)(https://www.dropbox.com/s/t5hc753vl43o31s/winter.zip?dl=1) to access the data. 
 - The administrative boundaries of the Tehran city can be downloaded from the Overpass turbo (is a web based data mining tool for OpenStreetMap)(https://overpass-turbo.eu/)


**Flowchart**


![Flowchat](https://github.com/loveyazuma/geoscripting-exercises/blob/master/fpDiagram.png)


**Languages**
 - R
 
 
**Packages**
 - Raster
 - Rgdal
 - Sp 
 - Sf
- RStoolbox
 - Satellite 
 
 
 **Visualisation of Results**
 
 
 + **Map**
     - NDVI, NDBI and LST maps for four seasons
     - Correlation between NDVI-LST and NDBI-LST maps for four seasons
     
 
  + **Table**
     - Statistical data of NDVI, NDBI and LST for four seasons
     - correlation coefficient of NDVI-LST and NDBI-LST
 
 


**References**


<sup>1</sup>Gordana K et al. Urban Heat Island Analysis Using the Landsat 8Satellite Data: A Case Study in Skopje, Macedonia. 2018, Licensee MDPI, Basel, Switzerland. 


<sup>2</sup>Schwarz, N.; Lautenbach, S.; Seppelt, R. Exploring indicators for quantifying surface urban heat islands of European cities with MODIS land surface temperatures. Remote Sens. Environ. 2011, 115, 3175–3186.


<sup>3</sup>Kaplan, G., Avdan, U. and Avdan, Z. (2018). Urban Heat Island Analysis Using the Landsat 8 Satellite Data: A Case Study in Skopje, Macedonia. Proceedings, 2(7), p.358.


<sup>4</sup>https://en.wikipedia.org/wiki/Tehran




