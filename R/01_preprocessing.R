# Michiel Blok and Madeleine van Winkel
# 8 January 2015

# 
preprocessing <- function() {
  # Extract the files
  # The function does not work on every computer
  #untar(E:/Geo Scripting GRS-51806/Practicals/GRS-51806_lesson4/data/Landsat 7_1/LC81970242014109-SC20141230042441.tar.gz)
  
  # List the extracted files
  RED1990 <- list.files('data/', pattern = glob2rx('LT*band3.tif'), full.names = TRUE)
  NIR1990 <- list.files('data/', pattern = glob2rx('LT*band4.tif'), full.names = TRUE)
  RED2014 <- list.files('data/', pattern = glob2rx('LC*band3.tif'), full.names = TRUE)
  NIR2014 <- list.files('data/', pattern = glob2rx('LC*band4.tif'), full.names = TRUE)
  
  RED1990 <- raster(RED1990)
  NIR1990 <- raster(NIR1990)
  RED2014 <- raster(RED2014)
  NIR2014 <- raster(NIR2014)
  
  # Calculate NDVI
  NDVI1990 <- calculateNDVI(RED1990, NIR1990)
  NDVI2014 <- calculateNDVI(RED2014, NIR2014)
  
  # Create cloud layer
  clouds1990 <- list.files('data/', pattern = glob2rx('LT*cfmask.tif'), full.names = TRUE)
  clouds2014 <- list.files('data/', pattern = glob2rx('LC*cfmask.tif'), full.names = TRUE)

  clouds1990 <- raster(clouds1990)
  clouds2014 <- raster(clouds2014)
  
  # Remove cloud cover
  NDVI1990CloudFree <- overlay(x = NDVI1990, y = clouds1990, fun = removeCloudCover)
  NDVI2014CloudFree <- overlay(x = NDVI2014, y = clouds2014, fun = removeCloudCover)

  return(c(NDVI1990CloudFree, NDVI2014CloudFree))
}

# Calculate the NDVI
calculateNDVI <- function(RED, NIR) {
  NDVI <- ((NIR-RED) / (NIR+RED))
  return(NDVI)
}

# Replace the values of the NDVI in areas with cloud cover
removeCloudCover <- function(x, y){
  x[y != 0] <- NA
  return(x)
}