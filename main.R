
##################
## NS Storingen ##
##################

#### Setup ####

# Packages
library(rvest)
library(stringr)
library(dplyr)
library(ggplot2)
library(data.table)
library(purrr)
library(lubridate)
library(leaflet)
library(RColorBrewer)
library(dplyr)
library(shiny)

# Just in case there are proxy problems
Sys.setenv(http_proxy="")
Sys.setenv(https_proxy="")
Sys.unsetenv("http_proxy")
Sys.setenv(no_proxy="*")

# Source our functions
source("functions/read_storing_page.R")
source("functions/getAllLinks.R")
source("functions/rescale_line_weights.R")
source("functions/getLatLon.R")
source("functions/mapFunctions.R")

# Todo / issues
# in getAllLinks, make sure to set i dynamicly to number of pages.


#### Load data ####

# Takes about ~ 15 minutes of punishing rijdendetreinen.nl/ 
pages <- getAllLinks()
system.time(data <- rbindlist(lapply(pages, read_storing_page), use.names = T, fill = T)) # Reads in all the pages.

# Save to a temporary folder 
write.csv(data[1:20], "data/head.csv", row.names=F)
write.csv(data, "data/data.csv", row.names=F)

#### Analyse data ####

# read in data
data = fread("data/data.csv")
stations = fread("data/stations.csv")

# add geo points
data2  = getLatLon(data,stations)

# plot
m = plotLines(data2 = data2,stations = stations,date_start = '2013-01-01',date_end = '2016-01-10')
m

