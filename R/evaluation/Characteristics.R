# Title     : Characteristics.R
# Objective : Characteristics
# Created by: greyhypotheses
# Created on: 16/01/2022

source(file = 'R/functions/StudyData.R')

Characteristics <- function () {

  data <- StudyData()

  # Mortality
  deaths <- table(data$deceased, useNA = 'always')
  rbind(deaths, round(prop.table(deaths), digits = 3))

  # Demographics
  demographics <- data %>%
    select(sex, age_group) %>%
    group_by(sex, age_group) %>%
    summarise(N = n()) %>%
    pivot_wider(id_cols = age_group, names_from = sex, values_from = N) %>%
    data.frame()
  demographics

  # Diseases
  diseases <- data %>%
    select(asthma, liver_mild, renal, pulmonary, neurological, liver_mod_severe, malignant_neoplasm) %>%
    gather(key = 'disease', value = 'Class') %>%
    group_by(disease, Class) %>%
    summarise(N = n(), .groups = 'drop') %>%
    pivot_wider(id_cols = 'disease', names_from = 'Class', values_from = 'N') %>%
    data.frame()

}
