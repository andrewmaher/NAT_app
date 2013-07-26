library(shiny)

reactiveNetwork <- function (outputId) 
{
  HTML(paste("<div id=\"", outputId, "\" class=\"shiny-network-output\"><svg /></div>", sep=""))
}

shinyUI(pageWithSidebar(
  
  headerPanel("Net Aid Transfers (1960-2011)"),
  sidebarPanel(

    sliderInput("year", "Year:",format="####.",
                min = 1960, max = 2011, value = 1960,step=1)
        
  ),
  
  mainPanel(
    includeHTML("graph.js"),
    reactiveNetwork(outputId = "chart")
  )
))

