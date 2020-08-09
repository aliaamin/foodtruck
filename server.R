library(shiny)
library(dplyr)
library(leaflet)
library(DT)

shinyServer(function(input, output) {

  # Load Data
  ft_data <- read.csv("Mobile_Food_Facility_Permit_Clean.csv", stringsAsFactors = FALSE )
  ft_data <- data.frame(ft_data)
  ft_data$Latitude <-  as.numeric(ft_data$Latitude)
  ft_data$Longitude <-  as.numeric(ft_data$Longitude)

  pal <- colorFactor(pal = c("#1b9e77", "#d95f02", "#7570b3"), domain = c("Asian Food", "Mexican Food", "Western Food"))

  # create map, center at SF city  
  output$foodtruck_map <- renderLeaflet({
      leaflet(ft_data) %>%
      setView(-122.425094186331, 37.7440390986017, zoom = 13) %>%
      addCircles(lng = ~Longitude, lat = ~Latitude) %>% 
      addTiles() %>%
      addCircleMarkers(data = ft_data, lat =  ~Latitude, lng =~Longitude, 
                       radius = 3, popup = ~as.character(description), 
                       stroke = FALSE, fillOpacity = 0.8)%>%
      addLegend(pal=pal, values=ft_data$FoodType,opacity=1, na.label = "Not Available")%>%
      addEasyButton(easyButton(
        icon="fa-crosshairs", title="ME",
        onClick=JS("function(btn, map){ map.locate({setView: true}); }")))
        })
  

  # create table, hide all uneccessary column from user
    output$data <-DT::renderDataTable(datatable(
          ft_data[,c(-6,-7,-10)],filter = 'top'
    ))     

})
