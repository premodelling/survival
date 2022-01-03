# Title     : isrepresentative.R
# Objective : Determine whether the study demographics are representative of the demographics of the target population
# Created by: greyhypotheses
# Created on: 03/01/2022

IsRepresentative <- function () {

  source(file = 'R/functions/StudyData.R')
  source(file = 'R/demographics/aggregatingons.R')


  # Study
  data <- StudyData()

  distribution <- data %>%
    select(age_group, sex) %>%
    group_by(age_group, sex) %>%
    summarise(N = n(), .groups = 'drop')

  distribution <- tidyr::pivot_wider(data = distribution, id_cols = 'age_group',
                                     names_from = 'sex', values_from = 'N')
  distribution <- dplyr::rename(distribution, male = Male, female = Female, unknown = 'NA')

  study <- distribution %>%
    select(!'unknown') %>%
    data.frame()
  study$quotient <- study$female / study$male


  # Country
  ons <- AggregatingONS()
  ons$quotient <- ons$female / ons$male


}