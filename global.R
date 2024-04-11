library(DBI)
library(odbc)
library(tidyverse)
library(pool)
library(shiny)
library(shinydashboard)
library(shinydashboardPlus)
library(shinycssloaders)
library(rhandsontable)
library(glue)
library(assertr)
library(shinyWidgets)
library(janitor)


# Read in Data ------------------------------------------------------------
base_file_path <- "/SharedDrive/deans/Presidents/HSPI-PM/Operations Analytics and Optimization/Projects/System Operations/Sepsis Module Dashboard/"
data_raw <- read_csv(paste0(base_file_path, "care_alerts_external_reporting_copy.csv"))


# Raw Data Processing --------------------------------------------------------
data <- data_raw %>% 
  filter(alert_after_pilot_start_date == TRUE & (improperly_flagged == FALSE | is.na(improperly_flagged)) & in_msb_pilot == TRUE, alert_initially_shown_time >= as.POSIXct("2024-01-11 00:00:00")
         )




# Filter Defaults ---------------------------------------------------------
dept_type_census_default <- data %>% select(department_type_census) %>% distinct() %>% pull(department_type_census) 
alert_subtype_default <- data %>% select(alert_subtype) %>% distinct() %>% pull(alert_subtype) 
outcome_category_default <- data %>% select(outcome_category) %>% distinct() %>% pull(outcome_category)
min_est_date <- data %>% mutate(min_date = min(alert_initially_shown_time_est)) %>% select(min_date) %>% distinct() %>% mutate(min_date = format(min_date, "%Y-%m-%d")) %>% pull(min_date)
max_est_date <- data %>% mutate(max_date = max(alert_initially_shown_time_est)) %>% select(max_date) %>% distinct() %>% mutate(max_date = format(max_date, "%Y-%m-%d")) %>% pull(max_date)

