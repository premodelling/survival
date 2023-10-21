# Title     : StudyStart.R
# Objective : TODO
# Created by: greyhypotheses
# Created on: 14/01/2022

StudyStart <- function () {

  dates <- data.table::fread(file = 'data/sars.csv', select='admission_date', data.table = FALSE)
  initial <- as.Date('2020-02-14', format = '%Y-%m-%d')
  initial <- min(initial,  min(dates$admission_date))

  return(initial)

}