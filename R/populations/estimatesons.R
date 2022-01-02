# Title     : estimatesons.R
# Objective : Extract the demographic data of interest from ONS Populations Estimates releases
# Created by: greyhypotheses
# Created on: 02/01/2022


EstimatesONS <- function () {

  sex <- c('Female', 'Male')

  get_ <- function (sex) {

    # read
    data <- readxl::read_xls(path = 'data/ukpopestimatesmid2020on2021geography.xls',
                             sheet = stringr::str_glue('MYE2 - {sex}s'), range = 'B8:CQ12')

    # focus on series of interest
    data <- data %>%
      filter(Name == 'ENGLAND') %>%
      select(!c('Name', 'Geography', 'All ages'))

    # set the row name to 'sex'
    data$sex <- sex
    data <- tibble::column_to_rownames(data, var = 'sex')

    return(data)

  }
  items <- lapply(X = sex, FUN = get_)

  # structuring
  readings <- dplyr::bind_rows(items)

  # traspose
  readings <- as.data.frame(t(readings))
  readings$age <- row.names(readings)
  row.names(readings) <- NULL


}