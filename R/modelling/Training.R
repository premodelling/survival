# Title     : Training.R
# Objective : Training
# Created by: greyhypotheses
# Created on: 06/01/2022

Training <- function (training_) {


  # formula
  formula <- Surv(time = training_$time_to_outcome, event = training_$deceased) ~ age_group + sex + asthma + 
    liver_mild + renal + pulmonary + neurological + liver_mod_severe + malignant_neoplasm

  
  # Core
  model_core <- coxph(formula = formula , data = training_)
  summary(object = model_core)
  ggforest(model = model_core, data = training_)


  # Boosted: encompassing internal validation
  model <- mboost::glmboost(formula, data = training_,
                   family = mboost::CoxPH(), control = mboost::boost_control(mstop = 500))
  
  internal <- mboost::survFit(model)


}