# Title     : PredictorTest.R
# Objective : Investigate and understand plausible missing data patterns
# Created by: greyhypotheses
# Created on: 01/01/2022

#' PredictorTest
#' 
#' @description determines if the missing values of predictor `field` are associated with any of 
#'              the other variables of `instances`
#' 
#' @param field:
#' @param instances: the data frame of the outcome, the prospective predictors, and pertinent auxiliary variables.
#' 
#' @return
#' 
PredictorTest <- function (predictor, instances){

  # create the missing indicator w.r.t. predictor `predictor`
  focus <- instances %>%
    mutate(missing = factor(x = as.numeric(is.na(instances[, predictor]))))
  
  # create the equation of predictors, excluding `predictor` and its indicator variable `missing`
  elements <- names(focus)[!(names(focus) %in% c(predictor, 'missing'))]
  equation <- stringr::str_c(elements, collapse = ' + ')

  # logistic regression
  model <- stats::glm(formula = stats::formula(x = paste('missing ~ ', equation)),
                      data = focus, family = binomial())

  # model analysis
  analysis <- summary(object = model)
  print(analysis)

  # the coefficients
  estimates <- analysis$coefficients
  estimates <- estimates[rownames(estimates) != "(Intercept)",]
  estimates_ <- data.frame(estimates)

  # predictors/elements that might explain the missing values of `predictor`
  possible <- estimates_[estimates_$Pr...z.. <= 0.05,]
  print(possible)

  if (nrow(possible) > 0) {
    card <- data.frame(associations = TRUE, elements = stringr::str_c(row.names(possible), collapse = ', '), row.names = predictor)
  } else {
    card <- data.frame(associations = FALSE, elements = '', row.names = predictor)
  }

  return(card)

}