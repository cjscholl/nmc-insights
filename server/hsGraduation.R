## VISUALIZATIONS for HISTORICAL HIGH SCHOOL GRADUATION RATES by middle school / high school graduating class

# calculation for reactive average high school graduation rate
average_high_school_graduation_rate = reactive(round(mean(reactive_hs_graduation_rate_historical_df()$`High School Graduation Rate`, na.rm=TRUE), digits=1))
average_coalition_high_school_graduation_rate = reactive({
  if(is.null(input$file2)){
    return (NULL)
  }
  else return (round(mean(reactive_coalition_hs_graduation_rate_historical_df()$`High School Graduation Rate`, na.rm=TRUE), digits=1))
})

# store average high school graduation rate in a output to be displayed
output$average_high_school_graduation_rate <- renderText(paste0(average_high_school_graduation_rate(), "%"))

# table filtered by slider
output$hs_graduation_rate_table <- renderTable({
  df <- reactive_hs_graduation_rate_historical_df()
  req(input$ms_school_year)
  min <- input$ms_school_year[1]
  max <- input$ms_school_year[2]
  filtered_df = filter(df, between(`Middle School Graduating Class`, min, max))
  filtered_df$`Middle School Graduating Class` <- as.character(filtered_df$`Middle School Graduating Class`)
  filtered_df$`High School Graduating Class` <- as.character(filtered_df$`High School Graduating Class`)
  return (filtered_df)
})

# plot filtered by slider
output$hs_graduation_rate_plot <- renderPlotly({
  df = reactive_hs_graduation_rate_historical_df()
  req(input$ms_school_year)
  min <- input$ms_school_year[1]
  max <- input$ms_school_year[2]
  filtered_df = filter(df, between(`Middle School Graduating Class`, min, max))
  hs_min <- min(filtered_df$`High School Graduating Class`)
  hs_max <- max(filtered_df$`High School Graduating Class`)
  req(nrow(filtered_df) > 0)
  Average = average_high_school_graduation_rate()
  
  plot <- ggplot(data=filtered_df, aes(x=`High School Graduating Class`, y=`High School Graduation Rate`, group=1)) +
    ylim(0, 100) +
    xlim(hs_min, hs_max) + 
    scale_x_continuous(breaks = seq(hs_min, hs_max, by=1)) +
    geom_line(colour="#AFD2E9")+
    geom_point(colour="#AFD2E9", shape=21, fill="white") +
    geom_hline(aes(yintercept = Average), color="#002855") +
    theme_minimal() +
    theme(axis.text.x=element_text(angle=30,hjust=1))

  if(isTruthy(input$file2) && isTruthy(input$graduate_support_coalition_checkbox)) {
    df_coalition <- reactive_coalition_hs_graduation_rate_historical_df()
    req(df_coalition)
    filtered_df_coalition = filter(df_coalition, between(`Middle School Graduating Class`, min, max))
    
    plot <- plot + geom_line(data=filtered_df_coalition, aes(x=`High School Graduating Class`, y=`High School Graduation Rate`), colour="#E15551") + 
      geom_point(data=filtered_df_coalition, aes(x=`High School Graduating Class`, y=`High School Graduation Rate`), colour="#E15551", shape=21, fill="white")
  }
  
  return (plot)
  
})