# Title     : main
# Objective : Exploration
# Created by: greyhypotheses
# Created on: 29/12/2021


# programs
source(file = 'R/functions/StudyData.R')
source(file = 'R/preliminaries/DiseaseNumbers.R')
source(file = 'R/preliminaries/DiseaseQuotients.R')
source(file = 'R/preliminaries/CorrelationOfPredictors.R')
source(file = 'R/preliminaries/AgeGroupSexEvent.R')

source(file = 'R/functions/TemporalSplit.R')
source(file = 'R/missing/Imputation.R')
source(file = 'R/missing/Pattern.R')
source(file = 'R/missing/MechanismTest.R')

source(file = 'R/events/TimeDistributions.R')
source(file = 'R/events/TimeVariance.R')




#' The data set
#'
data <- StudyData()
str(data)



#' Explorations
AgeGroupSexEvent()
DiseaseQuotients(field = 'pulmonary')
DiseaseNumbers(field = 'pulmonary')



#' Correlation
#'
CorrelationOfPredictors(
  predictors = c('age_group', 'sex', 'asthma', 'liver_mild', 'renal', 'pulmonary',
                 'neurological', 'liver_mod_severe', 'malignant_neoplasm'),
  data = data)



#' The Distribution Patterns of Event Times
#'
TimeDensityCensor(data = data)
TimeDensityOutcome(data = data)
TimeHistogramCensor(data = data)
TimeHistogramOutcome(data = data)



#' Illustrating Spreads
#'
TimeVariance(data = data)



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

# run the MICE model
imputation <- ImputationTraining(training = training)

# which variables were imputations applied to
methods <- imputation$method
methods <- methods[!(methods == '')]
variates <- names(methods)

# unclass factors for arithmetic
release <- function (field, piece) {
  unclass(piece[, field])
}

# For each of the variables that underwent imputation ...
# Create a copy of training ...
for (variate in variates) {

  estimates <- dplyr::bind_rows(imputation$imp[variate])
  numerals <- mapply(FUN = release, field = names(estimates), MoreArgs = list(piece = estimates))
  reference <- data.frame(median = matrixStats::rowMedians(x = numerals))
  row.names(reference) <- row.names(estimates)

  # attributes(estimates$`1`)$levels
  # reference$median <- factor(x = reference$median, levels = attributes(estimates$`1`)$levels)
  # trainingcopy[row.names(reference), variate] <- reference$median

}





