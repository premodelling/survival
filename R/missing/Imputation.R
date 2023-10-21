# Title     : Imputation.R
# Objective : Imputation
# Created by: greyhypotheses
# Created on: 04/01/2022



#' Imputation
#'
#' @param training: the training data set
#'
#' @note https://www.rdocumentation.org/packages/mice/versions/3.15.0/topics/mice
#'       https://www.gerkovink.com/miceVignettes/Passive_Post_processing/Passive_imputation_post_processing.html
#'       Try a named method list, especially for explicit exlusions of columns
#'
Imputation <- function (data) {
  imputation <- mice::mice(data = data, m = 13, maxit = 10, seed = 5)
  return(imputation)
}


