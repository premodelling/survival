# Title     : Imputation.R
# Objective : Imputation
# Created by: greyhypotheses
# Created on: 04/01/2022



#' Imputation: Training Data
#'
#' @param training: the training data set
#'
ImputationTraining <- function (training_) {
  imputation <- mice::mice(data = training_, m = 13, maxit = 10, seed = 5)
  return(imputation)
}



#' Imputation: Testing
#'
#' @param testing: The data set for testing
#'
ImputationTesting <- function (testing_) {
  imputation <- mice::mice(data = testing_, m = 13, maxit = 10, seed = 5)
  return(imputation)
}
