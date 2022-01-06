# Title     : main
# Objective : Exploration
# Created by: greyhypotheses
# Created on: 29/12/2021



#' Programs
#'
source(file = 'R/functions/StudyData.R')

source(file = 'R/missing/Pattern.R')
source(file = 'R/missing/MechanismTest.R')

source(file = 'R/functions/TemporalSplit.R')
source(file = 'R/missing/Imputation.R')
source(file = 'R/missing/ImputationProcessing.R')



#' The data set
#'
data <- StudyData()
str(data)



#' NA Patterns
#'
PatterInstanceNA(data = data)
PatternDendogramNA(data = data)
PatternVariableNA(data = data)



#' NA of predictor ~ model variables
#' Investigating associations between NA series and [model + auxiliary] variables
#'
#' ... at a bare minimum, the are a few MAR cases
#' ... no discernible associations with auxiliary variables
#'
variables <- c('admission_date', 'age_group', 'sex', 'asthma', 'liver_mild', 'renal',
               'pulmonary', 'neurological', 'liver_mod_severe', 'malignant_neoplasm',
               'outcome', 'outcome_date')
focus <- c('sex', 'asthma', 'liver_mild', 'renal', 'pulmonary',
            'neurological', 'liver_mod_severe', 'malignant_neoplasm')
instances <- data[, variables]

details <- mapply(FUN = MechanismTest, predictor = focus,
                  MoreArgs = list(instances = instances))
data.frame(t(details))




#' Splitting
#'
dataframes <- TemporalSplit(data = data)
training <- dataframes$training
testing <- dataframes$testing



#' Imputation
#' In progress
#'
#' ...  re-calculate: censored & outcome_date, and add deceased
#' ...  the imputation variables exclude: outcome_date (date can't be used
#'      in the MICE models, time_to _outcome in lieu), censored (it is a project
#'      variable created for analysis & graphing purposes)
imputationvariables <- c('admission_date', 'age_group', 'sex', 'asthma', 'liver_mild', 'renal',
                         'pulmonary', 'neurological', 'liver_mod_severe', 'malignant_neoplasm',
                         'outcome', 'time_to_outcome')
initial <- training[, imputationvariables]
imputation <- ImputationTraining(training = initial)
training_ <- ImputationProcessing(imputation = imputation, imputationdata = initial)
training_$outcome_date <- training_$admission_date + training_$time_to_outcome
training_$censored <- dplyr::if_else(training_$outcome == 'Death', true = 0, false = 1)
training_$deceased <- dplyr::if_else(training_$outcome == 'Death', true = 1, false = 0)

# ensure that only missing date cells have imputed values
states <- is.na(training_$outcome_date != training$outcome_date)
unknown <- is.na(training$outcome_date)
all(states == unknown)




