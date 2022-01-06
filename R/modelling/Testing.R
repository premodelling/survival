# Title     : Testing.R
# Objective : Testing
# Created by: greyhypotheses
# Created on: 06/01/2022

Testing <- function (model_core, model_boosted, testing_)  {

  # Core: Narrow external validation
  external_core <- survival::predict(object = model_core, newdata = testing_)
  # calibration plot
  # AUC
  # sensitivity analysis
  
  # Boosted
  external_boosted <- mboost::survFit(object = model_boosted, newdata = testing_ )
  # calibration plot
  # AUC
  # sensitivity analysis

}