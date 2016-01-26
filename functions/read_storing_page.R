
# Function to read a storing page.
# here is an example url to use: 
# url <- "http://www.rijdendetreinen.nl/storingen/13071-22-januari-2016-defecte-trein-schiphol-airport-hilversum"
read_storing_page <- function(url) { 

  txt <- read_html(url)
  raw <- txt %>% html_nodes("p") %>% html_text %>% paste(collapse = "\n\n") # One big flat text vector of every <p>

  # Some dates
  start_date <- (raw %>% str_match("voor het eerst aangemaakt op\n\t([0-9]+ [a-z]+) om ([0-9]{2}\\.[0-9]{2}) uur\\."))[,2]
  start_time <- (raw %>% str_match("voor het eerst aangemaakt op\n\t([0-9]+ [a-z]+) om ([0-9]{2}\\.[0-9]{2}) uur\\."))[,3] %>% str_replace("\\.",":")
  start_year <- (raw %>% str_match("laatste update voor dit bericht was op\n\t[A-Za-z]+ [0-9]+ [a-z]+ ([0-9]{4}) om [0-9]{2}\\.[0-9]{2} uur\\."))[,2]
  
  # Get time information
  page_data <- data.frame(
      storing = txt %>% html_nodes("h1") %>% html_text %>% str_replace("\\([A-Z a-z]+\\)", "") %>% str_replace_all("\\s$","") %>% str_replace_all("\\s$","")
    , cause = (txt %>% html_nodes("h1") %>% html_text %>% str_match("\\(([a-zA-Z 0-9]+)\\)"))[,2]
    , date = sprintf("%s %s %s", start_date, start_time, start_year) %>% parse_date_time("%d %m %H:%M %Y", tz="GMT")
    , dur_hours = (raw %>% str_match("([0-9]+) uur en ([0-9]+) minuten"))[,2]
    , dur_minutes = (raw %>% str_match("([0-9]+) uur en ([0-9]+) minuten"))[,3]
  )
  
  # Determine origin destination of each trajectory affected by storing.
  trajectories <- txt %>% html_nodes("ul li")%>% html_text %>% 
    str_replace_all("\\n|\\t","") %>% 
    str_split(" - ") %>%
    map(function(x) data.frame(origin=as.character(x[1]), destination=as.character(x[2]))) %>% 
    reduce(rbind)

  # for each trajecty, add the storing data
  result <- cbind(trajectories, page_data)

  return(result)
}