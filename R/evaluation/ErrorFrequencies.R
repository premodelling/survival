# Title     : ErrorFrequecies.R
# Objective : The error matrix frequencies
# Created by: greyhypotheses
# Created on: 06/01/2022

ErrorFrequencies <- function (thresholds, truth, probability) {

  #' True Positive
  #'
  #' @param threshold: a threshold value in the range [0  1]
  TP <- function (threshold) {
    predictions <- as.factor(as.numeric(probability > threshold))
    series <- as.numeric(truth == 1 & predictions == 1)
    return(sum(series))
  }

  #' False Negative
  #'
  #' @param threshold: a threshold value in the range [0  1]
  FN <- function (threshold) {
    predictions <- as.factor(as.numeric(probability > threshold))
    series <- as.numeric(truth == 1 & predictions == 0)
    return(sum(series))
  }

  #' True Negative
  #'
  #' @param threshold: a threshold value in the range [0  1]
  TN <- function (threshold) {
    predictions <- as.factor(as.numeric(probability > threshold))
    series <- as.numeric(truth == 0 & predictions == 0)
    return(sum(series))
  }

  #' False Positive
  #'
  #' @param threshold: a threshold value in the range [0  1]
  FP <- function (threshold) {
    predictions <- as.factor(as.numeric(probability > threshold))
    series <- as.numeric(truth == 0 & predictions == 1)
    return(sum(series))
  }

  frequencies <- data.frame(threshold = thresholds) %>%
    mutate('TP' = as.numeric(lapply(threshold, FUN = TP)),
           'FN' = as.numeric(lapply(threshold, FUN = FN)),
           'TN' = as.numeric(lapply(threshold, FUN = TN)),
           'FP' = as.numeric(lapply(threshold, FUN = FP)))

  return(frequencies)

}

