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
  demographics <- table(data$sex, data$age_group, useNA = 'always')
  t(demographics)
  t(round(prop.table(demographics), digits = 3))
  brief <- data %>%
    select(sex, age_group) %>%
    group_by(sex, age_group) %>%
    summarise(N = n()) %>%
    pivot_wider(id_cols = age_group, names_from = sex, values_from = N) %>%
    data.frame()
  brief

  # Diseases
  diseases <- c('asthma', 'liver_mild', 'renal', 'pulmonary', 'neurological', 'liver_mod_severe', 'malignant_neoplasm')
  frequencies <- function (field) {
    N <- table(data[, field], useNA = 'always')
    fractions <- round(prop.table(N), digits = 2)
    frame <- data.frame(rbind(N, fractions))
    row.names(frame) <- c(field, 'fractions')
    return(frame)
  }
  details <- lapply(X = diseases, FUN = frequencies)
  dplyr::bind_rows(details)

}
