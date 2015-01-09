# Michiel Blok and Madeleine van Winkel
# 8 January 2015

# Visualize the NDVI values without cloud cover for both years
visualization <- function(NDVI) {
  # Plot the NDVI values of 1990
  plot(NDVI[[1]])
  
  # Plot the NDVI values of 2014
  plot(NDVI[[2]])
}