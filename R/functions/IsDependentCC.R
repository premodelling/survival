# Title     : IsDependentCC.R
# Objective : Dependency analysis w.r.t. between categorical variables
# Created by: greyhypotheses
# Created on: 01/01/2022


IsDependentCC <- function(variables, reference, frame) {
  #' Returns a table of test statistic, p, & Cramér's V values
  #'
  #' @param variables: The list of categorical variables that will be compared with the reference variable
  #' @param reference: The categorial reference variable
  #' @param frame: The table of data

  estimates <- data.table()
  for (variable in variables) {

    writeLines(paste0('\n\nCase: ', variable))
    frequencies <- table(frame[[variable]], frame[[reference]])
    print(frequencies)

    # Are the elements of the fields independent?
    # Null Hypothesis: Independent elements
    chisquared <- chisq.test(frequencies, simulate.p.value = TRUE, B = 5000)

    # What is the degree of association between the elements of the fields?
    cramercinq <- rcompanion::cramerV(frequencies, y = NULL, ci = FALSE, conf = 0.95, type = 'bca',
                                      R = 1000, histogram = FALSE, digits = 4, bias.correct = TRUE)

    # Add the estimates to the table of estimates
    calculations <- data.table(field = variable, chi_squared_statistic = chisquared$statistic,
                               pvalue = chisquared$p.value, cramerv = cramercinq)
    estimates <- rbind(estimates, calculations)
  }

  return(estimates)

}