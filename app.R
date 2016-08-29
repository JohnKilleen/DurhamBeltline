library(dplyr)  
library(rgdal)   
library(sp)     
library(leaflet)  
library(ggplot2)
library(magrittr)
library(shiny)

sanborn <- leaflet() %>%
  setView(-78.9001356,35.9954795, 16) %>%
  addProviderTiles("CartoDB.DarkMatter", group = "DarkMatter") %>%
  addProviderTiles("CartoDB.Positron", group = "Positron") %>%
  addTiles("http://www2.lib.unc.edu/dc/maptiles/sanborn/Durham/1884/{z}/{x}/{y}.png",
           options = WMSTileOptions(draggable = TRUE, format = "image/png", opacity = 0.75), group = "1884") %>% 
  addTiles("http://www2.lib.unc.edu/dc/maptiles/sanborn/Durham/1888/{z}/{x}/{y}.png",
           options = WMSTileOptions(draggable = TRUE, format = "image/png", opacity = 0.75), group = "1888") %>% 
  addTiles("http://www2.lib.unc.edu/dc/maptiles/sanborn/Durham/1893/{z}/{x}/{y}.png",
           options = WMSTileOptions(draggable = TRUE, format = "image/png", opacity = 0.75), group = "1893") %>% 
  addTiles("http://www2.lib.unc.edu/dc/maptiles/sanborn/Durham/1898/{z}/{x}/{y}.png",
           options = WMSTileOptions(draggable = TRUE, format = "image/png", opacity = 0.75), group = "1898") %>% 
  addTiles("http://www2.lib.unc.edu/dc/maptiles/sanborn/Durham/1902/{z}/{x}/{y}.png",
           options = WMSTileOptions(draggable = TRUE, format = "image/png", opacity = 0.75), group = "1902") %>% 
  addTiles("http://www2.lib.unc.edu/dc/maptiles/sanborn/Durham/1907/{z}/{x}/{y}.png",
           options = WMSTileOptions(draggable = TRUE, format = "image/png", opacity = 0.75), group = "1907") %>% 
  addTiles("http://www2.lib.unc.edu/dc/maptiles/sanborn/Durham/1913/{z}/{x}/{y}.png",
           options = WMSTileOptions(draggable = TRUE, format = "image/png", opacity = 0.75), group = "1913") %>% 
addLayersControl(baseGroups = c("DarkMatter", "Positron"), 
                 overlayGroups=c("1884","1888","1893","1898","1902","1907","1913"), 
                 position="topright", 
                 options=layersControlOptions(collapsed = TRUE)) 


# Define UI for application 
ui <- shinyUI(fluidPage(
   
   # Application title
   titlePanel("Durham Sanborn Maps 1884-1913"),
   
   # Sidebar  
   sidebarLayout(
          sidebarPanel(
            h3("The Durham Beltline...") %>% 
            p() %>% 
            h4("In 1890, after engineering a merger with his three largest competitors, 
               Brodie Duke began building his own rail line, arcing along the western and 
               northern edges of town. This Durham Beltline completed a loop linking the 
               newly formed American Tobacco Company facilities to each other and to both 
               of the city’s regional railways. By the turn of the century, American Tobacco 
               was producing and shipping 90% of the cigarettes sold in the United States, 
               due in no small part to this rail infrastructure."), 
          
            a(href="http://preservationdurham.org/index.php/places-in-peril-2012-durham-beltline-railway/",
                   "Preservation Durham, 2012") %>% 
              p() %>% 
            h6("Sanborn maps are sourced from Davis Library Research Hub, University of North Carolina at Chapel Hill.")    
        ),
      
      # Show maps
      mainPanel(
        leafletOutput('sanborn', width = "100%", height = 700))
   )
))

# Define server logic 
server <- shinyServer(function(input, output) {
   
  map <- sanborn %>% hideGroup("1888") %>% 
    hideGroup("1893")%>% hideGroup("1898") %>% 
    hideGroup("1902")%>% hideGroup("1907") %>%
    hideGroup("1913")
  output$sanborn <- renderLeaflet(map)
  output$value <- renderPrint({ input$select })
  })


# Run the application 
shinyApp(ui = ui, server = server)

