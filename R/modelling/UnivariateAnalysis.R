# Title     : UnivariateAnalysis.R
# Objective : Univariate Analysis
# Created by: greyhypotheses
# Created on: 19/01/2022


source(file = 'R/modelling/Univariate.R')
source(file = 'R/functions/ExtensiveStudyData.R')

UnivariateAnalysisTraining <- function () {

  dataframes <- ExtensiveStudyData(upload = TRUE)
  training_ <- dataframes$training_

  analysis <- Univariate(blob = training_)
  diagnostics <- analysis$diagnostics

  # names, labels, indices
  diagnostics$label <- row.names(diagnostics)
  row.names(diagnostics) <- NULL
  diagnostics <- diagnostics %>% arrange(label)

  settings <- data.frame(label = c('age_group70-79', 'age_group60-69', 'age_group50-59', 'age_group90+', 'age_group40-49',
                                   'age_group30-39', 'sexFemale', 'asthmayes', 'liver_mildyes', 'renalyes', 'pulmonaryyes',
                                   'neurologicalyes', 'liver_mod_severeyes', 'malignant_neoplasmyes'),
                         name = c('Age Group 70 - 79', 'Age Group 60 - 69', 'Age Group 50 - 59', 'Age Group 90+',
                                  'Age Group 40 - 49', 'Age Group 30 - 39', 'Sex Female', 'Asthma Yes',
                                  'Liver Disease, (Mild) Yes', 'Renal Disease Yes', 'Pulmonary Disease Yes',
                                  'Neurological Disorder Yes', 'Liver Disease, (Moderate, severe) Yes', 'Malignant Neoplasm Yes'))

  diagnostics <- dplyr::left_join(x = diagnostics, y = settings, by = 'label')
  diagnostics <- diagnostics %>%
    select(name, Coefficient, HR, HRLCI, HRUCI, p_value, proportionality)

  return(diagnostics)


}


UnivariateAnalysisData <- function () {

  dataframes <- ExtensiveStudyData(upload = TRUE)
  data_ <- dataframes$data_

  analysis <- Univariate(blob = data_)
  diagnostics <- analysis$diagnostics



}


UnivariateAnalysisCC <- function () {

  dataframes <- ExtensiveStudyData(upload = TRUE)
  data <- dataframes$data

  C <- data[complete.cases(data),]
  analysis <- Univariate(blob = C)
}













