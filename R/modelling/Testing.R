# Title     : Testing.R
# Objective : Testing
# Created by: greyhypotheses
# Created on: 06/01/2022

Testing <- function (model, preliminary)  {

  # Core: Narrow external validation
  estimates <- survival::predict(object = model, newdata = preliminary)
  # calibration plot
  # AUC
  # sensitivity analysis

  # Boosted
  # mboost::survFit(object = model, newdata = preliminary )
  # calibration plot
  # AUC
  # sensitivity analysis

}