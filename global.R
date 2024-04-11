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


base_file_path <- "/SharedDrive/deans/Presidents/HSPI-PM/Operations Analytics and Optimization/Projects/System Operations/Sepsis Module Dashboard/"
data <- read_csv(paste0(base_file_path, "care_alerts_external_reporting_copy.csv"))

