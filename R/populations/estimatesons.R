# Title     : estimatesons.R
# Objective : Extract the demographic data of interest from ONS Populations Estimates releases
# Created by: greyhypotheses
# Created on: 02/01/2022


#' EstimatesONS
#'
#' Reads the female &male population of England encoded in 'data/ukpopestimatesmid2020on2021geography.xls
#'
EstimatesONS <- function () {

  # Sex
  sex <- c('Female', 'Male')

  # Data reader
  get_ <- function (sex) {

    # read
    data <- readxl::read_xls(path = 'data/ukpopestimatesmid2020on2021geography.xls',
                             sheet = stringr::str_glue('MYE2 - {sex}s'), range = 'B8:CQ12')

    # focus on the series of interest
    data <- data %>%
      filter(Name == 'ENGLAND') %>%
      select(!c('Name', 'Geography', 'All ages'))

    # set the row name to 'sex'
    data$sex <- sex
    data <- tibble::column_to_rownames(data, var = 'sex')

    return(data)
  }
  items <- lapply(X = sex, FUN = get_)


  # Structuring
  readings <- dplyr::bind_rows(items)
  readings <- as.data.frame(t(readings))


  # After transpoing the age fields become data frame indices.  Herein, the ages are assigned to a field
  readings$age <- row.names(readings)
  row.names(readings) <- NULL

  return(readings)

}


