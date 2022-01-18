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
testing_ <- dataframes$testing_
data_ <- dataframes$data_

even <- data[complete.cases(data),]

source(file = 'R/modelling/Univariate.R')
analysis <- Univariate(blob = training_)
analysis <- Univariate(blob = data_)
analysis <- Univariate(blob = even)


source(file = 'R/modelling/Multivariate.R')
analysis <- Multivariate(blob = training_)
analysis <- Multivariate(blob = data_)
analysis <- Multivariate(blob = even)


#' Training
#'
#' The Cox model is inappropriate, proportionality assumption does not hold.
#'
#' For time depedent cases:
#' https://www.emilyzabor.com/tutorials/survival_analysis_in_r_tutorial.html#Time-dependent_covariate
#' https://glmnet.stanford.edu/articles/Coxnet.html#cox-models-for-start-stop-data-1
#' https://www.rdocumentation.org/packages/glmnet/versions/4.1-3/topics/glmnet
#' https://www.rdocumentation.org/packages/survival/versions/3.2-13/topics/Surv
#'
#'


SurvivalCurve(data = training_, caption = 'Training Data (multiply imputed)')
ViolationsKaplan(data = training_)
ViolationsTime(model = unboosted)
ViolationsProportionalityTable(model = unboosted)








