# Title     : SurivalCurve.R
# Objective : SurvivalCurve
# Created by: greyhypotheses
# Created on: 10/01/2022


#' @param data: training data
SurvivalCurve <- function (data) {

  null <- survfit(formula = Surv(time = data$time_to_outcome, event = data$deceased) ~ 1,
                  data = data)
  T <- data.frame(time = null$time, probability = null$surv, lower = null$lower, upper = null$upper)


  ggplot(data = T, mapping = aes(x = time)) +
    geom_ribbon(mapping = aes(ymin = lower, ymax = upper), fill = 'steelblue', alpha = 0.25) +
    geom_line(mapping = aes(y = probability), alpha = 0.65, size = 0.5, linetype = 2, colour = 'black') +
    theme_minimal() +
    theme(panel.grid.minor = element_blank(),
          panel.grid.major = element_line(size = 0.1),
          plot.title = element_text(hjust = 0.5),
          plot.caption = element_text(hjust = 0, vjust = 5, size = 11, colour = 'black'),
          axis.text.x = element_text(size = 11, angle = 90), axis.text.y = element_text(size = 11),
          axis.title.x = element_text(size = 13), axis.title.y = element_text(size = 13)) +
    xlab(label = '\ntime\n') +
    ylab(label = '\nprobability\n') +
    labs(caption = str_wrap(string = 'Strata: All', width = 60) )

}