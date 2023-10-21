# Title     : Numbers.R
# Objective : Numbers
# Created by: greyhypotheses
# Created on: 16/01/2022


#' Deaths
DeceasedNumbers <- function (data) {

  deaths <- table(data$deceased, useNA = 'always')
  deceased <- data.frame(variable = 'Deceased', yes = deaths['1'], no = deaths['0'],
                         unknown = deaths[length(deaths)], total = sum(deaths))

  deceased <- deceased %>%
    mutate(yes_ = yes/total, no_ = no/total, unknown_ = unknown/total)

  deceased <- deceased %>%
    select(variable, yes, no, unknown, yes_, no_, unknown_)

  return(deceased)


}


#' Demographics
DemographicsNumbers <- function (data) {

  # numbers
  demographics <- data %>%
    select(sex, age_group) %>%
    group_by(sex, age_group) %>%
    summarise(N = n(), .groups = 'drop') %>%
    pivot_wider(id_cols = age_group, names_from = sex, values_from = N) %>%
    data.frame()

  # female ?
  demographics$Total <- select(demographics, !age_group) %>% rowSums()
  names(demographics) <- c('variable', 'no', 'yes', 'unknown', 'total')

  # percentages
  demographics <- demographics %>%
    mutate(no_ = no/total, yes_ = yes/total, unknown_ = unknown/total)
  demographics <- demographics %>%
    select(variable, yes, no, unknown, yes_, no_, unknown_)

  return(demographics)

}


#' Diseases
DiseaseNumbers <- function (data) {

  disease <- c('asthma', 'liver_mild', 'liver_mod_severe',
            'malignant_neoplasm', 'neurological', 'pulmonary', 'renal')
  name <- c('Asthma', 'Mild Liver Disease', 'Moderate, Severe Liver Disease',
            'Malignant Neoplasm', 'Neurological Disorder', 'Pulmonary Disease', 'Renal Disease')
  labels <- data.frame(disease = disease, variable = name)

  diseases <- data %>%
    select(asthma, liver_mild, renal, pulmonary, neurological, liver_mod_severe, malignant_neoplasm) %>%
    gather(key = 'disease', value = 'Class') %>%
    group_by(disease, Class) %>%
    summarise(N = n(), .groups = 'drop') %>%
    pivot_wider(id_cols = 'disease', names_from = 'Class', values_from = 'N') %>%
    data.frame()
  diseases$Total <- select(diseases, !disease) %>% rowSums()
  names(diseases) <- c('disease', 'no', 'yes', 'unknown', 'total')

  diseases <- dplyr::left_join(diseases, labels, by = 'disease') %>%
    select(variable, no, yes, unknown, total)

  diseases <- diseases %>%
    mutate(yes_ = yes/total, no_ = no/total, unknown_ = unknown/total)

  diseases <- diseases %>%
    select(variable, yes, no, unknown, yes_, no_, unknown_)

  return(diseases)

}


#' A summary of the calculations above
SpecialNumbers <- function (data) {

  blank <- data.frame(variable = '', yes = NA, no = NA, unknown = NA, yes_ = NA, no_ = NA, unknown_ = NA)

  deceased <- DeceasedNumbers(data = data)
  deceased_ <- data.frame(variable = 'DEATHS', yes = NA, no = NA, unknown = NA,
                          yes_ = NA, no_ = NA, unknown_ = NA)

  diseases <- DiseaseNumbers(data = data)
  diseases_ <- data.frame(variable = 'COMORBIDITIES', yes = NA, no = NA, unknown = NA,
                          yes_ = NA, no_ = NA, unknown_ = NA)

  demographics <- DemographicsNumbers(data = data)
  demographics_ <- data.frame(variable = 'AGE GROUP, FEMALE', yes = NA, no = NA, unknown = NA,
                              yes_ = NA, no_ = NA, unknown_ = NA)

  return(rbind(deceased_, deceased, blank,
               diseases_, diseases, blank,
               demographics_, demographics, blank))

}


