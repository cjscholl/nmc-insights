tabPanel("School Data",
         h2("Historical School Data"),
         fluidRow(
           column(
             2,
             h3("Filters"),
             hr(),
             div(
               style = "card",
               class = "card",
               uiOutput("ms_graduation_year_slider_school_data"),
               br(),
               uiOutput("school_year_slider")
             ),
           ),
           column(
             10,
             h3("Entry to Exit Graduation Trend"),
             hr(),
             fluidRow(
               column(
                 6, 
                 div(
                   style = "card",
                   class = "card",
                   h4("Plot"),
                   plotlyOutput("entry_exit_grad_rate_plot")
                 )
               ),
               column(
                 6,
                 div(
                   style = "card",
                   class = "card",
                   h4("Historical Average"),
                   h5("Entry to Exit Graduates"),
                   textOutput("average_entry_exit_grad_rate")
                 ),
                 
                 br(),
                 div(
                   style = "card",
                   class = "card",
                   h4("Data"),
                   tableOutput("entry_exit_grad_rate_table")
                 ),
               ),
             ),
             
             h3("Enrollment"),
             hr(),
             fluidRow(
               column(
                 6, 
                 div(
                   style = "card",
                   class = "card",
                   h4("Plot"),
                   plotlyOutput("enrollment_rate_plot")
                 )
               ),
               column(
                 6,
                 div(
                   style = "card",
                   class = "card",
                   h4("Historical Average"),
                   h5("Enrollment"),
                   textOutput("average_enrollment_rate")
                 ),
                 
                 br(),
                 div(
                   style = "card",
                   class = "card",
                   h4("Data"),
                   tableOutput("enrollment_rate_table")
                 ),
               ),
             ),
             
             h3("Attendance"),
             hr(),
             fluidRow(
               column(
                 6, 
                 div(
                   style = "card",
                   class = "card",
                   h4("Plot"),
                   plotlyOutput("attendance_rate_plot")
                 )
               ),
               column(
                 6,
                 div(
                   style = "card",
                   class = "card",
                   h4("Historical Average"),
                   h5("Attendance"),
                   textOutput("average_attendance_rate")
                 ),
                 
                 br(),
                 div(
                   style = "card",
                   class = "card",
                   h4("Data"),
                   tableOutput("attendance_rate_table")
                 ),
               ),
             ),
             
             h3("Free/Reduced Lunch"),
             hr(),
             fluidRow(
               column(
                 6, 
                 div(
                   style = "card",
                   class = "card",
                   h4("Plot"),
                   plotlyOutput("free_reduced_lunch_trend_plot")
                 )
               ),
               column(
                 6,
                 div(
                   style = "card",
                   class = "card",
                   h4("Historical Average"),
                   h5("Attendance"),
                   textOutput("average_free_reduced_lunch_trend")
                 ),
                 
                 br(),
                 div(
                   style = "card",
                   class = "card",
                   h4("Data"),
                   tableOutput("free_reduced_lunch_trend_table")
                 ),
               ),
             ),
             
             h3("IEP/Accommodations"),
             hr(),
             fluidRow(
               column(
                 6, 
                 div(
                   style = "card",
                   class = "card",
                   h4("Plot"),
                   plotlyOutput("iep_accommodations_trend_plot")
                 )
               ),
               column(
                 6,
                 div(
                   style = "card",
                   class = "card",
                   h4("Historical Average"),
                   h5("Attendance"),
                   textOutput("average_iep_accommodations_trend")
                 ),
                 
                 br(),
                 div(
                   style = "card",
                   class = "card",
                   h4("Data"),
                   tableOutput("iep_accommodations_trend_table")
                 ),
               ),
             ),
             
           ),
           
         ))