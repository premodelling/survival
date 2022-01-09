# Title     : ModelCOXPH.R
# Objective : survival::coxph
# Created by: greyhypotheses
# Created on: 09/01/2022

ModelCOXPH <- function () {

  # the model object directory path
  pathstr <- file.path(getwd(), 'warehouse', 'training', 'models')
  if (!dir.exists(paths = pathstr)) {
    dir.create(path = pathstr, showWarnings = TRUE, recursive = TRUE)
  }


  # formula
  formula <- Surv(time = training_$time_to_outcome, event = training_$deceased) ~ age_group + sex + asthma +
    liver_mild + renal + pulmonary + neurological + liver_mod_severe + malignant_neoplasm


  # bootstrapping


  # upload or run
  if (upload) {

    # Load
    load(file.path(pathstr, 'unboosted'))

  } else {

    # A directory for the resulting models
    if (file.exists(paths = file.path(pathstr, 'unboosted'))) {
      base::unlink(file.path(pathstr, 'unboosted'), recursive = TRUE)
    }

    unboosted <- coxph(formula = formula , data = training_)
    save(unboosted, file = file.path(pathstr, 'unboosted'), ascii = TRUE, compress = TRUE, compression_level = 7)

  }

  return



}