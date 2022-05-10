## VISUALIZATIONS for HISTORICAL HIGH SCHOOL GRADUATION RATES by middle school / high school graduating class

# calculation for reactive average high school graduation rate
average_entry_exit_grad_rate = reactive(round(mean(reactive_entry_exit_grad_historical_df()$`Graduates Originally Enrolled Percentage`, na.rm=TRUE), digits=1))

# store average high school graduation rate in a output to be displayed
output$average_entry_exit_grad_rate <- renderText(paste0(average_entry_exit_grad_rate(), "%"))

# table filtered by slider
output$entry_exit_grad_rate_table <- renderTable({
  df <- reactive_entry_exit_grad_historical_df()
  req(input$ms_school_year_school_data)
  min <- input$ms_school_year_school_data[1]
  max <- input$ms_school_year_school_data[2]
  filtered_df <- filter(df, between(`Middle School Graduating Class`, min, max))
  filtered_df$`Middle School Graduating Class` <- as.character(filtered_df$`Middle School Graduating Class`)
  return (filtered_df)
})

# plot filtered by slider
output$entry_exit_grad_rate_plot <- renderPlotly({
  df = reactive_entry_exit_grad_historical_df()
  req(df)
  req(input$ms_school_year_school_data)
  min <- input$ms_school_year_school_data[1]
  max <- input$ms_school_year_school_data[2]
  filtered_df = filter(df, between(`Middle School Graduating Class`, min, max))
  req(nrow(filtered_df) > 0)
  Average = average_entry_exit_grad_rate()
  
  plot <- ggplot(data=filtered_df, aes(x=`Middle School Graduating Class`, y=`Graduates Originally Enrolled Percentage`, group=1)) +
    ylim(0, 100) +
    xlim(min, max) + 
    scale_x_continuous(breaks = seq(min, max, by=1)) +
    geom_line(colour="#AFD2E9")+
    geom_point(colour="#AFD2E9", shape=21, fill="white") +
    geom_hline(aes(yintercept = Average), color="#002855") +
    theme_minimal() +
    theme(axis.text.x=element_text(angle=30,hjust=1))
  
  if(isTruthy(input$file2) && isTruthy(input$school_data_coalition_checkbox)) {
    df_coalition <- reactive_coalition_entry_exit_grad_historical_df()
    req(df_coalition)
    filtered_df_coalition = filter(df_coalition, between(`Middle School Graduating Class`, min, max))
    
    plot <- plot + geom_line(data=filtered_df_coalition, aes(x=`Middle School Graduating Class`, y=`Graduates Originally Enrolled Percentage`), colour="#E15551") + 
      geom_point(data=filtered_df_coalition, aes(x=`Middle School Graduating Class`, y=`Graduates Originally Enrolled Percentage`), colour="#E15551", shape=21, fill="white")
  }
  return (plot)
})