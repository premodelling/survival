# Title     : aggregatingons.R
# Objective : Aggregating ONS population values
# Created by: greyhypotheses
# Created on: 02/01/2022

source(file = 'R/populations/estimatesons.R')

#' AggregatingONS
#'
#' @description Determines the population numbers per age groups of interest
#'
AggregatingONS <- function () {

  # get the population data
  readings <- EstimatesONS()


  # grouping the ages
  readings[readings$age == '90+', 'age'] <- '90'
  readings$age <- as.numeric(x = readings$age)
  breaks <- seq(-1, 99, 10)
  readings$group <- cut(x = readings$age, labels = FALSE, breaks = breaks, right = TRUE)


  # age groups
  ages <- data.frame(left = seq(0, 90, 10), right = seq(9, 99, 10))
  ages$age_group <- paste(ages$left, ages$right, sep = '-')
  ages[ages$age_group == '90-99', 'age_group'] <- '90+'
  ages$age_group <- as.factor(ages$age_group)
  ages$group <- as.integer(row.names(ages))


  # hence, appending age group labels
  readings <- dplyr::left_join(x = readings, y = ages[, c('age_group', 'group')], by = 'group')


  # aggregate by age group
  aggregates <- readings %>%
    select(age_group, Female, Male) %>%
    group_by(age_group) %>%
    summarise(female = sum(Female), male = sum(Male))

}