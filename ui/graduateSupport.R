tabPanel("Graduate Support",
  h2("Graduate Support"),
    fluidRow(
      column(
        2,
        h3("Filters"),
        hr(),
        div(
          style = "card",
          class = "card",
          uiOutput("ms_graduation_year_slider"),
          uiOutput("graduate_support_coalition_checkbox")
        ),
        
      ),
      column(
        10,
        h3("High School Graduation Rates"),
        hr(),
        fluidRow(
          column(
            6, 
            div(
             style = "card",
             class = "card",
             h4("Plot"),
             plotlyOutput("hs_graduation_rate_plot")
            )
          ),
          column(
            6,
            div(
              style = "card",
              class = "card",
              h4("Historical Average"),
              h5("HS Graduation Rate"),
              textOutput("average_high_school_graduation_rate")
             ),
               
               br(),
               div(
                 style = "card",
                 class = "card",
                 h4("Data"),
                 tableOutput("hs_graduation_rate_table")
               ),
             ),
        ),
        
        h3("Post Secondary Placement"),
             hr(),
             fluidRow(column(
               6, div(
                 style = "card",
                 class = "card",
                 h4("Plot"),
                 plotlyOutput("post_secondary_placement_plot")
               )
             ),
             column(
               6,
               div(
                 style = "card",
                 class = "card",
                 h4("Historical Average"),
                 h5("4 year college placement"),
                 textOutput("average_4yr_ps_placement"),
                 h5("2 year college + trade/vocational placement"),
                 textOutput("average_2yr_ps_placement"),
               ),
               
               br(),
               div(
                 style = "card",
                 class = "card",
                 h4("Data"),
                 tableOutput("post_secondary_placement_table")
               )
             )),
             h3("Post Secondary Completion"),
             hr(),
             fluidRow(column(
               6, div(
                 style = "card",
                 class = "card",
                 h4("Plot"),
                 plotlyOutput("post_secondary_completion_plot")
               )
             ),
             column(
               6,
               div(
                 style = "card",
                 class = "card",
                 h4("Historical Average"),
                 h5("4 year college completion"),
                 textOutput("average_4yr_ps_completion"),
                 h5("2 year college + trade/vocational completion"),
                 textOutput("average_2yr_ps_completion"),
               ),
               
               br(),
               div(
                 style = "card",
                 class = "card",
                 h4("Data"),
                 tableOutput("post_secondary_completion_table")
               )
               
               
             )),
             h3("Career Placement"),
             hr(),
             fluidRow(column(
               6, div(
                 style = "card",
                 class = "card",
                 h4("Plot"),
                 plotlyOutput("career_placement_plot")
               )
             ),
             column(
               6,
               div(
                 style = "card",
                 class = "card",
                 h4("Historical Average"),
                 h5("Graduate school"),
                 textOutput("average_graduate_school_placement"),
                 h5("Working professional career"),
                 textOutput("average_working_professional_career"),
                 h5("Working nonprofessional career"),
                 textOutput("average_working_nonprofessional_career"),
                 h5("Military career"),
                 textOutput("average_military_career"),
               ),
               br(),
               div(
                 style = "card",
                 class = "card",
                 h4("Data"),
                 tableOutput("career_placement_table")
               )
             ))
           ),
           
         ))