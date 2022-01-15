# Title     : main
# Objective : Playground
# Created by: greyhypotheses
# Created on: 29/12/2021



#' Programs
#'
source(file = 'R/functions/StudyData.R')
source(file = 'R/demographics/Is.R')



#' The data set
#'
data <- StudyData()
str(data)


#' Is()
#'
#' Is the study's population demographics representative
#' of England's population demographics
#'
Is()
