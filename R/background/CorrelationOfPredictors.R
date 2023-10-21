# Title     : CorrelationOfPredictors.R
# Objective : Correlation measires of categorical predictors
# Created by: greyhypotheses
# Created on: 02/01/2022


source(file = 'R/functions/IsCorrelatedCC.R')


#' Correlation of predictors
#'
#' @description determines the degree of correlation between predictors via Cramer's V
#'
#' @param predictors: the categorical predictors
#' @param data:
#'
CorrelationOfPredictors <- function (predictors, data) {

  # the correlation of each variable with all others
  design <- mapply(FUN = IsCorrelatedCC, reference = predictors, MoreArgs = list(variables = predictors, frame = data))
  measures <- dplyr::bind_rows(design)

  # matrix graph, colors = c('#E46726', 'white', 'black'),
  ggcorrplot::ggcorrplot(corr = measures,
                         type = 'upper',
                         ggtheme = ggplot2::theme_minimal(),
                         outline.color = 'white',
                         lab = TRUE,
                         lab_size = 3,
                         lab_col = 'grey',
                         digits = 2) +
    scale_fill_gradient2(breaks = c(0, 1), limit = c(0, 1)) +
    labs(fill = "Cramer's V\n")

}