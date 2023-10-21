# Title     : AdmissionsNHS.R
# Objective : England's NHS COVID Admissions
# Created by: greyhypotheses
# Created on: 02/01/2022

AdmissionsNHS <- function () {

  # the age groups
  age_groups <- c('0-5', '6-17', '18-64', '65-84', '85+')

  # data reader
  get_ <- function (age_group) {

    # read
    data <- readxl::read_xlsx(path = 'data/Covid-Publication-13-08-2020.xlsx',
                              sheet = stringr::str_glue('Admissions {age_group}'),
                              range = 'F13:ER14')

    # set the row name to 'age_group'
    data$age_group <- age_group
    data <- tibble::column_to_rownames(data, var = 'age_group')

    return(data)

  }
  items <- lapply(X = age_groups, FUN = get_)

  # structuring
  readings <- dplyr::bind_rows(items)

  # set dates as index
  readings <- as.data.frame(t(readings))

  return(readings)

}