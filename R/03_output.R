# Michiel Blok and Madeleine van Winkel
# 8 January 2015

output <- function(NDVI) {
  # Calculate the intersection between the two raster layers
  extent1 <- extent(NDVI[[1]])
  extent2 <- extent(NDVI[[2]])
  
  commonExtent <- intersect(x = extent1, y = extent2)

  NDVI1990 <- crop(x = NDVI[[1]], y = commonExtent)
  NDVI2014 <- crop(x = NDVI[[2]], y = commonExtent)

  # Calculate the change in NDVI
  NDVIchange <- (NDVI1990 - NDVI2014)
  
  plot(NDVIchange)
  
  # Write the raster layer to the output
  writeRaster(x = NDVIchange, filename = "output/NDVIchange.grd", overwrite = TRUE)
}