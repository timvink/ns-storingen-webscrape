library('stringr')
library("rvest")

# function wrapper
getAllLinks = function(){
  all_links = data.table('links' = character())
  #loop for all pages
  for(i in 1:789){
    if(i %% 100 == 0){print(i)}
    # read next page
    s = read_html(paste0("http://www.rijdendetreinen.nl/storingen/p",x))
    # get all links
    links = s %>% html_nodes("a") %>% html_attr("href")
  
    # get relevant links
    to_get = str_detect(links,'(/storingen/[^a-zA-Z])')
  
    # add to container
    all_links = rbind(all_links,data.table(links[to_get]),use.names=F)
  }
  
  all_links$gotoLink = paste0('http://www.rijdendetreinen.nl',all_links$links)
return(all_links$gotoLink)
}


# to use
# run getAllLinks(). This function returns a vector of all the links to iterate the scraping function over for the NS