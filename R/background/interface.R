# Title     : interface.R
# Objective : Interface
# Created by: greyhypotheses
# Created on: 06/01/2022


#' Programs
source(file = 'R/functions/StudyData.R')

source(file = 'R/background/AgeGroupSexEvent.R')
source(file = 'R/background/DiseaseNumbers.R')
source(file = 'R/background/DiseaseQuotients.R')
source(file = 'R/background/CorrelationOfPredictors.R')

source(file = 'R/background/QuotientsDistributions.R')
source(file = 'R/background/TimeDistributions.R')
source(file = 'R/background/TimeVariance.R')


#' The data set
#'
data <- StudyData()
str(data)


#' Illustration: Per outcome type, the distribution of time_to_outcome by age group & sex
#' ... Do the boxes overlap?
#' ... Is the median line of one box above the third-quartile-line of another?
#' ... Completely non-overlapping boxes?
#'
AgeGroupSexEvent(original = data)


#' Illustration: For a specified comorbidity, the number of sufferers by age group and sex
#' ... Although the absolute numbers differ between the sexes, the pattern of
#'     sufferers-by-age-group is similar between the sexes.
#'
DiseaseNumbers(field = 'pulmonary', original = data)


#' Illustration: Per comorbidity, the yes/no ...
#'
DiseaseQuotients(field = 'pulmonary', original = data)


#' Correlation
#'
CorrelationOfPredictors(
  predictors = c('age_group', 'sex', 'asthma', 'liver_mild', 'renal', 'pulmonary',
                 'neurological', 'liver_mod_severe', 'malignant_neoplasm'),
  data = data)


#' event/outcome distribution across age groups
#'
QuotientsCfAgeGroups(data = data)


#' distribution of events/outcomes per age group
#'
QuotientsCfEvents(data = data)


#' The Distribution Patterns of Event Times
#'
TimeDensityCensor(data = data)
TimeDensityOutcome(data = data)
TimeHistogramCensor(data = data)
TimeHistogramOutcome(data = data)


#' Illustrating Spreads
#'
TimeVariance(data = data)
