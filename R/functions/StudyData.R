# Title     : StudyData.R
# Objective : Read the ISARIC Study Data
# Created by: greyhypotheses
# Created on: 30/12/2021

source(file = 'R/functions/FrequenciesTable.R')

StudyData <- function () {

  data <- read.csv(file = 'data/sars.csv', na.strings = c('NA', 'Not specified', 'unknown', 'Unknown'))

  # admission date
  if (anyNA(data$admission_date)) {
    missing <- sum(is.na(data$admission_date))
    print(paste0('There are missing admission dates: ', missing, ' missing'))
  }
  data$admission_date <- as.Date(data$admission_date)

  # age groups
  data$age <- factor(x = data$age, levels = c('80-89', '70-79', '60-69', '50-59', '90+', '40-49', '30-39'))
  names(data)[names(data) == 'age'] <- 'age_group'
  FrequenciesTable(data = data$age, label = 'age')

  # sex
  data$sex <- factor(x = data$sex, levels = c('Male', 'Female'), exclude = NULL)
  FrequenciesTable(data = data$sex, label = 'sex')

  # asthma (diagnosed by a physician)
  data$asthma <- factor(x = data$asthma, levels = c('no', 'yes'), exclude = NULL)
  FrequenciesTable(data = data$asthma, label = 'asthma')

  # mild liver disease
  data$liver_mild <- factor(x = data$liver_mild, levels = c('no', 'yes'), exclude = NULL)
  FrequenciesTable(data = data$liver_mild, label = 'liver_mild')

  # chronic kidney disease
  data$renal <- factor(x = data$renal, levels = c('no', 'yes'), exclude = NULL)
  FrequenciesTable(data = data$renal, label = 'renal')

  # chronic pulmonary disease (not asthma)
  data$pulmonary <- factor(x = data$pulmonary, levels = c('no', 'yes'), exclude = NULL)
  FrequenciesTable(data = data$pulmonary, label = 'pulmonary')

  # chronic neurological disorder
  data$neurological <- factor(x = data$neurological, levels = c('no', 'yes'), exclude = NULL)
  FrequenciesTable(data = data$neurological, label = 'neurological')

  # moderate or severe liver disease
  data$liver_mod_severe <- factor(x = data$liver_mod_severe, levels = c('no', 'yes'), exclude = NULL)
  FrequenciesTable(data = data$liver_mod_severe, label = 'liver_mod_severe')

  # malignant neoplasm (cancer of the?)
  data$malignant_neoplasm <- factor(x = data$malignant_neoplasm, levels = c('no', 'yes'), exclude = NULL)
  FrequenciesTable(data = data$malignant_neoplasm, label = 'malignant_neoplasm')

  # outcome
  data$outcome <- dplyr::if_else(data$outcome == 'Transfered', true = 'Transferred', false = data$outcome)
  data$outcome <- factor(x = data$outcome,
                         levels = c('Discharged alive', 'Death', 'Transferred',
                                    'Remains in hospital', 'Palliative discharge'),
                         exclude = NULL)
  FrequenciesTable(data = data$outcome, label = 'outcome')


  # right censored: 1, 0
  # outcome: alive, deceased
  data$censored <- dplyr::if_else(data$outcome == 'Death', true = 0, false = 1)
  table(data$outcome, data$censored)

  # outcome date
  data$outcome_date <- as.Date(data$outcome_date)
  if (anyNA(data$outcome_date)) {
    missing <- sum(is.na(data$outcome_date))
    print(paste0('There are missing outcome dates: ', missing, ' missing'))
  }

  # time_to_event
  data$time_to_outcome <- as.integer(data$outcome_date - data$admission_date)

  return(data)

}





