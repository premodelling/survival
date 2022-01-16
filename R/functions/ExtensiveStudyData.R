# Title     : ExtensiveStudyData.R
# Objective : Imputed Data
# Created by: greyhypotheses
# Created on: 16/01/2022

source(file = 'R/functions/StudyData.R')
source(file = 'R/functions/TemporalSplit.R')
source(file = 'R/missing/ImputationStep.R')

ImputedData <- function(upload = TRUE) {

  # The data set
  data <- StudyData()


  # Splitting
  dataframes <- TemporalSplit(data = data)
  training <- dataframes$training
  testing <- dataframes$testing
  rm(dataframes)


  # all variables for training phase
  variables <- c('admission_date', 'age_group', 'sex', 'asthma', 'liver_mild', 'renal',
                 'pulmonary', 'neurological', 'liver_mod_severe', 'malignant_neoplasm',
                 'outcome', 'time_to_outcome')


  # imputation
  #
  #
  # ...  re-calculate: censored & outcome_date, and add deceased
  # ...  the imputation variables exclude: outcome_date (date can't be used
  #      in the MICE models, time_to _outcome in lieu), censored (it is a project
  #      variable created for analysis & graphing purposes)
  training_ <- ImputationStep(initial = training[, variables],
                              phase = 'training', upload = upload)

  testing_ <- ImputationStep(initial = testing[, variables],
                             phase = 'testing', upload = upload)

  return(list(data = data, training_ = training_, testing_ = testing_))

}