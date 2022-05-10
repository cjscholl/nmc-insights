## VISUALIZATIONS for POST SECONDARY PLACEMENT TRENDS by middle school / high school graduating class

# calculation for reactive average 2 year placement rate
average_2yr_ps_placement = reactive(round(mean(reactive_post_secondary_placement_df()$`2 Year + Trade/Vocational`, na.rm=TRUE), digits=1))

# store average 2 year placement rate in a output to be displayed
output$average_2yr_ps_placement <- renderText(paste0(average_2yr_ps_placement(), "%"))

# calculation for reactive average 4 year placement rate
average_4yr_ps_placement = reactive(round(mean(reactive_post_secondary_placement_df()$`4 Year`, na.rm=TRUE), digits=1))

# store average 4 year placement rate in a output to be displayed
output$average_4yr_ps_placement <- renderText(paste0(average_4yr_ps_placement(), "%"))

# table filtered by slider
output$post_secondary_placement_table <- renderTable({
  df <- reactive_post_secondary_placement_df()
  req(input$ms_school_year)
  min <- input$ms_school_year[1]
  max <- input$ms_school_year[2]
  filtered_df = filter(df, between(`Middle School Graduating Class`, min, max))
  filtered_df$`Middle School Graduating Class` <- as.character(filtered_df$`Middle School Graduating Class`)
  filtered_df$`High School Graduating Class` <- as.character(filtered_df$`High School Graduating Class`)
  return (filtered_df)
})

# plot filtered by slider
output$post_secondary_placement_plot <- renderPlotly({
  df <- reactive_post_secondary_placement_df()
  req(input$ms_school_year)
  min <- input$ms_school_year[1]
  max <- input$ms_school_year[2]
  filtered_df = filter(df, between(`Middle School Graduating Class`, min, max))
  req(filtered_df$`High School Graduating Class`)
  filtered_df.long <- pivot_longer(filtered_df, cols=3:4, names_to = "Placement Type", values_to = "Percentage")
  req(filtered_df.long$`High School Graduating Class`)
  hs_min <- min(filtered_df$`High School Graduating Class`)
  hs_max <- max(filtered_df$`High School Graduating Class`)
  req(hs_min)
  plot <- ggplot(filtered_df.long, aes(x = `High School Graduating Class`, y = `Percentage`, fill = `Placement Type`)) + 
    geom_bar(stat = 'identity', position = position_stack()) +
    scale_fill_manual(values=c("#003a70", "#cb2c30")) +
    geom_text(aes(x = `High School Graduating Class`, y = `Percentage`, label = sprintf("%d%%", `Percentage`), group = `Placement Type`, colour=`Placement Type`),
              position = position_stack(vjust = .5), colour="white") +
    theme_minimal() +
    theme(axis.text.x=element_text(angle=30,hjust=1)) +
    xlim(hs_min, hs_max) + 
    ylim(0, 100) +
    scale_x_continuous(breaks = seq(hs_min, hs_max, by=1))
  return (ggplotly(plot, tooltip = c("x", "y", "group")))
})