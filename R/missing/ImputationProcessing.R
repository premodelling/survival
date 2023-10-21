# Title     : ImputationProcessing.R
# Objective : Imputation Processing
# Created by: greyhypotheses
# Created on: 05/01/2022


#' @param imputation: the object of imputation values courtesy of mice()
#' @param imputationdata: the data set used by mice()
ImputationProcessing <- function (imputation, imputationdata) {

  # which variables were imputations applied to
  methods <- imputation$method
  methods <- methods[!(methods == '')]
  variates <- names(methods)

  # unclass factors for arithmetic
  release <- function (field, piece) {
    unclass(piece[, field])
  }

  # For each of the variables that underwent imputation ... factor & integer variables oly
  for (variate in variates) {

    estimates <- dplyr::bind_rows(imputation$imp[variate])

    if (class(estimates$`1`) == 'factor') {

      numerals <- mapply(FUN = release, field = names(estimates), MoreArgs = list(piece = estimates))
      reference <- data.frame(median = matrixStats::rowMedians(x = numerals))
      row.names(reference) <- row.names(estimates)

      labels_ <- levels(estimates$`1`)
      levels_ <- seq(1, length(labels_))

      reference$labels <- factor(x = reference$median, levels = levels_, labels = labels_)
      imputationdata[row.names(reference), variate] <- reference$labels

    } else {

      reference <- data.frame(median = as.integer(round(matrixStats::rowMedians(x = as.matrix(estimates)))))
      row.names(reference) <- row.names(estimates)
      imputationdata[row.names(reference), variate] <- reference$median

    }


  }

  return(imputationdata)
  
}
