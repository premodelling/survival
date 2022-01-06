# Title     : ErrorMetrics.R
# Objective : The error matrix metrics
# Created by: greyhypotheses
# Created on: 06/01/2022


#' ErrorMetrics
#'
#' @description calculates a range of error matrix metrics
#'
#' @param frame: a data frame consisting of thresholds & error frequencies
#' @param N: the number of observations, for validation steps
#'
ErrorMetrics <- function (frame, N) {

  #' Precision, Positive Predictive Value
  precision <- function () {
    return(frame$TP / (frame$TP + frame$FP))
  }

  #' Negative Predictive Value
  npv <- function () {
    return(frame$TN / (frame$TN + frame$FN))
  }

  #' Sensitivity, True Positive Rate, Recall, Hit Rate
  sensitivity <- function () {
    return(frame$TP / (frame$TP + frame$FN))
  }

  #' False Negative Rate, Miss rate
  #' FN/(TP + FN)
  fnr <- function () {
    return(1 - sensitivity())
  }

  #' Specificity, True Negative Rate, Specificity
  specifity <- function() {
    return(frame$TN / (frame$TN + frame$FP))
  }

  #' False Positive Rate
  #' FP/(TN + FP)
  fpr <- function () {
    return(1 - specifity())
  }

  #' f1 Score, f Score, f measure
  fscore<- function () {
    ppv <- precision()
    tpr <- sensitivity()

    return(2 * (ppv * tpr)/(ppv + tpr))
  }

  #' Youden's J Statistic, Youden's Index
  youden <- function () {
    return(sensitivity() + specifity() - 1)
  }

  #' Matthews Correlation Coefficient, φ Coefficient
  matthews <- function () {
    values <- sqrt(precision() * sensitivity() * specifity() * npv()) -
      sqrt((1 - precision()) * fnr() * fpr() * (1 - npv()))
    return(values)
  }

  #' Balanced Accuracy
  balanced_accuracy <- function () {
    return( 0.5 * (sensitivity() + specifity()) )
  }

  #' Standard Accuracy
  #' denominator: if is.data.table(frame)
  #'
  #'    frame[, n := rowSums(.SD), .SDcols = !'threshold']
  #'
  standard_accuracy <- function () {

    # numerator
    numerator <- frame$TP + frame$TN

    # denominator: if is.data.frame(frame)
    denominator <- frame %>% select(TP, FN, TN, FP) %>% rowSums()

    # inspection: this will be different if the errorfrequencies have associated cost values
    if (any(denominator != N)) {
      stop('the sum of frequencies per threshold is not equal to the number of observations ')
    } else {
      return(numerator/denominator)
    }

  }

  calculations <- frame %>%
    select(threshold) %>%
    mutate(precision = precision(), sensitivity = sensitivity(), fnr = fnr(), specifity = specifity(),
           fpr = fpr(), fscore =fscore(), youden = youden(), matthews = matthews(),
           balanced_accuracy = balanced_accuracy(), standard_accuracy = standard_accuracy())

  return(calculations)

}