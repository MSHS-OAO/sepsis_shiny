server <- function(input, output, session) {
  
  # data_reactive <- eventReactive(input$update_filters, 
  #                       {
  #                         data_update <- data %>% filter()
  #                       })
  output$volume_by_alert_type <- function() {
    data <- data %>% filter(alert_initially_shown_time_est >= as.POSIXct("2024-03-15 00:00:00"))
    
    table_data <- data %>% group_by(alert_subtype) %>% summarise(Count = n()) %>%
                  adorn_totals("row")
    
    kable(data, )
  }
}
