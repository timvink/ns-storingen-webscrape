
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

# Just in case there are proxy problems
Sys.setenv(http_proxy="")
Sys.setenv(https_proxy="")
Sys.unsetenv("http_proxy")
Sys.setenv(no_proxy="*")

# Source our functions
source("functions/read_storing_page.R")
source("functions/getAllLinks.R")

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

#..
  