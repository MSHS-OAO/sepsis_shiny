ui <- fluidPage(
        titlePanel(
          h1("Clinical Command Center - Sepsis Use Case Process Metrics", style = "color:black", align = 'center'),
        ),
        fluidRow(
          column(2,
                 dateRangeInput(
                   inputId = "time_est",
                   label = NULL,
                   start = min_est_date,
                   end = max_est_date
                 )
                 ),
          column(2,
                 pickerInput(inputId = "dept_type_census",
                             label = NULL,
                             multiple = TRUE,
                             choices = dept_type_census_default,
                             selected = dept_type_census_default
                 )
                 ),
          column(2,
                 pickerInput(inputId = "alert_subtype",
                             label = NULL,
                             multiple = TRUE,
                             choices = alert_subtype_default,
                             selected = alert_subtype_default)
                 ),
          column(2,
                 pickerInput(inputId = "outcome_category", 
                             label = NULL,
                             multiple = TRUE,
                             choices = alert_subtype_default,
                             selected = alert_subtype_default)
                 ),
          column(2,
                 actionButton("update_filters", label = "Update Filters")
                 )

        ),
        tableOutput("volume_by_alert_type")
      
    )
