# Title     : ImputationStep.R
# Objective : Imputation Step
# Created by: greyhypotheses
# Created on: 06/01/2022


source(file = 'R/missing/Imputation.R')
source(file = 'R/missing/ImputationProcessing.R')



#' ImputationStep
#'
#' @param initial: the data set with missing data
#' @param phase: training or testing
#'
ImputationStep <- function (initial, phase, upload = TRUE) {


  # ascertain phase value
  if (!(phase %in% c('training', 'testing'))) {
    stop("The phase parameter must be a string equal to 'training' or 'testing'")
  }


  # the imputation object directory path
  pathstr <- file.path(getwd(), 'warehouse', phase, 'imputation')


  # upload or run
  if (upload) {

    load(file.path(pathstr, 'imputation'))

  } else {

    # a directory for the resulting imputation object of estimates/calculations
    if (dir.exists(paths = pathstr)) {
      base::unlink(pathstr, recursive = TRUE)
    }
    dir.create(path = pathstr, showWarnings = TRUE, recursive = TRUE)

    # run model
    imputation <- Imputation(data = initial)

    # save imputation object
    save(imputation, file = file.path(pathstr, 'imputation'), ascii = TRUE, compress = TRUE, compression_level = 7)

  }


  # process
  processed <- ImputationProcessing(imputation = imputation, imputationdata = initial)
  
  
  # if training
  if (phase == 'training') {
    # outcome date
    processed$outcome_date <- processed$admission_date + processed$time_to_outcome

    # ensure that only missing date cells have imputed values
    unavailable <- is.na(processed$outcome_date != initial$outcome_date)
    if (!all(unavailable == is.na(initial$outcome_date))) {
      stop("Only missing 'time_to_outcome' values should be estimated")
    }

    # the censor & deceased fields
    processed$censored <- dplyr::if_else(processed$outcome == 'Death', true = 0, false = 1)
    processed$deceased <- dplyr::if_else(processed$outcome == 'Death', true = 1, false = 0)
  }


  return(processed)

}