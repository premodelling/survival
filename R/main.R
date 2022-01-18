# Title     : main
# Objective : Playground
# Created by: greyhypotheses
# Created on: 29/12/2021



#' Programs
#'
source(file = 'R/functions/ExtensiveStudyData.R')
source(file = 'R/demographics/Is.R')



#' The data
#'
dataframes <- ExtensiveStudyData(upload = TRUE)
data <- dataframes$data
training_ <- dataframes$training_
testing_ <- dataframes$testing_
data_ <- dataframes$data_
rm(dataframes)

str(data)



#' Is()
#'
#' Is the study's population demographics representative
#' of England's population demographics
#'
Is()
