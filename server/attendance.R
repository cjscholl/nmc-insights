## VISUALIZATIONS for HISTORICAL ATTENDANCE RATES by school year

# calculation for reactive average attendance rate
average_attendance_rate = reactive(round(mean(reactive_attendance_historical_df()$`Attendance Percentage`, na.rm=TRUE), digits=1))

# store average attendance rate in a output to be displayed
output$average_attendance_rate <- renderText(paste0(average_attendance_rate(), "%"))

# table filtered by slider
output$attendance_rate_table <- renderTable({
  df <- reactive_attendance_historical_df()
  req(input$school_year_slider_input)
  min <- input$school_year_slider_input[1]
  max <- input$school_year_slider_input[2]
  match_min_index <- match(min,df$`School Year`)
  min_index <- if (is.na(match_min_index)) 1 else match_min_index
  match_max_index <- match(max,df$`School Year`)
  n <- length(df$`School Year`)
  max_index <- if (is.na(match_max_index)) n else match_max_index
  filtered_df = slice(df, min_index:max_index)
  return (filtered_df)
})

# plot filtered by slider
output$attendance_rate_plot <- renderPlotly({
  df = reactive_attendance_historical_df()
  req(input$school_year_slider_input)
  min <- input$school_year_slider_input[1]
  max <- input$school_year_slider_input[2]
  match_min_index <- match(min,df$`School Year`)
  min_index <- if (is.na(match_min_index)) 1 else match_min_index
  match_max_index <- match(max,df$`School Year`)
  n <- length(df$`School Year`)
  max_index <- if (is.na(match_max_index)) n else match_max_index
  filtered_df = slice(df, min_index:max_index)
  req(nrow(filtered_df) > 0)
  Average = average_attendance_rate()
  
  ggplot(data=filtered_df, aes(x=`School Year`, y=`Attendance Percentage`, group=1)) +
    ylim(0, 100) +
    geom_line(colour="navy")+
    geom_point()+
    geom_hline(aes(yintercept = Average), color="red") +
    theme_minimal()
})