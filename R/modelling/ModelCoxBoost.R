# Title     : ModelCoxBoost.R
# Objective : Experimenting
# Created by: greyhypotheses
# Created on: 08/01/2022


#' Experiment
#'
#' @description Considering the papers by Wynants, et al (2020), Spooner, et al (2020), and others, an
#'              exploration of boosted survival analysis
#'
ModelCoxBoost <- function (training_) {


  T <- training_

  # logical forms of the comorbidities fields
  diseases <- c('asthma', 'liver_mild', 'renal',
                'pulmonary', 'neurological', 'liver_mod_severe', 'malignant_neoplasm')
  for (disease in diseases) {
    T[, disease] <- as.logical(dplyr::if_else(T[, disease] == 'yes', true = 1, false = 0))
  }

  # logical female instead of sex
  T$female <- as.logical(dplyr::if_else(T[, 'sex'] == 'female', true = 1, false = 0))

  # the one-hot-encoding of the age_group field
  age_groups <- as.data.frame(caret::class2ind(x = T$age_group))
  for (age_group in names(age_groups)) {
    T[, age_group] <- as.logical(age_groups[, age_group])
  }

  # hence
  covariates <- c('80-89', '70-79', '60-69', '50-59', '90+', '40-49', '30-39', 'female',
                  'asthma', 'liver_mild', 'renal', 'pulmonary', 'neurological', 'liver_mod_severe',
                  'malignant_neoplasm')

  x <- matrix(T[, covariates], ncol = length(covariates))
  x <- unlist(x)
  dim(x) <- c(nrow(T), length(covariates))

  boosted <- CoxBoost::CoxBoost(time = T$time_to_outcome, status = T$censored, x = x, stepno = 9,
                                criterion = 'pscore', x.is.01 = TRUE, return.score = FALSE)

}




