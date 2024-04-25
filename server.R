server <- function(input, output, session) {
  
  # data_reactive <- eventReactive(input$update_filters, 
  #                       {
  #                         data_update <- data %>% filter()
  #                       })
  output$volume_by_alert_type <- function() {
    data <- data %>% filter(alert_initially_shown_time_est >= as.POSIXct("2024-03-15 00:00:00"))
    
    
    total_alerts_data <- volume_by_alert_type(data, data, "total")
    total_alerts_ch_action <- volume_by_alert_type(data %>% filter(alert_has_ch_action == TRUE), data, "ch action")
    alerts_epic_resolution <- volume_by_alert_type(data %>% filter(alert_resolved_flag == TRUE), data, "epic resolution")
    
    
    data_combined <- total_alerts_data %>% full_join(total_alerts_ch_action) %>% full_join(alerts_epic_resolution)
    
    column_names <- c("Alert Subtype", "Count", "%", "Alerts with CH Action", "% w CH Action", "Count Resolved", "% Resolved")
    
    kable(data_combined, "html", align = "c", col.names = column_names) %>%
      add_header_above(c("  " = 1, "Total Alerts" = 2, "Alerts with CH Action" = 2, "Alerts with Epic Resolultion" = 2),background = "#212070", color = "white")%>%
      kable_styling(bootstrap_options = c("hover", "bordered", "striped"), 
                    full_width = FALSE, position = "center", 
                    row_label_position = "c", font_size = 16)
  }
  
  output$time_to_action <- function() {
    data <- data %>% filter(alert_initially_shown_time_est >= as.POSIXct("2024-03-15 00:00:00"))
    
    alert_shown_to_ch_action <- data %>% group_by(alert_subtype) %>% summarise(avg = mean(hours_to_ch_action, na.rm = T),
                                                                               median = median(hours_to_ch_action, na.rm = T))
    
    ch_action_epic_resolution <- data %>% filter(alert_resolved_flag == TRUE) %>%
      group_by(alert_subtype) %>% summarise(avg_epic_res = mean(hours_from_first_action_to_completion, na.rm = T),
                                            median_epic_res = median(hours_from_first_action_to_completion, na.rm = T))
    
    alert_shown_to_epic_res <- data %>% filter(alert_resolved_flag == TRUE) %>% group_by(alert_subtype) %>%
      summarise(avg_epic_res_alert = mean(hours_from_alert_shown_to_completed, na.rm = T),
                median_epic_res_alert = median(hours_from_alert_shown_to_completed, na.rm = T))
    
    data_combined <- alert_shown_to_ch_action %>% full_join(ch_action_epic_resolution) %>% full_join(alert_shown_to_epic_res)
    
    kable(data_combined, "html", align = "c") %>%
      add_header_above(c("  " = 1, "Alerts Show to CH Action (Hrs)" = 2, "CH Action to Epic Resolution (Hrs)" = 2, "Total: Alert Shown to Epic Res (Hrs)" = 2),background = "#212070", color = "white")%>%
      kable_styling(bootstrap_options = c("hover", "bordered", "striped"),
                    full_width = FALSE, position = "center",
                    row_label_position = "c", font_size = 16)
    
    
    
    
  }
  
}
