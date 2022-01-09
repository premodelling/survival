# Title     : Training.R
# Objective : Training
# Created by: greyhypotheses
# Created on: 06/01/2022

Training <- function (training_, upload = TRUE) {


  # the model object directory path
  pathstr <- file.path(getwd(), 'warehouse', 'training', 'models')
  if (!dir.exists(paths = pathstr)) {
    dir.create(path = pathstr, showWarnings = TRUE, recursive = TRUE)
  }


  # formula
  formula <- Surv(time = training_$time_to_outcome, event = training_$deceased) ~ age_group + sex + asthma + 
    liver_mild + renal + pulmonary + neurological + liver_mod_severe + malignant_neoplasm


  # upload or run
  if (upload) {

    # Load
    load(file.path(pathstr, 'boosted'))

  } else {

    # A directory for the resulting models
    if (file.exists(paths = file.path(pathstr, 'boosted'))) {
      base::unlink(file.path(pathstr, 'boosted'), recursive = TRUE)
    }

    # Boosted: encompassing internal validation
    boosted <- mboost::glmboost(formula, data = training_,
                                family = mboost::CoxPH(), control = mboost::boost_control(mstop = 500))
    save(boosted, file = file.path(pathstr, 'boosted'), ascii = TRUE, compress = TRUE, compression_level = 7)

  }

  return(boosted)

}