# Title     : Univariate.R
# Objective : Univariate
# Created by: greyhypotheses
# Created on: 17/01/2022


Univariate <- function (blob) {

  # the fields
  fields <- c( 'age_group', 'sex', 'asthma', 'liver_mild', 'renal', 'pulmonary',
               'neurological', 'liver_mod_severe', 'malignant_neoplasm')

  # a formula per prospective predictor
  formulae <- sapply(fields,
                     function (x) as.formula(paste('Surv(time = time_to_outcome, event = deceased) ~', x)))

  # the cox model of each
  models <- lapply(X = formulae, FUN = function(formula){coxph(formula = formula, data = blob)})

  # a function for extracting diagnostics of interest
  estimates <- function (model) {

    # a model
    obj <- summary(object = model)
    
    # the coefficient diagnostics
    C <- obj$coefficients
    indices <- rownames(C)
    interval <- obj$conf.int

    # proportionality assumption
    proportionality <- cox.zph(fit = model)
    variate <- names(model$xlevels)
    evidence <- proportionality$table[variate, 'p']

    # summarising
    frame <- data.frame(Coefficient = C[, 'coef'], HR = C[, 'exp(coef)'],
                        HRLCI = interval[, 'lower .95'], HRUCI = interval[, 'upper .95'],
                        p_value = C[, 'Pr(>|z|)'], proportionality = evidence)
    row.names(frame) <- indices

    return(frame)
    
  }  
  est <- lapply(X = models, FUN = function (model){estimates(model = model)})
  diagnostics <- dplyr::bind_rows(est)
  
  return(list(diagnostics = diagnostics, models = models))
}







