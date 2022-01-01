# Title     : FrequenciesTable.R
# Objective : The frequencies of a field's elements
# Created by: greyhypotheses
# Created on: 31/12/2021

#' @param data: The column of a data frame
#' @param label: A label for the data's elements
FrequenciesTable <- function (data, label = 'elements') {

  numbers <- data.frame(table(data, useNA = 'always'))
  names(numbers) <- c(label, 'frequency')
  numbers <- numbers[order(numbers$frequency, decreasing = TRUE),]

  names(numbers)[names(numbers) == 'frequency'] <- paste0('frequency, ', sum(numbers$frequency))

  return(numbers)

}