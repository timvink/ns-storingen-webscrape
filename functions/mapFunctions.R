library(leaflet)

#stations = fread("data/stations.csv")
#data = fread("data/data.csv")
#data2 = getLatLon(data,stations)

plotLines = function(data2,stations,date_start,date_end){
  # get unique locations
  data2 = data2[date_start <= date & date_end >= date]
  if(nrow(data2)==0){print("Empty data")}
  unique_locs = c(data2$origin, data2$destination) %>% unique
  sel_station <- stations[NAME %in% unique_locs]

  # calculate unique trajectories.
  traj <- data2[complete.cases(data2),.(Weight = .N),by=.(destination, dest_x, dest_y, origin, origin_x, origin_y)]
  traj[,ID := .I]
  traj[, line_colour := rescale_line_weights(Weight, n_groups = 5)]

  # create unique plot
  m <- leaflet(sel_station) %>% addTiles() %>% 
    addProviderTiles("Stamen.TonerLite",
                     options = providerTileOptions(noWrap = TRUE)
    ) %>%
    addCircles(lng = ~X, lat = ~Y, weight = 1,
               radius = 2500, popup = sel_station$NAME
  )

  for(i in 1:nrow(traj)){
    lat <- c(traj[i,dest_y], traj[i,origin_y])
    lon <- c(traj[i,dest_x], traj[i,origin_x])
    #print(i)
    m <- m %>% addPolylines(lng=lon,lat=lat, weight = 5, fillOpacity = 0.9,color = traj$line_colour[i],
                          popup = sprintf("%s to %s", traj$origin[i], traj$destination[i]))
    }
return(m)
}
