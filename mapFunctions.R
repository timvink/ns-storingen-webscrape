library(leaflet)

#stations = fread("data/stations.csv")
#data = fread("data/data.csv")
#data2 = getLatLon(data,stations)

plotLines = function(data2,stations,date_start,date_end){
  # get unique locations
  data2 = data2[date_start <= date & date_end >= date]
  
  unique_locs = c(data2$origin, data2$destination) %>% unique
  sel_station <- stations[NAME %in% unique_locs]

  # calculate unique trajectories.
  traj <- data2[complete.cases(data2),.(Weight = .N),by=.(destination, dest_x, dest_y, origin, origin_x, origin_y)]
  traj[,ID := .I]

  # create unique plot
  m <- leaflet(sel_station) %>% addTiles() %>%
    addCircles(lng = ~X, lat = ~Y, weight = 1,
               radius = 2500, popup = sel_station$NAME
  )

  for(i in 1:nrow(traj)){
    lat <- c(traj[i,dest_y], traj[i,origin_y])
    lon <- c(traj[i,dest_x], traj[i,origin_x])
    #print(i)
    m <- m %>% addPolylines(lng=lon,lat=lat, weight = 3, fillOpacity = 0.2,
                          popup = sprintf("%s to %s", traj$origin[i], traj$destination[i]))
    }
return(m)
}
