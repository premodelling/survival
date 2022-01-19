# Title     : Unadjusted.R
# Objective : Unadjusted
# Created by: greyhypotheses
# Created on: 19/01/2022


Unadjusted <- function (excerpt, time, status, tau, keys) {

  # unadjusted RMST function
  unadjusted <- function (key) {

    # modelling
    arm <- excerpt[, key]
    obj <- survRM2::rmst2(time = time, status = status, arm = arm, tau = tau)

    # results
    reference <- obj
    estimates <- reference$unadjusted.result
    contrast <- estimates[row.names(estimates) == 'RMST (arm=1)-(arm=0)', ]

    # summary
    return(data.frame(est = contrast['Est.'], lower = contrast['lower .95'],
                      upper = contrast['upper .95'], p = contrast['p'], row.names = key))

  }

  # calculate per factor
  calculations <- dplyr::bind_rows(lapply(X = keys, FUN = function (x){unadjusted(x)}))


  return(calculations)


}