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
  
  plot <- ggplot(data=filtered_df, aes(x=`School Year`, y=`Attendance Percentage`, group=1)) +
    ylim(0, 100) +
    geom_line(colour="#AFD2E9")+
    geom_point(colour="#AFD2E9", shape=21, fill="white") +
    geom_hline(aes(yintercept = Average), color="#002855") +
    theme_minimal() +
    theme(axis.text.x=element_text(angle=30,hjust=1))
  
  if(isTruthy(input$file2) && isTruthy(input$school_data_coalition_checkbox)) {
    df_coalition <- reactive_coalition_attendance_historical_df()
    req(df_coalition)
    filtered_df_coalition = slice(df_coalition, min_index:max_index)
    
    plot <- plot + geom_line(data=filtered_df_coalition, aes(x=`School Year`, y=`Attendance Percentage`), colour="#E15551") + 
      geom_point(data=filtered_df_coalition, aes(x=`School Year`, y=`Attendance Percentage`), colour="#E15551", shape=21, fill="white")
  }
  
  return (plot)
})