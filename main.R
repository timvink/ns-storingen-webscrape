
##################
## NS Storingen ##
##################

#### Setup ####

# Packages
library(rvest)
library(stringr)
library(dplyr)
library(ggplot2)

# Just in case there are proxy problems
Sys.setenv(http_proxy="")
Sys.setenv(https_proxy="")
Sys.unsetenv("http_proxy")
Sys.setenv(no_proxy="*")

# Source our functions
source("functions/read_storing_page.R")

#### Load data ####

# todo

#### Analyse data ####

#..
  
  