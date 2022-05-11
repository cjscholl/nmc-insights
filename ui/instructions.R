tabPanel("Instructions", 
         h2("Instructions"), 
         p("Please upload your school spreadsheet(s) - Historical School (required) and Coalition (optional) - using the upload buttons below. Once you have uploaded your spreadsheet(s), you can use the menu to navigate to various charts and tables."),
         hr(),
         fluidRow(
           column(4,
                  # Input: Select a file ----
                  fileInput("file1", "Choose Historical School Excel File",
                            multiple = FALSE,
                            accept = c("text/csv",
                                       "text/comma-separated-values,text/plain",
                                       ".csv",
                                       ".xlsx",
                                       ".xls")),
                  downloadButton("school_historical_template", label = "Download the historical template")
           ),
           column(8,
                  fileInput("file2", "Optional: Choose Historical Coalition File",
                            multiple = FALSE,
                            accept = c("text/csv",
                                       "text/comma-separated-values,text/plain",
                                       ".csv",
                                       ".xlsx",
                                       ".xls")),
           )
         ),
         
)
