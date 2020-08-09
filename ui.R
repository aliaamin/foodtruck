library(shiny)
library(leaflet)

navbarPage("The SF Food Truck Discovery Project", id="main",
           tabPanel("Project Proposal and Backlog",includeMarkdown("proposal.md")),
           tabPanel("Map", leafletOutput("foodtruck_map", height=1000)),
           tabPanel("Table", DT::dataTableOutput("data")))

