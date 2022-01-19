# Title     : interface.R
# Objective : Interface for restricted mean surivival time analysis
# Created by: greyhypotheses
# Created on: 06/01/2022



#' Programs
#'
source(file = 'R/functions/ExtensiveStudyData.R')
source(file = 'R/restricted/AgeGroupMedians.R')
source(file = 'R/restricted/Unadjusted.R')
source(file = 'R/restricted/Adjusted.R')


# data
dataframes <- ExtensiveStudyData(upload = TRUE)
data_ <- dataframes$data_


# for univariate RMST
keys <- c('female', 'asthma', 'liver_mild', 'renal', 'pulmonary',
          'neurological', 'liver_mod_severe', 'malignant_neoplasm')


# focus on
excerpt <- data_


# the binary fields must be converted to numeric fields
binary <- c('asthma', 'liver_mild', 'renal', 'pulmonary', 'neurological', 'liver_mod_severe', 'malignant_neoplasm')
for (name in binary) {
  excerpt[, name] <- dplyr::if_else(excerpt[, name] == 'yes', true = 1, false = 0, missing = NULL)
}


# sex
excerpt$female <- dplyr::if_else(excerpt$sex == 'Female', true = 1, false = 0, missing = NULL)


# age group median
excerpt <- AgeGroupMedians(blob = excerpt)


# the time & status
time <- excerpt$time_to_outcome
status <- excerpt$deceased


# global tau
times <- function(key) {
  value <- min(max(excerpt[excerpt[, key] == 1, 'time_to_outcome']),
      max(excerpt[excerpt[, key] == 0, 'time_to_outcome']))
  return(value)
}
minima <- as.numeric(lapply(X = keys, FUN = function (x){times(x)}))
tau <- min(minima)


# unadjusted
undaj <- Unadjusted(excerpt = excerpt, time = time, status = status, tau = tau, keys = keys)


# adjusted
adj <- Adjusted(excerpt = excerpt, time = time, status = status, tau = tau, keys = keys)




# diagnostics
diagnostics <- merge(x = undaj, y = adj, by = 0, all.x = TRUE)
names(diagnostics)[names(diagnostics) == 'Row.names'] <- 'label'


settings <- data.frame(label = c('female', 'asthma', 'liver_mild', 'renal', 'pulmonary',
                                 'neurological', 'liver_mod_severe', 'malignant_neoplasm'),
                       name = c('Female', 'Asthma',
                                'Liver Disease (Mild)', 'Renal Disease', 'Pulmonary Disease',
                                'Neurological Disorder', 'Liver Disease (Moderate, Severe)', 'Malignant Neoplasm Y'))

dplyr::left_join(x = diagnostics, y = settings, by = 'label')