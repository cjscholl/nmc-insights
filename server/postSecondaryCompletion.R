## VISUALIZATIONS for POST SECONDARY COMPLETION TRENDS by middle school / high school graduating class

# calculation for reactive average 2 year completion rate
average_2yr_ps_completion = reactive(round(mean(reactive_post_secondary_completion_df()$`2 Year + Trade/Vocational`, na.rm=TRUE), digits=1))

# store average 2 year completion rate in a output to be displayed
output$average_2yr_ps_completion <- renderText(paste0(average_2yr_ps_completion(), "%"))

# calculation for reactive average 4 year completion rate
average_4yr_ps_completion = reactive(round(mean(reactive_post_secondary_completion_df()$`4 Year`, na.rm=TRUE), digits=1))

# store average 4 year completion rate in a output to be displayed
output$average_4yr_ps_completion <- renderText(paste0(average_4yr_ps_completion(), "%"))

# table filtered by slider
output$post_secondary_completion_table <- renderTable({
  df <- reactive_post_secondary_completion_df()
  req(input$ms_school_year)
  min <- input$ms_school_year[1]
  max <- input$ms_school_year[2]
  filtered_df = filter(df, between(`Middle School Graduating Class`, min, max))
  filtered_df$`Middle School Graduating Class` <- as.character(filtered_df$`Middle School Graduating Class`)
  filtered_df$`High School Graduating Class` <- as.character(filtered_df$`High School Graduating Class`)
  filtered_df$`Post Secondary Follow Up Year` <- as.character(filtered_df$`Post Secondary Follow Up Year`)
  return (filtered_df)
})

# plot filtered by slider
output$post_secondary_completion_plot <- renderPlotly({
  df <- reactive_post_secondary_completion_df()
  req(input$ms_school_year)
  min <- input$ms_school_year[1]
  max <- input$ms_school_year[2]
  filtered_df = filter(df, between(`Middle School Graduating Class`, min, max))
  req(filtered_df$`Post Secondary Follow Up Year`)
  filtered_df.long <- pivot_longer(filtered_df, cols=4:6, names_to = "Type", values_to = "Percentage")
  fuy_min <- min(filtered_df$`Post Secondary Follow Up Year`)
  fuy_max <- max(filtered_df$`Post Secondary Follow Up Year`)
  plot <- ggplot(filtered_df.long, aes(x = `Post Secondary Follow Up Year`, y = `Percentage`, fill = `Type`)) + 
    geom_bar(stat = 'identity', position = position_stack()) +
    scale_fill_manual(values=c("#003a70", "#cb2c30", "#4392F1")) +
    geom_text(aes(x = `Post Secondary Follow Up Year`, y = `Percentage`, label = sprintf("%d%%", `Percentage`), group = `Type`, colour=`Type`),
              position = position_stack(vjust = .5), colour="white")+
    theme_minimal() +
    theme(axis.text.x=element_text(angle=30,hjust=1)) +
    xlim(fuy_min, fuy_max) + 
    ylim(0, 100) +
    scale_x_continuous(breaks = seq(fuy_min, fuy_max, by=1))
  if(isTruthy(input$file2) && isTruthy(input$graduate_support_coalition_checkbox)) {
    df_coalition <- bind_rows(list(School=reactive_post_secondary_completion_df(), Coalition=reactive_coalition_post_secondary_completion_df()), .id="id")
    filtered_df = filter(df_coalition, between(`Middle School Graduating Class`, min, max))
    req(filtered_df$`Post Secondary Follow Up Year`)
    filtered_df.long <- pivot_longer(filtered_df, cols=5:7, names_to = "Type", values_to = "Percentage")
    req(filtered_df.long$`Post Secondary Follow Up Year`)
    plot <- ggplot(filtered_df.long, aes(x = `Post Secondary Follow Up Year`, y = `Percentage`, fill = `Type`)) + 
      geom_bar(stat = 'identity', position = position_stack()) +
      scale_fill_manual(values=c("#003a70", "#cb2c30", "#4392F1")) +
      facet_grid(id~., switch = "y") +
      scale_x_continuous(breaks = seq(fuy_min, fuy_max, by=1)) +
      geom_text(aes(x = `Post Secondary Follow Up Year`, y = `Percentage`, label = sprintf("%d%%", `Percentage`), group = `Type`, colour=`Type`),
                position = position_stack(vjust = .5), colour="white") +
      theme_minimal() +
      theme(axis.text.x=element_text(angle=30,hjust=1)) +
      xlim(fuy_min, fuy_max) + 
      ylim(0, 100) +
      scale_x_continuous(breaks = seq(fuy_min, fuy_max, by=1))
    
  }
  return (ggplotly(plot, tooltip = c("x", "y", "group")))
  
})