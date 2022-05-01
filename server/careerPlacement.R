## VISUALIZATIONS for CAREER PLACEMENT TRENDS by middle school / high school graduating class

# calculation for reactive average military career rate
average_military_career = reactive(round(mean(reactive_career_placement_df()$`Military`, na.rm=TRUE), digits=1))

# store average military career rate in a output to be displayed
output$average_military_career <- renderText(paste0(average_military_career(), "%"))


# calculation for reactive average graduate school placement rate
average_graduate_school_placement = reactive(round(mean(reactive_career_placement_df()$`Graduate School`, na.rm=TRUE), digits=1))

# store average graduate school placement rate in a output to be displayed
output$average_graduate_school_placement <- renderText(paste0(average_graduate_school_placement(), "%"))


# calculation for reactive average working professional career rate
average_working_professional_career = reactive(round(mean(reactive_career_placement_df()$`Working Professional Field`, na.rm=TRUE), digits=1))

# store average working professional rate in a output to be displayed
output$average_working_professional_career <- renderText(paste0(average_working_professional_career(), "%"))


# calculation for reactive average working nonprofessional career rate
average_working_nonprofessional_career = reactive(round(mean(reactive_career_placement_df()$`Working Non-Professional Field`, na.rm=TRUE), digits=1))

# store average working nonprofessional career rate in a output to be displayed
output$average_working_nonprofessional_career <- renderText(paste0(average_working_nonprofessional_career(), "%"))

# CAREER PLACEMENT TABLE OUTPUT 
# this is filtered by using the middle school graduating class year double slider
# it requires the year slider input to be defined prior to using it for filtering the table
# it filters between the minimum year and maximum year
output$career_placement_table <- renderTable({
  req(input$ms_school_year)
  df <- reactive_career_placement_df()
  min <- input$ms_school_year[1]
  max <- input$ms_school_year[2]
  filtered_df = filter(df, between(`Middle School Graduating Class`, min, max))
  filtered_df$`Middle School Graduating Class` <- as.character(filtered_df$`Middle School Graduating Class`)
  filtered_df$`High School Graduating Class` <- as.character(filtered_df$`High School Graduating Class`)
  filtered_df$`Post Secondary Follow Up Year` <- as.character(filtered_df$`Post Secondary Follow Up Year`)
  return (filtered_df)
})

# CAREER PLACEMENT BAR PLOT OUTPUT 
# this is filtered by using the middle school graduating class year double slider
# it requires the year slider input to be defined prior to creating a plot and using the slider to filter the table
# it filters between the minimum year and maximum year
# the follow up year min and max are used to calculate the x axis interval because the middle school graduating class year slider doesn't show on the x axis (the follow up year does)
output$career_placement_plot <- renderPlotly({
  df <- reactive_career_placement_df()
  req(input$ms_school_year)
  min <- input$ms_school_year[1]
  max <- input$ms_school_year[2]
  filtered_df = filter(df, between(`Middle School Graduating Class`, min, max))
  req(filtered_df$`Post Secondary Follow Up Year`)
  filtered_df.long <- pivot_longer(filtered_df, cols=4:7, names_to = "Type", values_to = "Percentage")
  fuy_min <- min(filtered_df$`Post Secondary Follow Up Year`)
  fuy_max <- max(filtered_df$`Post Secondary Follow Up Year`)
  plot <- ggplot(filtered_df.long, aes(x = `Post Secondary Follow Up Year`, y = `Percentage`, fill = `Type`)) + 
    geom_bar(stat = 'identity', position = position_stack()) +
    scale_fill_manual(values=c("#003a70", "#cb2c30", "#4392F1", "lightblue")) +
    geom_text(aes(x = `Post Secondary Follow Up Year`, y = `Percentage`, label = sprintf("%d%%", `Percentage`), group = `Type`, colour=`Type`),
              position = position_stack(vjust = .5), colour="white")+
    theme_minimal() +
    xlim(fuy_min, fuy_max) + 
    ylim(0, 100) +
    scale_x_continuous(breaks = seq(fuy_min, fuy_max, by=1))
  return (ggplotly(plot, tooltip = c("x", "y", "group")))
  
})