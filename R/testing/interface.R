# Title     : interface.R
# Objective : Interface
# Created by: greyhypotheses
# Created on: 09/01/2022


#' testing
#' multiple imputation & complete case
#'

# Unboosted: Narrow external validation
predict(object = model, newdata = testing_)
# calibration plot
# AUC
# sensitivity analysis

# Boosted: Narrow external validation
# mboost::survFit(object = model, newdata = testing_)
# calibration plot
# AUC
# sensitivity analysis
