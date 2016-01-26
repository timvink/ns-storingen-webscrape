
# Input: vector of number of delays on trajectories
# Output: scaled weights for line size in leaflet
rescale_line_weights <- function(x, n_groups = 9, brewer_palette = "RdBu") { 
  
  x <- data.frame(x, group = dplyr::ntile(x, n_groups))
  colours <- data.frame(group = 1:n_groups, colour = brewer.pal(n_groups, brewer_palette))
  
  result <- left_join(x, colours, by="group") %>% 
    select(-group)
    
  return(result$colour)
}
