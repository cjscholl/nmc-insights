#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(datasets)
library(plotly)

# Define UI for application
shinyUI(
      fluidPage(
            tags$head(
                    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
                    includeHTML("www/font.html")
            ),
            # App title ----
            titlePanel(
              windowTitle="NativityMiguel Insights",
              div(
                class="header",
                img(src="https://images.squarespace-cdn.com/content/v1/5c5df3d434c4e266df4c3f76/1549661200753-9MZ34PQ783TJPZB4R7V9/NMC-Logo-Web.gif?format=1500w", height="34px"), 
                h1(id="title", "NativityMiguel Coalition")
              )
            ),
            navbarPage("NMC",
                       source(file.path("ui", "instructions.R"),  local = TRUE)$value,
                       source(file.path("ui", "overview.R"),  local = TRUE)$value,
                       source(file.path("ui", "graduateSupport.R"),  local = TRUE)$value,
                       source(file.path("ui", "schoolData.R"),  local = TRUE)$value
            ),
      )
)
