# Title     : AggregatingStudy.R
# Objective : TODO
# Created by: greyhypotheses
# Created on: 03/01/2022


AggregatingStudy <- function () {

  source(file = 'R/functions/StudyData.R')

  # Study
  data <- StudyData()

  # Aggregate by age group and sex
  distribution <- data %>%
    select(age_group, sex) %>%
    group_by(age_group, sex) %>%
    summarise(N = n(), .groups = 'drop')

  # Re-structure
  distribution <- tidyr::pivot_wider(data = distribution, id_cols = 'age_group',
                                     names_from = 'sex', values_from = 'N')
  distribution <- dplyr::rename(distribution, male = Male, female = Female, unknown = 'NA')

  # return
  return(distribution)


}