# Title     : Adjusted.R
# Objective : Adjusted
# Created by: greyhypotheses
# Created on: 19/01/2022


Adjusted <- function (excerpt, time, status, tau, keys) {

  K <- c(keys, 'age_group_median')


  # adjusted RMST function
  adjusted <- function (key) {

    # modelling
    arm <- excerpt[, key]
    covariates <- excerpt[, K[K != key]]
    obj <- rmst2(time = time, status = status, arm = arm, tau = tau, covariates = covariates)

    # results
    reference <- obj
    estimates <- reference$adjusted.result
    contrast <- estimates[row.names(estimates) == 'RMST (arm=1)-(arm=0)', ]

    # summary
    return(data.frame(est_ = contrast['Est.'], lower_ = contrast['lower .95'],
                      upper_ = contrast['upper .95'], p_ = contrast['p'], row.names = key))

  }


  # calculate per factor
  calculations <- dplyr::bind_rows(lapply(X = keys, FUN = function (x){adjusted(x)}))


  return(calculations)


}