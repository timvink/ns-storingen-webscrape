
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

pages <- getAllLinks()
data <- rbindlist(lapply(pages[1:10], read_storing_page), use.names = T, fill = T) # Reads in all the pages.


#### Analyse data ####
data
#..
  
  