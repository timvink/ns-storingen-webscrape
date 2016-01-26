library(data.table)

# issues
# 1.namematching origin & destination names

# test data
#data = fread("data/head.csv")
#stations = fread("data/stations.csv")

getLatLon = function(data,stations){
  # make date column date type
  data$date = as.Date(data$date)
  
  # get origin locations
  setkey(data,origin)
  setkey(stations,NAME)
  
  # join
  data2 = stations[,list('origin_x' = X,'origin_y' = Y,NAME)][data]
  setnames(data2, "NAME" , "origin") #data2$origin = data2$NAME
  
  # get destination locations
  setkey(data2,destination)
  setkey(stations,NAME)
  data3 = stations[,list('dest_x' = X,'dest_y' = Y,NAME)][data2]
  setnames(data3, "NAME" , "destination")
  
  # remove NAME columns
  #set(data3,j='NAME',value=NULL)
  #set(data3,j='i.NAME',value=NULL)
  # update all
  #data3[,!(colnames(data3) %in% 'storing'),with=F]
  return(data3)
}
