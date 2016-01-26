
# Function to read a storing page.
# here is an example url to use: 
# url <- "http://www.rijdendetreinen.nl/storingen/13071-22-januari-2016-defecte-trein-schiphol-airport-hilversum"
read_storing_page <- function(url) { 

  txt <- read_html(url)
  raw <- txt %>% html_nodes("p") %>% html_text
  
  # Get time information
  page_data <- data.frame(
    storing = txt %>% html_nodes("h1") %>% html_text
    , start_date = (raw[[1]] %>% str_match("voor het eerst aangemaakt op\n\t([0-9]+ [a-z]+) om ([0-9]{2}\\.[0-9]{2}) uur\\."))[,2]
    , start_time = (raw[[1]] %>% str_match("voor het eerst aangemaakt op\n\t([0-9]+ [a-z]+) om ([0-9]{2}\\.[0-9]{2}) uur\\."))[,3]
    , dur_hours = (raw[[1]] %>% str_match("([0-9]+) uur en ([0-9]+) minuten"))[,2]
    , dur_minutes = (raw[[1]] %>% str_match("([0-9]+) uur en ([0-9]+) minuten"))[,3]
  )
  
  return(page_data)
}