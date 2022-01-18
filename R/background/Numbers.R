# Title     : Numbers.R
# Objective : Numbers
# Created by: greyhypotheses
# Created on: 16/01/2022


#' Deaths
DeceasedNumbers <- function (data) {

  deaths <- table(data$deceased, useNA = 'always')
  return(data.frame(yes = deaths['1'],
                    no = deaths['0'],
                    unknown = deaths[length(deaths)],
                    row.names = 'deceased'))
}

#' Demographics
DemographicsNumbers <- function (data) {

  demographics <- data %>%
    select(sex, age_group) %>%
    group_by(sex, age_group) %>%
    summarise(N = n(), .groups = 'drop') %>%
    pivot_wider(id_cols = age_group, names_from = sex, values_from = N) %>%
    data.frame()

  demographics$Total <- select(demographics, !age_group) %>% rowSums()
  names(demographics) <- c('Age Group', 'Male', 'Female', 'Unknown', 'Total')

  return(demographics)

}

#' Diseases
DiseaseNumbers <- function (data) {

  disease <- c('asthma', 'liver_mild', 'liver_mod_severe',
            'malignant_neoplasm', 'neurological', 'pulmonary', 'renal')
  name <- c('Asthma', 'Mild Liver Disease', 'Moderate, Severe Liver Disease',
            'Malignant Neoplasm', 'Neurological Disorder', 'Pulmonary Disease', 'Renal Disease')
  labels <- data.frame(disease = disease, Comorbidity = name)

  diseases <- data %>%
    select(asthma, liver_mild, renal, pulmonary, neurological, liver_mod_severe, malignant_neoplasm) %>%
    gather(key = 'disease', value = 'Class') %>%
    group_by(disease, Class) %>%
    summarise(N = n(), .groups = 'drop') %>%
    pivot_wider(id_cols = 'disease', names_from = 'Class', values_from = 'N') %>%
    data.frame()
  diseases$Total <- select(diseases, !disease) %>% rowSums()
  names(diseases) <- c('disease', 'No', 'Yes', 'Unknown', 'Total')

  diseases <- dplyr::left_join(diseases, labels, by = 'disease') %>%
    select(Comorbidity, No, Yes, Unknown, Total)

  return(diseases)

}



