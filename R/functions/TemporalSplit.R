# Title     : TemporalSplit.R
# Objective : Temporal Splitting
# Created by: greyhypotheses
# Created on: 04/01/2022

#' TemporalSplit
#'
#' @description Splits the data set into traiing &testing sets via the admission date.  It is split at the 3rd
#'              quartile point of the admission date
#'
#' @param data: the data sete
TemporalSplit <- function (data) {

  # the date at the 3rd quartile point
  q <- quantile(x = as.numeric(data$admission_date), probs = 0.75, names = FALSE)
  splitdate <- as.Date(q, origin = '1970-01-01')

  # split the data set
  training <- data[data$admission_date < splitdate,]
  testing <- data[data$admission_date >= splitdate,]

  return(list(training = training, testing = testing))

}


