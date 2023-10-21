# Title     : interface.R
# Objective : Interface
# Created by: greyhypotheses
# Created on: 06/01/2022


#' Programs
#'
source(file = 'R/functions/ExtensiveStudyData.R')
source(file = 'R/evaluation/AssumptionViolationsCox.R')
source(file = 'R/evaluation/SurvivalCurve.R')


#' Data
#'
#' Upload the study data, excluding implausible observations, and
#' its imputed form
#'
dataframes <- ExtensiveStudyData(upload = TRUE)
data <- dataframes$data
training_ <- dataframes$training_
data_ <- dataframes$data_


source(file = 'R/modelling/Multivariate.R')
analysis <- Multivariate(blob = training_)
analysis <- Multivariate(blob = data_)
analysis <- Multivariate(blob = data[complete.cases(data), ])

diagnostics <- analysis$diagnostics
model <- analysis$model


#' Training
#'
#' The Cox model is inappropriate, proportionality assumption does not hold.
#'
#' For time dependent cases:
#' https://www.emilyzabor.com/tutorials/survival_analysis_in_r_tutorial.html#Time-dependent_covariate
#' https://glmnet.stanford.edu/articles/Coxnet.html#cox-models-for-start-stop-data-1
#' https://www.rdocumentation.org/packages/glmnet/versions/4.1-3/topics/glmnet
#' https://www.rdocumentation.org/packages/survival/versions/3.2-13/topics/Surv
#'
#'


SurvivalCurve(data = training_, caption = 'Training Data (multiply imputed)')
ViolationsKaplan(data = training_)
ViolationsTime(model = model)
ViolationsProportionalityTable(model = model)








