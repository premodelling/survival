# Title     : Imputation.R
# Objective : Imputation
# Created by: greyhypotheses
# Created on: 04/01/2022



#' Imputation
#'
#' @param training: the training data set
#'
Imputation <- function (data) {
  imputation <- mice::mice(data = data, m = 13, maxit = 10, seed = 5)
  return(imputation)
}


