## Load libraries
library(tidyverse)
library(leaflet)
library(raster)
library(sf)

## Intro to leaflet - make an interactive map with 2 lines of code


## Try loading in Mexico City crime data
cdmx_robbery_url <- ''

cdmx_robbery_data <- read_sf(cdmx_robbery_url)



## Basic map for Mexico City crime data

cdmx_robbery_data %>% 
  leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers()


## Modify circle markers (radius, stroke, color)

cdmx_robbery_data %>% 
  leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers()

## Add labels

cdmx_robbery_data %>% 
  leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers(radius = 2, stroke = FALSE, fillOpacity = .1)

## modify colors

color_palette_function <- function(x) {
  ifelse(x == 'Violent street robbery', 'Red', 'Blue')
}

cdmx_robbery_data %>% 
  leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers(radius = 4, stroke = FALSE, fillOpacity = .5,
                   color = ~color_palette_function(crime),
                   label = ~paste(date, time_ocurred))


## add filter

cdmx_robbery_data %>% 
  filter() %>%          # add filter for different time periods throught the day
  leaflet() %>% 
  addTiles() %>% 
  addCircleMarkers(radius = 4, stroke = FALSE, fillOpacity = .5,
                   color = ~color_palette_function(crime),
                   label = ~paste(date, time_ocurred))







## maps with raster and polygon data

## Load data
raster_url <- #paste github URL

precip_raster <- raster() 

raster::crs(precip_raster) <- sp::CRS("+proj=longlat +ellps=WGS84 +datum=WGS84 +no_defs")

pal <- colorNumeric(c("#d7191c","#fdae61","#ffffbf","#abd9e9", "#2c7bb6"), values(precip_raster),
                    na.color = 'transparent')

raster_values <- quantile(values(precip_raster), na.rm = TRUE)


leaflet() %>% 
  addTiles() %>% 
  addRasterImage(precip_raster, colors = pal) %>% 
  addLegend(labels = raster_values,
            title = "Precipitation",
            colors = pal(raster_values))



## Add polygons

## load polygons
col_precip_url <- '' #paste github link

col_precip_data <- read_sf(col_precip_url)



