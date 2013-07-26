library(shiny)

edges <- read.csv('./data/edge_list.csv', stringsAsFactor = FALSE)

shinyServer(function(input, output) {

  data <- reactive(function() {

    sub.edges <- edges[which(edges[,'Year']==input$year),c('source','target','NAT')]
    sub.edges[,'type'] <- 'standard'
    
    list(links=as.matrix(sub.edges))
  
  })
  
  output$chart <- reactive(function() { data() })
  
})