#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(readxl)
library(ggplot2)
library(tidyr)
library(dplyr)
library(plotly)
library(shinyWidgets)
# rm(list = ls())

shinyServer(function(input, output) {
  
  ### READ SPREADSHEET FUNCTION
  # utility function to read a specified excel file and sheet name into a dataframe
  readSpreadsheet <- function(file, sheet) {
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file all rows will be shown.
    req(file)
    req(sheet)
    
    tryCatch(
      {
        return (read_excel(file$datapath,sheet=sheet))
      },
      error = function(e) {
        # return a safeError if a parsing error occurs
        stop(safeError(e))
      }
    )
  }
  
  ### REACTIVE DATA FRAMES
  # select all the data frames and store them in reactive variables
  
  
  ## GRADUATE SUPPORT DATAFRAMES
  
  # REACTIVE HIGH SCHOOL GRADUATION RATE DATAFRAME
  # create the reactive dataframe by reading in the HS Graduation Rate Trend table from the excel sheet
  reactive_hs_graduation_rate_historical_df <- reactive(readSpreadsheet(input$file1, "HS Graduation Rate Trend"))
  
  # REACTIVE POST-SECONDARY PLACEMENT DATAFRAME
  # create the reactive dataframe by reading in the Post-Secondary Placement Trend table from the excel sheet
  reactive_post_secondary_placement_df <- reactive(readSpreadsheet(input$file1, "Post-Secondary Placement Trend"))
  
  # REACTIVE POST-SECONDARY COMPLETION DATAFRAME
  # create the reactive dataframe by reading in the Post-Secondary Completion Trend table from the excel sheet
  reactive_post_secondary_completion_df <- reactive(readSpreadsheet(input$file1, "Post-Secondary Completion Trend"))
  
  # REACTIVE CAREER PLACEMENT DATAFRAME
  # create the reactive dataframe by reading in the Career Placement Trend table from the excel sheet
  reactive_career_placement_df <- reactive(readSpreadsheet(input$file1, "Career Placement Trend"))
  
  
  ## SCHOOL DATA DATAFRAMES
  
  # REACTIVE ENTRY TO EXIT GRAD RATE DATAFRAME
  # create the reactive dataframe by reading in the Entry to Exit Grad Trend table from the excel sheet
  reactive_entry_exit_grad_historical_df <- reactive(readSpreadsheet(input$file1, "Entry to Exit Grad Trend"))
  
  # REACTIVE ENROLLMENT RATE DATAFRAME
  # create the reactive dataframe by reading in the Enrollment Trend table from the excel sheet
  reactive_enrollment_historical_df <- reactive(readSpreadsheet(input$file1, "Enrollment Trend"))
  
  # REACTIVE ATTENDANCE RATE DATAFRAME
  # create the reactive dataframe by reading in the Attendance Trend table from the excel sheet
  reactive_attendance_historical_df <- reactive(readSpreadsheet(input$file1, "Attendance Trend"))
  
  # REACTIVE FREE REDUCED LUNCH TREND DATAFRAME
  # create the reactive dataframe by reading in the Free Reduced Lunch Trend table from the excel sheet
  reactive_free_reduced_lunch_historical_df <- reactive(readSpreadsheet(input$file1, "Free Reduced Lunch Trend"))
  
  # REACTIVE IEP ACCOMMODATIONS TREND DATAFRAME
  # create the reactive dataframe by reading in the IEP Accommodations Trend table from the excel sheet
  reactive_iep_accommodations_historical_df <- reactive(readSpreadsheet(input$file1, "IEP Accommodations Trend"))
  
  
  
  ## GRADUATE SUPPORT DATAFRAMES
  
  # REACTIVE COALITION HIGH SCHOOL GRADUATION RATE DATAFRAME
  # create the reactive dataframe by reading in the HS Graduation Rate Trend table from the excel sheet
  reactive_coalition_hs_graduation_rate_historical_df <- reactive(readSpreadsheet(input$file2, "HS Graduation Rate Trend"))
  
  # REACTIVE POST-SECONDARY PLACEMENT DATAFRAME
  # create the reactive dataframe by reading in the Post-Secondary Placement Trend table from the excel sheet
  reactive_coalition_post_secondary_placement_df <- reactive(readSpreadsheet(input$file2, "Post-Secondary Placement Trend"))
  
  # REACTIVE POST-SECONDARY COMPLETION DATAFRAME
  # create the reactive dataframe by reading in the Post-Secondary Completion Trend table from the excel sheet
  reactive_coalition_post_secondary_completion_df <- reactive(readSpreadsheet(input$file2, "Post-Secondary Completion Trend"))
  
  # REACTIVE CAREER PLACEMENT DATAFRAME
  # create the reactive dataframe by reading in the Career Placement Trend table from the excel sheet
  reactive_coalition_career_placement_df <- reactive(readSpreadsheet(input$file2, "Career Placement Trend"))
                                                     
                                                     
  ## SCHOOL DATA DATAFRAMES
 
  # REACTIVE ENTRY TO EXIT GRAD RATE DATAFRAME
  # create the reactive dataframe by reading in the Entry to Exit Grad Trend table from the excel sheet
  reactive_coalition_entry_exit_grad_historical_df <- reactive(readSpreadsheet(input$file2, "Entry to Exit Grad Trend"))
 
  # REACTIVE ENROLLMENT RATE DATAFRAME
  # create the reactive dataframe by reading in the Enrollment Trend table from the excel sheet
  reactive_coalition_enrollment_historical_df <- reactive(readSpreadsheet(input$file2, "Enrollment Trend"))
 
  # REACTIVE ATTENDANCE RATE DATAFRAME
  # create the reactive dataframe by reading in the Attendance Trend table from the excel sheet
  reactive_coalition_attendance_historical_df <- reactive(readSpreadsheet(input$file2, "Attendance Trend"))
 
  # REACTIVE FREE REDUCED LUNCH TREND DATAFRAME
  # create the reactive dataframe by reading in the Free Reduced Lunch Trend table from the excel sheet
  reactive_coalition_free_reduced_lunch_historical_df <- reactive(readSpreadsheet(input$file2, "Free Reduced Lunch Trend"))
 
  # REACTIVE IEP ACCOMMODATIONS TREND DATAFRAME
  # create the reactive dataframe by reading in the IEP Accommodations Trend table from the excel sheet
  reactive_coalition_iep_accommodations_historical_df <- reactive(readSpreadsheet(input$file2, "IEP Accommodations Trend"))
 

  
  # Middle school graduation year slider
  output$ms_graduation_year_slider <- renderUI({
    col_name <- 'Middle School Graduating Class'
    col <- sort(
      unique(
        c(reactive_hs_graduation_rate_historical_df()[[col_name]], 
          reactive_post_secondary_placement_df()[[col_name]],
          reactive_post_secondary_completion_df()[[col_name]],
          reactive_career_placement_df()[[col_name]]
        )
      )
    )
    min <- min(col)
    max <- max(col)
    sliderInput(
      "ms_school_year", 
      label = "Middle School Graduating Year", 
      min = min, 
      max = max, 
      value = c(min, max), 
      sep = "",
      ticks = FALSE
    )
  })
  
  output$ms_graduation_year_slider_school_data <- renderUI({
    col_name <- 'Middle School Graduating Class'
    col <- sort(
      unique(
        c(reactive_entry_exit_grad_historical_df()[[col_name]])
      )
    )
    min <- min(col)
    max <- max(col)
    sliderInput(
      "ms_school_year_school_data", 
      label = "Middle School Graduating Year", 
      min = min, 
      max = max, 
      value = c(min, max), 
      sep = "",
      ticks = FALSE
    )
  })
  
  # school year slider
  output$school_year_slider <- renderUI({
    col_name <- 'School Year'
    col <- sort(
      unique(
        c(
          reactive_enrollment_historical_df()[[col_name]],
          reactive_attendance_historical_df()[[col_name]],
          reactive_free_reduced_lunch_historical_df()[[col_name]],
          reactive_iep_accommodations_historical_df()[[col_name]]
        )
      )
    )
    min <- 1
    max <- length(col)
    sliderTextInput(
      inputId = "school_year_slider_input",
      label = "School Year", 
      choices = col,
      selected = col[c(min, max)]
    )
  })
  
  # graduate support coalition checkbox
  output$graduate_support_coalition_checkbox <- renderUI({
    req(input$file2)
    checkboxInput("graduate_support_coalition_checkbox", "Show Coalition Comparison", value = TRUE, width = NULL)
  })
  
  # school data coalition checkbox
  output$school_data_coalition_checkbox <- renderUI({
    req(input$file2)
    checkboxInput("school_data_coalition_checkbox", "Show Coalition Comparison", value = TRUE, width = NULL)
  })
  
  output$school_historical_template <- downloadHandler(
    filename <- function() {
      paste("school-historical-template", ".xlsx", sep="")
    },
    
    content <- function(file) {
      file.copy("server/NMCSchoolHistoricalTemplate.xlsx", file)
    },
    )
  
  
  
  ### VISUALIZATIONS FOR GRADUATE SUPPORT
  source(file.path("server", "careerPlacement.R"),  local = TRUE)$value
  source(file.path("server", "hsGraduation.R"),  local = TRUE)$value
  source(file.path("server", "postSecondaryPlacement.R"),  local = TRUE)$value
  source(file.path("server", "postSecondaryCompletion.R"),  local = TRUE)$value

  ### VISUALIZATIONS FOR SCHOOL DATA
  source(file.path("server", "entryExitGrad.R"),  local = TRUE)$value
  source(file.path("server", "enrollment.R"),  local = TRUE)$value
  source(file.path("server", "attendance.R"),  local = TRUE)$value
  source(file.path("server", "freeReducedLunch.R"),  local = TRUE)$value
  source(file.path("server", "iepAccommodations.R"),  local = TRUE)$value
  
})
