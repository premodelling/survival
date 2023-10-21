# Title     : ModelXGB.R
# Objective : Experimenting
# Created by: greyhypotheses
# Created on: 08/01/2022

ModelXGB <- function (training_) {


  T <- training_


  # logical forms of the comorbidities fields
  diseases <- c('asthma', 'liver_mild', 'renal',
                'pulmonary', 'neurological', 'liver_mod_severe', 'malignant_neoplasm')
  for (disease in diseases) {
    T[, disease] <- dplyr::if_else(T[, disease] == 'yes', true = 1, false = 0)
  }


  # logical female instead of sex
  T$female <- dplyr::if_else(T[, 'sex'] == 'female', true = 1, false = 0)


  # the one-hot-encoding of the age_group field
  age_groups <- as.data.frame(caret::class2ind(x = T$age_group))
  for (age_group in names(age_groups)) {
    T[, age_group] <- age_groups[, age_group]
  }


  # the required xgb time-to--event structure
  T$label <- dplyr::if_else(T$deceased == 1, true = T$time_to_outcome, false = -T$time_to_outcome)


  # hence
  covariates <- c('80-89', '70-79', '60-69', '50-59', '90+', '40-49', '30-39', 'female',
                  'asthma', 'liver_mild', 'renal', 'pulmonary', 'neurological', 'liver_mod_severe',
                  'malignant_neoplasm')
  design <- matrix(T[, covariates], ncol = length(covariates))
  design <- unlist(design)
  dim(design) <- c(nrow(T), length(covariates))


  # modelling
  params <- list(booster = 'gblinear',
                 lambda = 50,
                 objective='survival:cox',
                 eval_metric='cox-nloglik')
  estimates <- xgb.train(params = params,
                         data = xgb.DMatrix(data = design, label = as.vector(T[, 'label'])),
                         nrounds = 35)


}