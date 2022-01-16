# Title     : KaplanMeier.R
# Objective : Kaplan Meier
# Created by: greyhypotheses
# Created on: 16/01/2022



#' Programs
#'
source(file = 'R/functions/ImputedData.R')
source(file = 'R/evaluation/SurvivalCurve.R')


KaplanMeier <- function () {

  # Upload the study data, excluding implausible observations, and its imputed form
  dataframes <- ImputedData(upload = TRUE)
  data <- dataframes$data
  training_ <- dataframes$training_
  testing_ <- dataframes$testing_

  # complete case
  complete <- data %>%
    dplyr::filter(!is.na(time_to_outcome) & !is.na(deceased))

  # imputed
  imputed <- dplyr::bind_rows(training_, testing_)

  # the survival curves
  left <- SurvivalCurve(
    data = complete,
    caption = str_glue('A. {nrow(complete)} records'))
  right <- SurvivalCurve(
    data = imputed,
    caption = str_glue('B. {nrow(imputed)} records'))

  left + right

}

