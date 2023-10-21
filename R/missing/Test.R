# Title     : Test.R
# Objective : Test
# Created by: greyhypotheses
# Created on: 21/01/2022


source(file = 'R/missing/MechanismTest.R')


Test <- function (data) {

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

  calculations <- data.frame(t(details)) %>%
    mutate(na_of = row.names(.)) %>%
    select(na_of, associations, elements)


  settings <- data.frame(na_of = c('sex', 'asthma', 'liver_mild', 'renal', 'pulmonary',
                                   'neurological', 'liver_mod_severe', 'malignant_neoplas'),
                         name = c('Sex', 'Asthma', 'Liver Disease, Mild', 'Renal Disease', 'Pulmonary Disease',
                                  'Neurological Disorder', 'Liver Disease, Moderate/Severe', 'Malignant Neoplasm'))

  calculations <- dplyr::left_join(x = calculations, y = settings, by = 'na_of')

  return(calculations[, c('name', 'associations')])


}