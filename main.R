# Michiel Blok and Madeleine van Winkel
# 8 January 2015

# Set working directory
#setwd()

# Import packages
library(raster)

# Source functions
source('R/01_preprocessing.R')
source('R/02_visualization.R')
source('R/03_output.R')

# Then the actual commands
NDVI <- preprocessing()
visualization(NDVI)
output(NDVI)
