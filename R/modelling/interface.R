# Title     : interface.R
# Objective : Interface
# Created by: greyhypotheses
# Created on: 06/01/2022



#' Programs
#'
source(file = 'R/functions/StudyData.R')
source(file = 'R/functions/TemporalSplit.R')
source(file = 'R/modelling/ImputationStep.R')
source(file = 'R/modelling/ModelCOXPH.R')


#' The data set
#'
data <- StudyData()
str(data)


#' Splitting
#'
dataframes <- TemporalSplit(data = data)
training <- dataframes$training
testing <- dataframes$testing


#' Imputation
#'
#'
#' ...  re-calculate: censored & outcome_date, and add deceased
#' ...  the imputation variables exclude: outcome_date (date can't be used
#'      in the MICE models, time_to _outcome in lieu), censored (it is a project
#'      variable created for analysis & graphing purposes)

# all variables for training phase
variables <- c('admission_date', 'age_group', 'sex', 'asthma', 'liver_mild', 'renal',
               'pulmonary', 'neurological', 'liver_mod_severe', 'malignant_neoplasm',
               'outcome', 'time_to_outcome')

# exclude these variables during the testing phase
dependent <- c('outcome', 'time_to_outcome')

# for training
training_ <- ImputationStep(initial = training[, variables],
                            phase = 'training', upload = TRUE)

# for testing
testing_ <- ImputationStep(initial = testing[, variables],
                           phase = 'testing', upload = TRUE)


#' Training
#'
#' The Cox model is inappropriate, however consider including univariate analysis for appropriate covariates
#'
#' For time depedent cases
#' https://www.emilyzabor.com/tutorials/survival_analysis_in_r_tutorial.html#Time-dependent_covariate
#' https://glmnet.stanford.edu/articles/Coxnet.html#cox-models-for-start-stop-data-1
#' https://www.rdocumentation.org/packages/glmnet/versions/4.1-3/topics/glmnet
#' https://www.rdocumentation.org/packages/survival/versions/3.2-13/topics/Surv
#'
#'
unboosted <- ModelCOXPH(training_ = training_, upload = FALSE)

#









