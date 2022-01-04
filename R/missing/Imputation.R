# Title     : Imputation.R
# Objective : Imputation
# Created by: greyhypotheses
# Created on: 04/01/2022



#' Imputation: The variables for ...
#'
ImputationVariables <- function () {
  variables <- c('admission_date', 'age_group', 'sex', 'asthma', 'liver_mild', 'renal',
                 'pulmonary', 'neurological', 'liver_mod_severe', 'malignant_neoplasm',
                 'outcome', 'time_to_outcome')
  return(variables)
}


#' Imputation: Training Data
#'
#' @param training: the training data set
#'
ImputationTraining <- function (training) {
  variables <- ImputationVariables()
  imputation <- mice::mice(data = training[, variables], m = 10, maxit = 10, seed = 5)
  return(imputation)
}



#' Imputation: Testing
#'
#' @param testing: The data set for testing
#'
ImputationTesting <- function (testing) {
  variables <- ImputationVariables()
  keys <- variables[!(variables %in% c('outcome', 'time_to_outcome'))]
  imputation <- mice::mice(data = testing[, keys], m = 10, maxit = 10, seed = 5)
  return(imputation)
}

