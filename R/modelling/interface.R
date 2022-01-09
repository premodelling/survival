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


# training
training_ <- ImputationStep(initial = training[, variables],
                            phase = 'training', upload = TRUE)
unboosted <- ModelCOXPH(training_ = training_, upload = FALSE)

# testing
evaluating_ <- testing[complete.cases(testing), ]
testing_ <- ImputationStep(initial = testing[, variables],
                           phase = 'testing', upload = FALSE)




# Play
internal <- predict(object = unboosted, type = 'expected')
internal <- data.frame(expected = internal)
internal$lp <- predict(object = unboosted, type = 'lp')
internal$risk_score <- predict(object = unboosted, type = 'risk')
internal <- cbind(internal, as.data.frame(predict(object = unboosted, type = 'terms')))
internal$survival_probability <- exp(-internal$expected)









