# Title     : Testing.R
# Objective : Testing
# Created by: greyhypotheses
# Created on: 06/01/2022

Testing <- function (model, data)  {

  # Core: Narrow external validation
  estimates <- predict(object = model, newdata = data)
  # calibration plot
  # AUC
  # sensitivity analysis

  # Boosted
  # mboost::survFit(object = model, newdata = data)
  # calibration plot
  # AUC
  # sensitivity analysis

}