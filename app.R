library(shiny)
library(rgl)
library(shinycssloaders)
library(readobj)

ui = fluidPage(
  titlePanel("Coronavirus / COVID-19 in 3D"),
  fluidRow(
    rglwidgetOutput("rglWidget", width="100%", height=640) %>% withSpinner()
  )
)

server = function(input, output, session) {
  
  output$rglWidget = renderRglwidget({
    model = read.obj("coronavirus.obj", convert.rgl=TRUE)
    open3d()
    shade3d(model$Layer_1, color="darkgray")
    shade3d(model$Layer_2, color="red")
    bg3d(gray(level=0.95))
    rglwidget(reuse=TRUE)
  })
  
}

shinyApp(ui=ui, server=server)
