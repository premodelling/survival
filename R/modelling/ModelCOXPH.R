# Title     : ModelCOXPH.R
# Objective : survival::coxph
# Created by: greyhypotheses
# Created on: 09/01/2022

ModelCOXPH <- function (training_, upload = TRUE) {

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

    load(file.path(pathstr, 'unboosted'))

  } else {

    # a directory for the resulting models
    if (file.exists(paths = file.path(pathstr, 'unboosted'))) {
      base::unlink(file.path(pathstr, 'unboosted'), recursive = TRUE)
    }

    # modelling
    initial <- coxph(formula = formula , data = training_, model = TRUE)
    unboosted <- step(object = initial)
    save(unboosted, file = file.path(pathstr, 'unboosted'), ascii = TRUE, compress = TRUE, compression_level = 7)

  }

  return(unboosted)


}