# Title     : interface.R
# Objective : Interface
# Created by: greyhypotheses
# Created on: 06/01/2022



#' Programs
#'
source(file = 'R/functions/StudyData.R')
source(file = 'R/missing/Pattern.R')
source(file = 'R/missing/MechanismTest.R')



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

calculations <- data.frame(t(details)) %>%
  mutate(na_of = row.names(.))
calculations %>%
  select(na_of, associations, elements)
