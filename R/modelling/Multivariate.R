# Title     : Multivariate.R
# Objective : Multivariate
# Created by: greyhypotheses
# Created on: 17/01/2022


Multivariate <- function(blob) {
  
  # formula
  formula <- Surv(time = blob$time_to_outcome, event = blob$deceased) ~ age_group + sex + asthma +
    liver_mild + renal + pulmonary + neurological + liver_mod_severe + malignant_neoplasm


  # model
  model <- coxph(formula = formula , data = blob, model = TRUE, x = TRUE, y = TRUE)

  # diagnostics of coefficients
  obj <- summary(object = model)
  C <- data.frame(obj$coefficients)
  interval <- data.frame(obj$conf.int)

  # proportionality
  proportionality <- cox.zph(fit = model)
  evidence <- data.frame(proportionality$table[, 'p'])
  names(evidence) <- 'proportionality'
  row.names(evidence) <- c('age_group', 'sexFemale', 'asthmayes', 'liver_mildyes', 'renalyes',
                           'pulmonaryyes', 'neurologicalyes', 'liver_mod_severeyes', 'malignant_neoplasmyes', 'GLOBAL')

  # summarise
  frame <- cbind(C[, c('coef', 'exp.coef.')], interval[, c('lower..95', 'upper..95')]) %>%
    mutate(p_value = C[, 'Pr...z..'])
  frame <- base::merge(x = frame, y = evidence, by = 0, all.x = TRUE)

  # age group
  indices <- startsWith(frame$Row.names, prefix = 'age_group')
  frame[indices, 'proportionality'] <- evidence[row.names(evidence) == 'age_group',]

  # field names
  names(frame) <- c('label', 'Coefficient', 'HR', 'HRLCI', 'HRUCI', 'p_value', 'proportionality')

  return(list(diagnostics = frame, model = model))

}

