# Title     : AgeGroupMedians.R
# Objective : Age Group Medians
# Created by: greyhypotheses
# Created on: 19/01/2022


AgeGroupMedians <- function (blob) {

  # data frame of age groups
  estimates <- data.frame(lower = seq(30, 90, 10), upper = seq(39, 99, 10))
  estimates$age_group <- paste(estimates$lower, estimates$upper, sep = '-')
  estimates$age_group <- str_replace(string = estimates$age_group, pattern = '90-99', replacement = '90+')

  # their medians
  estimates <- estimates %>%
    mutate(age_group_median = rowMedians(as.matrix(estimates[, c('lower', 'upper')])))

  # associate each age group element of blob with its mean
  blob <- dplyr::left_join(x = blob,
                           y = estimates[, c('age_group', 'age_group_median')],
                           by = 'age_group')

  return(blob)
  
}