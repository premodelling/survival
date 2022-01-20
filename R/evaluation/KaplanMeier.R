# Title     : KaplanMeier.R
# Objective : Kaplan Meier
# Created by: greyhypotheses
# Created on: 16/01/2022



#' Programs
#'
source(file = 'R/functions/ExtensiveStudyData.R')
source(file = 'R/evaluation/SurvivalCurve.R')


KaplanMeier <- function () {

  # Upload the study data, excluding implausible observations, and its imputed form
  dataframes <- ExtensiveStudyData(upload = TRUE)
  data <- dataframes$data
  data_ <- dataframes$data_

  # complete case
  complete <- data %>%
    dplyr::filter(!is.na(time_to_outcome) & !is.na(deceased))

  # the survival curves
  left <- SurvivalCurve(
    data = complete,
    caption = str_glue('A. {nrow(complete)} records'))
  right <- SurvivalCurve(
    data = data_,
    caption = str_glue('B. {nrow(data_)} records'))

  left + patchwork::plot_spacer() + right

}

