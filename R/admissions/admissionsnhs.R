# Title     : admissionsnhs.R
# Objective : NHS Source
# Created by: greyhypotheses
# Created on: 02/01/2022

AdmissionsNHS <- function () {

  # the age groups
  age_groups <- c('0-5', '6-17', '18-64', '65-84', '85+')

  # data reader
  get_ <- function (age_group) {
    age_group
    readxl::read_xlsx(path = 'data/Covid-Publication-13-08-2020.xlsx',
                      sheet = str_glue('Admissions {age_group}'),
                      range = 'F13:ER14')

  }
  items <- lapply(X = age_groups, FUN = get_)

  # structuring
  readings <- dplyr::bind_rows(items)
  readings$age_group <- age_groups
  readings <- tibble::column_to_rownames(readings, var = 'age_group')

  # set dates as index
  readings <- t(readings)






}